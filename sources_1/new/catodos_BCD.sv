`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: catodos_BCD
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: A partir del dígito, decide la forma de este en código de cátodos
// 
//////////////////////////////////////////////////////////////////////////////////


module catodos_BCD(
    input [3:0] digito, //Dígito que se va a mostrar en la posición correspondiente.
    output reg [6:0] catodo = 0 //Dígito en código de cátodos que se va a mostrar.
    );

    always @ (digito)
        begin
            case(digito)
                4'b0000:
                    catodo = 7'b0000001; //0 decimal.
                4'b0001:
                    catodo = 7'b1001111; //1 decimal.
                4'b0010:
                    catodo = 7'b0010010; //2 decimal.
                4'b0011:
                    catodo = 7'b0000110; //3 decimal.
                4'b0100:
                    catodo = 7'b1001100; //4 decimal.
                4'b0101:
                    catodo = 7'b0100100; //5 decimal.
                4'b0110:
                    catodo = 7'b0100000; //6 decimal.
                4'b0111:
                    catodo = 7'b0001111; //7 decimal.
                4'b1000:
                    catodo = 7'b0000000; //8 decimal.
                4'b1001:
                    catodo = 7'b0000100; //9 decimal.
                4'b1010:
                    catodo = 7'b1111110; //Signo negativo.
                default:
                    catodo = 7'b0000001; //0 decimal.
            endcase
        end
    
endmodule
