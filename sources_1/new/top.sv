`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: top
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Archivo top del proyecto
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input CLK100MHZ, reset,
    input [7:0] A, B,
    input pb_entrada,
    output [15:0] LED,
    output LED_reset, LED_pb,
    output [7:0] anodo,
    output [6:0] catodo
    );
    
    logic [7:0] multiplicador, multiplicando;
    logic pb_salida;
    logic [7:0] A_sinrebote, B_sinrebote;
    reg valid, done1;
    logic [15:0] Mult;
    logic signo;
    logic [14:0] bin;
    logic [19:0] codigo_BCD_sin_signo;
    logic [20:0] codigo_BCD;
    reg done2;
    
    lectura Lectura (CLK100MHZ, reset, A, B, pb_entrada, LED, LED_reset, LED_pb, multiplicador, multiplicando, pb_salida);
    
    always @(posedge CLK100MHZ)
    begin
        if (pb_salida)
        begin
            valid <= pb_salida;
                A_sinrebote <= multiplicador;
                B_sinrebote <= multiplicando;
        end
        else if (reset)
        begin
            valid <= 0;
            A_sinrebote <= 0;
            B_sinrebote <= 0;
        end
        else
        begin
            A_sinrebote <= A_sinrebote;
            B_sinrebote <= B_sinrebote;
        end
    end
    
    multiplicacion Multiplicacion (CLK100MHZ, reset, valid, A_sinrebote, B_sinrebote, Mult, done1);
    
    always @(posedge CLK100MHZ)
    begin
        if (done1)
        begin
            signo <= Mult[15];
            if (signo)
                bin <= -Mult[14:0]+1;
            else
                bin <= Mult[14:0];
        end
        else if (reset)
        begin
            signo <= 0;
            bin <= 0;
        end
        else
        begin
            signo <= signo;
            bin <= bin;
        end
    end
    
    binario_a_BCD BCD (CLK100MHZ, reset, done1, bin, codigo_BCD_sin_signo, done2);
    
    always @(posedge CLK100MHZ)
    begin
        if (done2)
            codigo_BCD <= {signo, codigo_BCD_sin_signo};
        else if (reset)
            codigo_BCD <= 0;
        else
            codigo_BCD <= codigo_BCD;
    end

    display_7segmentos Display (CLK100MHZ, reset, codigo_BCD, anodo, catodo);
    
endmodule
