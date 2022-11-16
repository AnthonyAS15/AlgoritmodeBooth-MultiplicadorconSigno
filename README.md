# Algoritmo de Booth
Universidad: Tecnológico de Costa Rica 

Ingenieros: 
- [Anthony Artavia](https://github.com/AnthonyAS15) 
- [Diego Huertas](https://github.com/ElRiquitix) 
- [Justin Segura](https://github.com/Justinsegurar)

Proyecto III: Introducción a diseño digital en HDL

Nombre del Proyecto: Multiplicador con Signo


## Funcionamiento general del circuito
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









## Funcionamiento fundamental y diagramas de bloques de cada subsistema

### Subsistema de lectura
El subsistema de lectura tomrá las dos entradas y las convierte a complemento a 2. Luego de esto, captura el sistema principal, por medio de un sistema antirebote el cual le da paso a realizar el algoritmo de Booth, previo a esto, debe enviarse al siguiente subsistema.

#### Diagrama de Bloques:

![198816232-9513c6d3-9dec-4847-9999-13ab040475af](https://user-images.githubusercontent.com/110042626/202111505-2065b016-055c-4129-badb-ab7373984a40.jpg)




### Subsistema de cálculo de multiplicación
Este sistema recibe los operandos A y B del subsistema de lectura anterior, y realiza una operación de multiplicación  por medio del Algoritmo de Booth. Finalmente este bloque indicará al siguiente bloque consecutivo cuando el resultado de la multiplicación está
estable para ser muestreado.

#### Diagrama de Bloques:

![3cer proyecto Diseno Logico-Subsistema 2 0 drawio (1)](https://user-images.githubusercontent.com/110042626/202106202-aacadcb8-1812-4fc1-8b09-355b032ae12d.png)



### Subsistema conversión de binario a representación BCD
Este sistema registrará el resultado del bloque anterior y lo convertirá en un formato BCD (Generando al menos 5 dígitos en BCD y uno de signo para el siguiente bloque). Se indicará al siguiente bloque cuando está lista la conversión para registrar.

#### Diagrama de Bloques:

![3cer proyecto Diseno Logico-Parte Codificador BCD drawio](https://user-images.githubusercontent.com/110042626/202106301-d018939b-f377-4129-b4c6-553a8cfcc1a5.png)



###  Subsistema de despliegue en display de 7 segmentos
El subsistema va a tomar resultado de la multiplicación en BCD. Luego de esto, los datos recibidos lo representará en los dispositivos 7 segmentos disponibles en la placa, de forma decimal e incluyendo el signo. 

#### Diagrama de Bloques:

![201437213-a34185db-e395-4c00-8fea-3720e0567b5b](https://user-images.githubusercontent.com/110042626/202109207-119b76c9-b7c9-4aaa-898e-c77d8fda5d91.jpg)





## Diagramas de estado de las FSM diseñadas
Diagrama que muestra cada uno de los estados que tendrá el circuito durante su utilización, e indica cuales requisitos existen para poder ingresar a cada caso de uso. Basicamente, el diagrama de estados nos indicara el proceso que que ejecutara la ruta de datos desde la salida hasta la entrada, con una descripción comportamental de cada sub-bloque dentro de los subsistemas

![201811087-cbd59364-3eaf-48af-992a-df780de26ffa](https://user-images.githubusercontent.com/110042626/202109231-7255fb0c-e2e1-49bc-abd8-68e1ee9d09cb.png)




## Ejemplo y análisis de una simulación funcional del sistema completo






## Análisis de consumo de recursos en la FPGA (LUTs, FFs, etc.) y del consumo de potencia (reporte de Vivado)






## Reporte de velocidades máximas de reloj 
(mínima frecuencia de reloj para este diseño: 50 MHz).






## Análisis de principales problemas hallados durante el trabajo y de las soluciones aplicadas

Dentro de las dificultades al realizar el subsistema 2 fue elaborar la máquina de estados de manera que concordara con la estructura que proporcionaba el profesor y manipular el código que él nos había pasado. Lo anterior llevó consigo distintas revisiones para lograr entenderlo, sin embargo, con el paso del tiempo se logró entender el código proporcionado y con ayuda del profesor, terminar de elaborar la máquina de estados.

De la misma manera, una de las dificultades fue que al realizar las simulaciones, estas no coincidian con lo observado al ejecutar el código en la Nexys, ya que en las simulaciones este estaba trabajando adecuadamente, mientras que en la placa esto no era así. A través de las estrategias de depuración y corrección de errores, inclusive con la ayuda del profesor, se logró solucionar el problema.







