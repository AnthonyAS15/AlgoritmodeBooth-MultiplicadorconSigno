`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: contador_actualizacion
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Realiza una cuenta para decidir el contador que se va a encender.
//               Cuenta hasta cinco, ya que seis es la cantidad máxima de dígitos necesarios.
//
//////////////////////////////////////////////////////////////////////////////////

module contador_actualizacion(
    input reloj_actualizacion,
    input reset,
    output reg [2:0] contador_actualizar = 0
    );

    always @ (posedge reloj_actualizacion)
        begin
            if (reset)
                contador_actualizar <= 0;
            else
                if(contador_actualizar == 3'b110)
                    contador_actualizar <= 0;
                else
                    contador_actualizar <= contador_actualizar +1;
        end
    
endmodule