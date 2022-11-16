# Algoritmo de Booth
Universidad: Tecnológico de Costa Rica 

Ingenieros: 
- [Anthony Artavia](https://github.com/AnthonyAS15) 
- [Diego Huertas](https://github.com/ElRiquitix) 
- [Justin Segura](https://github.com/Justinsegurar)

Proyecto III: Introducción a diseño digital en HDL

Nombre del Proyecto: Multiplicador con Signo


## Funcionamiento general
Por medio del Verilog y la suite de herramientas de Vivado para desarrollar el sistema completo se trabajará con una FPGA Nexys 4 DDR. Se van a recibir una entrada de complemento a 2 ( A y B de 8 bits cada una). Estas entradas van a ser leídas, capturadas y sincronizados por un sistema principal por medio de un circuito de rebote y esto va a ser evidenciado por medio del encendido de leds. Luego se realiza la multiplicación para que se inicie la lectura de dicho algoritmo traducidas a representación BCD. Finalmente, se tomarán los datos en código y se desplegarán en el ***display*** de 7 segmentos de la placa en sistema decimal, incluyendo el signo.


### Subsistema de lectura
El subsistema de lectura tomará las dos entradas en complemento a 2. Luego de esto, captura el sistema principal, por medio de un sistema antirebote el cual le da paso a realizar el algoritmo de Booth, previo a esto, debe enviarse al siguiente subsistema.

### Subsistema de cálculo de multiplicación
Este sistema recibe la entrada de complemento a 2 del subsistema de lectura anterior, y realiza una operación de multiplicación  por medio del Algoritmo de Booth. Finalmente este bloque indicará al siguiente bloque consecutivo cuando el resultado de la multiplicación está
estable para ser muestreado.

### Subsistema conversión de binario a representación BCD
Este sistema registrará el resultado del bloque anterior y lo convertirá en un formato BCD (Generando al menos 5 dígitos en BCD y uno de signo para el siguiente bloque). Se indicará al siguiente bloque cuando está lista la conversión para registrar.


###  Subsistema de despliegue en display de 7 segmentos
El subsistema va a tomar resultado de la multiplicación en BCD. Luego de esto, los datos recibidos lo representará en los dispositivos 7 segmentos disponibles en la placa, de forma decimal e incluyendo el signo. 









## Funcionamiento fundamental
### Subsistema de lectura
El subsistema de lectura tomrá las dos entradas y las convierte a complemento a 2. Luego de esto, captura el sistema principal, por medio de un sistema antirebote el cual le da paso a realizar el algoritmo de Booth, previo a esto, debe enviarse al siguiente subsistema.
#### Diagrama de Bloques:
![P3_0](https://user-images.githubusercontent.com/111217127/198816294-17a4e32f-e5b1-48bf-97a1-1da85629cf20.jpeg)



### Subsistema de cálculo de multiplicación
Este sistema recibe los operandos A y B del subsistema de lectura anterior, y realiza una operación de multiplicación  por medio del Algoritmo de Booth. Finalmente este bloque indicará al siguiente bloque consecutivo cuando el resultado de la multiplicación está
estable para ser muestreado.

#### Diagrama de Bloques:


![3cer proyecto Diseno Logico-Subsistema 2 0 drawio](https://user-images.githubusercontent.com/110042626/201456012-4d760fcf-3b4a-4200-9756-59e170fe5252.png)




### Subsistema conversión de binario a representación BCD
Este sistema registrará el resultado del bloque anterior y lo convertirá en un formato BCD (Generando al menos 5 dígitos en BCD y uno de signo para el siguiente bloque). Se indicará al siguiente bloque cuando está lista la conversión para registrar.

#### Diagrama de Bloques:


![3cer proyecto Diseno Logico-Subsistema 3 0 drawio](https://user-images.githubusercontent.com/110042626/201456017-1e6f3a0f-4c56-4498-b2fd-ee737d16267e.png)



###  Subsistema de despliegue en display de 7 segmentos
El subsistema va a tomar resultado de la multiplicación en BCD. Luego de esto, los datos recibidos lo representará en los dispositivos 7 segmentos disponibles en la placa, de forma decimal e incluyendo el signo. 

#### Diagrama de Bloques:







## Diagramas de estado de todas las FSM diseñadas (si existen), según descritos en la sección 6.


## Ejemplo y análisis de una simulación funcional del sistema completo, desde el estímulo de entrada
hasta el manejo de los 7 segmentos.


## Análisis de consumo de recursos en la FPGA (LUTs, FFs, etc.) y del consumo de potencia que reporta
la herramienta Vivado.


## Reporte de velocidades máximas de reloj posibles en el diseño (mínima frecuencia de reloj para este
diseño: 50 MHz).


## Análisis de principales problemas hallados durante el trabajo y de las soluciones aplicadas.








