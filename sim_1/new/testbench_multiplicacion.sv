`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: tesetbench_lectura
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Testbench del módulo multiplicacion
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench_multiplicacion;

//Entradas
reg clk = 0, rst = 0;
reg valid = 0;
reg [7:0] A = 0, B = 0;
//Salidas
wire [15:0] Mult;
wire done;

//Unidad Bajo Prueba (UUT)
multiplicacion uut (
    .clk(clk), .rst(rst),
    .valid(valid),
    .A(A), .B(B),
    .Mult(Mult),
    .done(done)
    );

//Variables para hacer las pruebas
always #5 clk = ~clk;

initial
begin
    valid = 1;
    A = 4;
    B = 7;
    
    #10 $finish;
    
end

endmodule
