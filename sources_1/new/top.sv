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
    
    wire [7:0] multiplicador, multiplicando;
    logic pb_salida;
    logic [7:0] A_sinrebote, B_sinrebote;
    reg valid, done;
    logic [15:0] Mult;
    logic [20:0] codigo_BCD;
    
    lectura Lectura (CLK100MHZ, reset, A, B, pb_entrada, LED, LED_reset, LED_pb, multiplicador, multiplicando, pb_salida);
    
    always @*
    begin
        if (pb_salida)
        begin
            valid = pb_salida;
            A_sinrebote = multiplicador;
            B_sinrebote = multiplicando;
        end
        else
        begin
            valid = valid;
            A_sinrebote = A_sinrebote;
            B_sinrebote = B_sinrebote;
        end
    end
    
    multiplicacion Multiplicacion (CLK100MHZ, reset, valid, A_sinrebote, B_sinrebote, Mult, done);

    display_7segmentos Display (CLK100MHZ, reset, codigo_BCD, anodo, catodo);
    
endmodule
