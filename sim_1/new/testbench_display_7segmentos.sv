`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: testbench_display_7segmentos
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Testbench del módulo display_7segmentos
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_display_7segmentos;

//Entradas
reg clk = 0, reset = 0;
reg [20:0] codigo_BCD = 0;
//Salidas
wire [7:0] anodo;
wire [6:0] catodo;

//Unidad Bajo Prueba (UUT)
display_7segmentos uut (
    .clk(clk), .reset(reset),
    .codigo_BCD(codigo_BCD),
    .anodo(anodo),
    .catodo(catodo)
    );

//Variables para hacer las pruebas
always #5 clk = ~clk;

initial
begin
    codigo_BCD = 21'b000000000000000101000;
    
    #10 $finish;
    
end

endmodule
