`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Universidad: TEC
// Ingenieros: Anthony Artavia - Diego Huertas - Justin Segura
// 
// Nombre del Módulo: binario_a_BCD
// Nombre del Proyecto: Algoritmo de Booth
// Descripción: Recibe el número binario resultante de la multiplicación y lo transforma a código BCD
// 
//////////////////////////////////////////////////////////////////////////////////

module binario_a_BCD(
    input clk,
    input reset,
    input inicio,
    input [14:0] bin,
    output [19:0] codigo_BCD,
    output done
    );
    
    //Coficación de los estados.
    parameter Inactivo = 3'b000;
    parameter Inicio = 3'b001;
    parameter Agregar = 3'b010;
    parameter Shift = 3'b011;
    parameter Final = 3'b100;
    
    //reg [11:0]  bin_data = 0;
    reg [27:0] datos_BCD = 0;
    reg [2:0] estado = 0;
    reg ocupado = 0;
    reg [3:0] sh_contador  = 0;
    reg [1:0] agregar_contador = 0;
    reg resultado = 0;
    
    
    always @(posedge clk)
        begin
        if (reset)
            estado <= Inactivo;
        else if(inicio)
            begin
                if(~ocupado)
                    begin
                    datos_BCD <= {16'b0, bin};
                    estado <= Inicio;
                    end
            end
        
        case(estado)
        
            Inactivo:
                begin
                    resultado <= 0;
                    ocupado <= 0;
                end
                
            Inicio:
                begin
                ocupado <= 1;
                estado <= Agregar;
                end
                    
            Agregar:
                begin
                
                case(agregar_contador)
                    0:
                        begin
                        if(datos_BCD[15:12] > 4)
                            begin
                                datos_BCD[27:12] <= datos_BCD[27:12] + 3;
                            end
                            agregar_contador <= agregar_contador + 1;
                        end
                    
                    1:
                        begin
                        if(datos_BCD[19:16] > 4)
                            begin
                                datos_BCD[27:16] <= datos_BCD[27:16] + 3;
                            end
                            agregar_contador <= agregar_contador + 1;
                        end
                        
                    2:
                        begin
                        if((agregar_contador == 2) && (datos_BCD[23:20] > 4))
                            begin
                                datos_BCD[27:20] <= datos_BCD[27:20] + 3;
                            end
                            agregar_contador <= agregar_contador + 1;
                        end
                        
                    3:
                        begin
                        if((agregar_contador == 3) && (datos_BCD[27:24] > 4))
                            begin
                                datos_BCD[27:24] <= datos_BCD[27:24] + 3;
                            end
                            agregar_contador <= 0;
                            estado <= Shift;
                        end
                    endcase
                end
                
            Shift:
                begin
                sh_contador <= sh_contador + 1;
                datos_BCD <= datos_BCD << 1;
                
                if(sh_contador == 11)
                    begin
                    sh_contador <= 0;
                    estado <= Final;
                    end
                else
                    begin
                    estado <= Agregar;
                    end

                end
 
            
            Final:
                begin
                resultado <= 1;
                estado <= Inactivo;
                end
            default:
                begin
                estado <= Inactivo;
                end
            
            endcase
            
        end
    assign codigo_BCD = datos_BCD[27:12];
    assign done = resultado;
endmodule