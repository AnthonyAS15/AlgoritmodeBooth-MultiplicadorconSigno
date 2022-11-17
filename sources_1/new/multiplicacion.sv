`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: multiplicacion
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Realiza el cálculo de la multiplicación con el algoritmo de Booth a partir de las entradas.
//              Esto lo hace a partir de una máquina de estados
// 
//////////////////////////////////////////////////////////////////////////////////

//Estructura que controla la multiplicación a partir de la máquina de estados.
typedef struct {
    logic load_A;
    logic load_B;
    logic load_add;
    logic shift_HQ_LQ_Q_1;
    logic add_sub;
} mult_control_t;

//Está encargado de realizar la multiplicación tomando en cuenta la máquina de estados.
module multiplicacion(
    input clk, rst,
    input reg valid,
    input logic [7:0] A, B,
    output logic [15:0] Mult,
    output reg done
    );
    
    //Creación de la estructura de control.
    mult_control_t mult_control;
    
    //Últimos dos bits del producto.
    logic [1:0] Q_LSB;
    
    //Máquina de estados.
    maquina_estados FSM (clk, rst, valid, Q_LSB, mult_control, done);
    
    //Multiplicación por medio del algoritmo de Booth.
    mult_with_no_sm Booth (clk, rst, A, B, mult_control, Q_LSB, Mult);
    
    
endmodule

//Máquina de estados para utilizar el algoritmo de Booth.
module maquina_estados (
    input clk, rst,
    input reg valid,
    input [1:0] Q_LSB,
    output mult_control_t mult_control,
    output reg done
    );
    
    //Cantidad de iteraciones a realizar.
    localparam N = 4'd8; //8 iteraciones en total, ya que los números a multiplicar son de 8 bits.
    
    //Codificación de estados.
    parameter
        Esperar = 3'b000,
        Inicio = 3'b001,
        Agregar = 3'b010,
        Sumar = 3'b011,
        Restar = 3'b100,
        Shift = 3'b101,
        Comprobar = 3'b110;
    
    //Registro del estado actual.
    logic [2:0] estado;
    logic [3:0] iteraciones = N;
    
    //Estado siguiente.
    always @(posedge clk)
    begin
        if (rst)
            estado <= Esperar;
        else
        begin
            case (estado)
                Esperar:
                begin
                    if (valid)
                        estado <= Inicio;
                end
                Inicio:
                begin
                    if (Q_LSB[1] == Q_LSB[0])
                        estado <= Shift;
                    else
                        estado <= Agregar;
                end
                Agregar:
                begin 
                    if (Q_LSB[1] == 0)
                        estado <= Sumar;
                    else
                        estado <= Restar;
                end
                Sumar:
                    estado <= Shift;
                Restar:
                    estado <= Shift;
                Shift:
                    estado <= Comprobar;
                Comprobar:
                begin
                    if (iteraciones == N)
                    begin
                        estado <= Esperar;
                    end
                    else
                    begin
                        estado <= Inicio;
                    end
                end
                default:
                    estado <= Esperar;
            endcase
        end
    end
    
    //Salidas
    always @(negedge clk)
    begin
        mult_control.load_A <= 0;
        mult_control.load_B <= 0;
        mult_control.add_sub <= 0;
        mult_control.load_add <= 0;
        mult_control.shift_HQ_LQ_Q_1 <= 0;
        case (estado)
            Esperar:
            begin
                mult_control.load_A <= 1;
                mult_control.load_B <= 1;
                done <= 1'b0;
            end
            Inicio:
            begin 
                mult_control.load_A <= 0;
                mult_control.load_B <= 0;
            end
            Agregar:
            begin 
                mult_control.load_A <= 0;
                mult_control.load_B <= 0;
            end
            Sumar:
            begin
                mult_control.add_sub <= 1;
                mult_control.load_add <= 1;
            end
            Restar:
            begin
                mult_control.add_sub <= 0;
                mult_control.load_add <= 1;
            end
            Shift:
                mult_control.shift_HQ_LQ_Q_1 <= 1;
            Comprobar:
            begin
                mult_control.shift_HQ_LQ_Q_1 <= 0;
                
                if (iteraciones == 4'd0)
                begin
                    done <= 1'b1;
                    iteraciones <= N;
                end
                else
                begin
                    done <= 1'b0;
                    iteraciones <= iteraciones -4'd1;
                end
            end
        endcase
    end
            
endmodule


module mult_with_no_sm#(
    parameter N = 8
    ) (
        input logic clk,
        input logic rst,
        input logic [N-1:0] A,
        input logic [N-1:0] B,
        input mult_control_t mult_control,
        output logic [1:0] Q_LSB,
        output logic [2*N-1:0] Y
    );
    
    logic [N-1:0] M;
    logic [N-1:0] adder_sub_out;
    logic [2*N:0] shift = 0;
    logic [N-1:0] HQ;
    logic [N-1:0] LQ;
    logic Q_1;
    
    //reg_M
    always_ff@ (posedge clk)
    begin
        if (rst)
            M <= 0;
        else
        begin
            if (mult_control.load_A)
            begin
                M <= A;
            end
            else
            begin
                M <= M;
            end
        end
    end
    
    // adder / sub
    always_comb
    begin
        if (mult_control.add_sub)
            adder_sub_out = HQ + M;
        else
            adder_sub_out = HQ - M;
    end
    
    // shiftregisters
    always_comb
    begin
        Y = {HQ,LQ} ;
        HQ = shift [2*N:N+1];
        LQ = shift [N:1];
        Q_1 = shift [0];
        Q_LSB = {LQ[0], Q_1};
    end
    
    always_ff@ (posedge clk)
    begin
        if (rst)
            shift <= 0;
        else if (mult_control.shift_HQ_LQ_Q_1)
            // arithmeticshift
            shift <= $signed (shift)>>>1;
        else
        begin
            if (mult_control.load_B)
                shift [N:1] <= B;
            if (mult_control.load_add)
                shift [2*N:N+1] <= adder_sub_out;
        end
    end
endmodule

