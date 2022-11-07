`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: tesetbench_lectura
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Testbench del módulo lectura
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_lectura;

//Entradas
reg CLK100MHZ = 0, reset = 0;
reg [7:0] A = 0, B = 0;
reg pb_entrada = 0;
//Salidas
wire [15:0] LED;
wire LED_reset, LED_pb;
wire [7:0] multiplicador, multiplicando;
wire logic pb_salida;

//Unidad Bajo Prueba (UUT)
lectura uut (
    .CLK100MHZ(CLK100MHZ), .reset(reset),
    .A(A), .B(B),
    .pb_entrada(pb_entrada),
    .LED(LED),
    .LED_reset(LED_reset), .LED_pb(LED_pb),
    .multiplicador(multiplicador), .multiplicando(multiplicando),
    .pb_salida(pb_salida)
    );

//Variables para hacer las pruebas
reg [7:0] i = 0;
reg [7:0] j = 0;
always #5 CLK100MHZ = ~CLK100MHZ;

initial
begin
    A = 0;
    B = 0;
    
    for (i=0; i<6; i=i+1)
    begin
        #10 A = i;
        for (j=0; j<6; j=j+1)
        #10 B = j;
    end
    
    #10 $finish;
    
end

endmodule
