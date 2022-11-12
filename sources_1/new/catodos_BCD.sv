`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: catodos_BCD
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: A partir del digito, decide la forma de este en código de catodos
// 
//////////////////////////////////////////////////////////////////////////////////


module catodos_BCD(
    input [3:0] digito, //Digito que se va a mostrar en la posición correspondiente
    output reg [6:0] catodos = 0 //Digito en código de catodos que se va a mostrar
    );

    always @ (digito)
        begin
            case(digito)
                4'b0000: catodos = 7'b0000001; // 0 decimal
                4'b0001: catodos = 7'b1001111; // 1 decimal
                4'b0010: catodos = 7'b0010010; // 2 decimal
                4'b0011: catodos = 7'b0000110; // 3 decimal
                4'b0100: catodos = 7'b1001100; // 4 decimal
                4'b0101: catodos = 7'b0100100; // 5 decimal
                4'b0110: catodos = 7'b0100000; // 6 decimal
                4'b0111: catodos = 7'b0001111; // 7 decimal
                4'b1000: catodos = 7'b0000000; // 8 decimal
                4'b1001: catodos = 7'b0000100; // 9 decimal
                default: catodos = 7'b0000001; // 0 decimal
            endcase
        end
    
endmodule
