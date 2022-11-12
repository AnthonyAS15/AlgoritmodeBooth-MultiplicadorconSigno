`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: divisor_reloj
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Divide la frecuencia del reloj en la frecuencia deseada para utilizar el display de 7 segmentos
// 
//////////////////////////////////////////////////////////////////////////////////


module divisor_reloj(
    input clk, // 100 Mhz
    input reset,
    output reg clk_dividido
    );
    //Divisor para obtener la división de salida deseada
    localparam divisor = 4999; //Para obtener una señal dividida de 10 kHz
    //Formula para tener la frecuencia de la señal que se quiere:
    //Valor_dividido = [100 Mhz/(2*Frecuencia_deseada)] - 1 => Frecuencia deseada = 4999
    
    //Contador
    reg [25:0] contador = 0;
    
    always @ (posedge clk or posedge reset)
        begin
            if (reset)
                contador <= 0; //Resetear el valor
            else
                if (contador == divisor)
                    contador <= 0; //Resetear el valor
                else
                    contador <= contador +1;
        end
    
    // Divisor de reloj
    always @ (posedge clk or posedge reset)
        begin
            if (reset)
                clk_dividido <= ~clk_dividido; //Invertir la señal
            else
            begin
                if (contador == divisor)
                    clk_dividido <= ~clk_dividido; //Invertir la señal
                else
                    clk_dividido <= clk_dividido; //Almacenar el valor
            end
        end
    
endmodule
