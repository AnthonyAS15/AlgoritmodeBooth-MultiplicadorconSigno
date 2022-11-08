`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del M�dulo: multiplicacion
// Nombre del Proyecto: Algoritmo de Booth
// Descripci�n: Realiza el c�lculo de la multiplicaci�n con el Algoritmo de Booth a partir de las entradas.
//              Esto lo hace a partir de una m�quina de estados
// 
//////////////////////////////////////////////////////////////////////////////////

//Estructura que controla la multiplicaci�n a partir de la m�quina de estados.
typedef struct {
    logic load_A;
    logic load_B;
    logic load_add;
    logic shift_HQ_LQ_Q_1;
    logic add_sub;
} mult_control_t;

//Est� encargado de realizar la multiplicaci�n tomando en cuenta la m�quina de estados.
module multiplicacion(
    input clk, rst,
    input reg valid,
    input logic [7:0] A, B,
    output logic [15:0] Mult,
    output reg done = 0
    );
    
    //Creaci�n de la structura de control.
    mult_control_t mult_control;
    
    //�ltimos dos bits del producto.
    logic [1:0] Q_LSB;
    
    //M�quina de estados.
    maquina_estados FSM (clk, rst, valid, Q_LSB, mult_control, done);
    
    //Multiplicaci�n por medio del algoritmo de Booth.
    mult_with_no_sm Booth (clk, rst, A, B, mult_control, Q_LSB, Mult);
    
endmodule

//M�quina de estados para utilizar el algoritmo de Booth.
module maquina_estados (
    input clk, rst,
    input reg valid,
    input [1:0] Q_LSB,
    output mult_control_t mult_control,
    output reg done
    );
    
    //Cantidad de iteraciones a realizar.
    localparam N = 5'b10000;
    
    //Codificaci�n de estados.
    parameter
    Esperar = 3'b000,
    Inicio = 3'b001,
    Agregar = 3'b010,
    Sumar = 3'b011,
    Restar = 3'b100,
    Shift = 3'b101,
    Comprobar = 3'b110;
    
    //Registro del estado actual.
    logic [2:0] estado = 0;
    logic [4:0] iteraciones = N;
    
    //Estado siguiente
    always @(posedge clk or posedge rst)
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
                    else
                        estado <= Esperar;
                end
                Inicio:
                begin
                    if (Q_LSB[1] == Q_LSB[0])
                        estado <= Shift;
                    else if (Q_LSB[1] != Q_LSB[0])
                        estado <= Agregar;
                end
                Agregar:
                begin 
                    if (Q_LSB[1] == 0)
                        estado <= Sumar;
                    else if (Q_LSB[1] == 1)
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
            endcase
        end
    end
    
    //Salidas
    always @(estado)
    begin
        case (estado)
            Esperar:
            begin
                mult_control.load_A <= 1;
                mult_control.load_B <= 1;
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
                mult_control.add_sub <= 0;
                mult_control.load_add <= 1;
            end
            Restar:
            begin
                mult_control.add_sub <= 1;
                mult_control.load_add <= 1;
            end
            Shift:
                mult_control.shift_HQ_LQ_Q_1 <= 1;
                iteraciones <= iteraciones -1;
            Comprobar:
            begin
                mult_control.shift_HQ_LQ_Q_1 <= 1;
                
                if (iteraciones == 0)
                begin
                    done <= 1;
                    iteraciones <= N;
                end
                else
                    done <= 0;
            end
        endcase
    end
            
endmodule


module mult_with_no_sm#(
    parameter N = 8
    ) (
        input logic clk ,
        input logic rst ,
        input logic [N-1:0] A,
        input logic [N-1:0] B,
        input mult_control_t mult_control,
        output logic [1:0] Q_LSB,
        output logic [2*N-1:0] Y
    );
    
    logic [N-1:0] M;
    logic [N-1:0] adder_sub_out;
    logic [2*N:0] shift;
    logic [N-1:0] HQ;
    logic [N-1:0] LQ;
    logic Q_1;
    
    //reg_M
    always_ff@ (posedge clk or posedge rst)
    begin
        if (rst)
            M <= 'b0 ;
        else
            M <= (mult_control.load_A)? A : M;
    end
    
    // adder / sub
    always_comb
    begin
        if (mult_control.add_sub)
            adder_sub_out = M + HQ;
        else
            adder_sub_out = M - HQ;
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
    
    always_ff@ (posedge clk or posedge rst)
    begin
        if (rst)
            shift <= 1'b0 ;
        else if (mult_control.shift_HQ_LQ_Q_1)
            // arithmeticshift
            shift <= $signed (shift)>>>1;
        else
        begin
            if (mult_control.load_B)
                shift [N:1] <= B;
            else if (mult_control.load_add)
                shift [2*N:N+1] <= adder_sub_out;
        end
    end
endmodule

