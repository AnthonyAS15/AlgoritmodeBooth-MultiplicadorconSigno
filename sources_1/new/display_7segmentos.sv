`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: display_7segmentos
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Despliega el código binario de la multiplicación en el display de 7 segmentos en forma decimal
// 
//////////////////////////////////////////////////////////////////////////////////


module display_7segmentos(
    input clk,
    input reset,
    input [20:0] codigo_BCD,
    output [7:0] anodo,
    output [6:0] catodo
    );
    
    wire reloj_actualizacion;
    wire [2:0] contador_actualizar;
    wire [3:0] digito;
    
    divisor_reloj Divisor_Reloj (clk, reset, reloj_actualizacion);
    contador_actualizacion Contador (reloj_actualizacion, reset, contador_actualizar);
    
    control_anodo Anodo (contador_actualizar, anodo);
    control_BCD Control_BCD (codigo_BCD, contador_actualizar, digito);
    catodos_BCD Catodos(digito, catodo);
    
endmodule
