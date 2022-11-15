`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: control_BCD
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Decide en la posición donde se va a colocar el dígito a partir del contador
// 
//////////////////////////////////////////////////////////////////////////////////


module control_BCD(
    input [20:0] codigo_BCD, //Código BCD que se recibe del módulo binario_a_BCD.
    input [2:0] contador_actualizar,
    output reg [3:0] digito = 0 //Dígito que se va a mostrar en la posición correspondiente.
    );

    always @ (codigo_BCD, contador_actualizar)
        begin
            case (contador_actualizar)
            3'b000: 
                digito = codigo_BCD [3:0]; //Dígito que se muestra en el primer dígito (unidades).
            3'b001: 
                digito = codigo_BCD [7:4]; //Dígito que se muestra en el segundo dígito (decenas).
            3'b010: 
                digito = codigo_BCD [11:8]; //Dígito que se muestra en el tercer dígito (centenas).
            3'b011: 
                digito = codigo_BCD [15:12]; //Dígito que se muestra en el cuarto dígito (unidades de mil).
            3'b100: 
                digito = codigo_BCD [19:16]; //Dígito que se muestra en el quinto dígito (decenas de mil).
            3'b101: 
                if (codigo_BCD [20] == 1'b0) //Dígito que se muestra en el sexto dígito (signo).
                    digito = 4'b0000; //Si el signo es positivo, se escribir� un cero, en la sexta posici�n.
                else
                    digito = 4'b1010; //Se va a usar el 10 binario para tomar en cuenta que es el signo negativo.
            default:
                digito = codigo_BCD [3:0]; //Dígito que se muestra en el primer dígito (unidades).
            endcase
        end
    
endmodule
