`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: testbench_algoritmo_booth
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Testbench del módulo top
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_algoritmo_booth;

//Entradas
reg CLK100MHZ = 0, reset = 0;
reg [7:0] A = 0, B = 0;
reg pb_entrada = 0;

//Salidas
wire [15:0] LED;
wire LED_reset, LED_pb;
wire [7:0] anodo;
wire [6:0] catodo;

//Unidad Bajo Prueba (UUT)
top uut (
    .CLK100MHZ(CLK100MHZ), .reset(reset),
    .A(A), .B(B),
    .pb_entrada(pb_entrada),
    .LED(LED),
    .LED_reset(LED_reset), .LED_pb(LED_pb),
    .anodo(anodo), .catodo(catodo)
    );

//Variables para hacer las pruebas
always #5 CLK100MHZ = ~CLK100MHZ;

initial
begin
    A = 8'd8;
    B = 8'd7;
    pb_entrada = 1;
    
    #10 $finish;
    
end

endmodule
