`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: display_7segmentos
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Despliega el código binario de la multiplicación en el display de 7 segmentos en forma decimal.
// 
//////////////////////////////////////////////////////////////////////////////////


module display_7segmentos(
    input clk, //100 MHz
    input reset,
    input [15:0] bin,
    output [7:0] anodo,
    output [6:0] catodos
    );
    
    wire reloj_actualizacion;
    wire contador_actualizar;
    wire [3:0] digito;
    
    divisor_reloj Reloj (clk, reset, reloj_actualizacion);
    contador_actualizacion Contador (reloj_actualizacion, reset, contador_actualizar);
    
    control_anodo Anodo (contador_actualizar, anodo);
    control_BCD BCD (bin, contador_actualizar, digito);
    catodos_BCD Catodos(digito, catodos);
    
endmodule
