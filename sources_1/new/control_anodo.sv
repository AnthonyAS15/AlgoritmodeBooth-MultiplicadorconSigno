`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: control_anodo
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Enciende los anodos a partir del contador
// 
//////////////////////////////////////////////////////////////////////////////////


module control_anodo(
    input [2:0] contador_actualizar, //Cada 10 kHz. Cuenta hasta cinco que es la cantidad máxima de dígitos necesarios.
    output reg [7:0] anodo = 0
    );

    always @ (contador_actualizar)
        begin
            case (contador_actualizar)
                3'b000: anodo = 8'b11111110; //Encender dígito 1 (unidades)
                3'b001: anodo = 8'b11111101; //Encender dígito 2 (decenas)
                3'b010: anodo = 8'b11111011; //Encender dígito 3 (centenas)
                3'b011: anodo = 8'b11110111; //Encender dígito 4 (unidades de mil)
                3'b101: anodo = 8'b11101111; //Encender dígito 5 (decenas de mil)
            endcase
        end
    
endmodule