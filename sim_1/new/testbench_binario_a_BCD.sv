`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: testbench_binario_a_BCD
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Testbench del módulo binario_a_BCD
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_binario_a_BCD;

//Entradas
reg clk = 0, reset = 0;
reg [14:0] bin;
reg inicio = 0;
//Salidas
wire [19:0] codigo_BCD;
wire done;

//Unidad Bajo Prueba (UUT)
binario_a_BCD uut (
    .clk(clk), .reset(reset),
    .bin(bin),
    .inicio(inicio),
    .codigo_BCD(codigo_BCD),
    .done(done)
    );

//Variables para hacer las pruebas
always #5 clk = ~clk;

initial
begin
    inicio = 1;
    bin = 15'b 000000000011100;
    
    #10 $finish;
    
end

endmodule
