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

Dicho subsistema, tiene como entradas los switches A y B, dos botones(Push Botton y reset), y por salida tiene la operación aritmética de dicho algoritmo.


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

Dicho Subsistema, tiene como entradas el Subsistema conversión de binario a representación BCD y por salida tiene el display de 7 segmentos que muestra el resultado de la operación realizada.

### Diagrama de bloque completo del circuito Algoritmo de Booth:

![3cer proyecto Diseno Logico-COMPLETO drawio](https://user-images.githubusercontent.com/110042626/202390463-64c600bc-2a07-4324-9f6c-284dcd9550d6.png)

Es la representación completa del circuito con cada uno de los subsistemas  existentes, basicamente cada parte que conforma el diagrama. Cada uno de los subsistemas se encargan de cumplir la funcion determinaday en general cumplen con la funcion del circuito. Tiene como entrada los **Switches** [0:15], el **clock** y ambos **botones** (*Reset* y *Push Botton*), y por salidas tiene las **luces LED** que representan los datos de entrada y el **display de 7 segmentos** que muestra el resultado de la multiplicacion.





## Diagramas de estado de las FSM diseñadas
Diagrama que muestra cada uno de los estados que tendrá el circuito durante su utilización, e indica cuales requisitos existen para poder ingresar a cada caso de uso. Basicamente, el diagrama de estados nos indicara el proceso que que ejecutara la ruta de datos desde la salida hasta la entrada, con una descripción comportamental de cada sub-bloque dentro de los subsistemas.


### Diagramas de estado **Subsistema de cálculo de multiplicación**:

![201811087-cbd59364-3eaf-48af-992a-df780de26ffa](https://user-images.githubusercontent.com/110042626/202109231-7255fb0c-e2e1-49bc-abd8-68e1ee9d09cb.png)

### Diagramas de estado **Subsistema conversión de binario a representación BCD**:

![3cer proyecto Diseno Logico-Página-15 drawio](https://user-images.githubusercontent.com/110042626/202400911-c996ffd9-7fd7-4e03-8384-a9bdd63db2cc.png)








## Ejemplo y análisis de una simulación funcional

Para ejemplificar, escogimos un caso de 4 bits para poner a prueba los subsistemas; para este caso se utilizó el ejemplo de hacer la multiplicaion con "4" y "7", siendo de esta manera "7" el multiplicando y "4" el multiplicador. Para ello ingresarlo utilizamos cuatro conmutadores, los cuatro switches, y los activamos en base a '0'=Switch abajo '1'=Switch arriba; los ingresamos como "4 = 0100" y "7 = 0111". Una vez ingresamos los parametros de entrada se hace uso del primer subsistema para representar su valor en binario, previamente obtenido, por medio de **luces LED**, de forma *'0'=LED apagada* y *'1'=LED encendida*.

**Representacion binario en LED:**

![2e585d89-b8e1-4eb6-ae50-8c59ff15e32e](https://user-images.githubusercontent.com/110042626/202411020-b0f51cfb-0ce4-4738-a76e-2a0507f98144.jpg)

Seguidamente, para la realización del segundo subsistema, se toman los datos que ya tenemos para realizarle cálculo de la multiplicación, el cálculo de la multiplicación con signo se realizará de manera iterativa por medio del ***Algoritmo de Booth***. Este subsistema indicará al siguiente subsistema consecutivo cuando el resultado de la multiplicación está estable, en el tercer subsistema se registrará el resultado del bloque anterior *(16 bits con signo)* y lo convertirá en un formato BCD *(al menos 5 dígitos en BCD)*. Y en el ultimo subsistema, con el  resultado de la multiplicación en BCD se desplegara en el display de 7 segmentos; por medio del número obtenemos 2 valores, el ánodo es la parte positiva del LED dentro del panel y los cátodos la cantidad de paneles a utilizar, dependiendo de la base del número. Para el ejemplo se está utilizando *4 x 7*, solo se utiliza el primer panel 'bo', debió a que el número del ejemplo son solo 2 unidades, y se encienden las *LED* dentro del panel que representan el número *(28)*.


**Representacion decimal display de 7 segmento:**

![a4304fa5-fae9-4164-a679-0c5193d1189a](https://user-images.githubusercontent.com/110042626/202411051-be0db844-1be1-45d5-8da7-d9096a4de827.jpg)


**Análisis de una simulación:**
Elaboracion simulacion Testbench del ejemplo implementado, para obtener la simulacion a **nivel RTL**.

![202319992-1b6be8fb-95fc-4b05-941c-ecfa51662186](https://user-images.githubusercontent.com/110042626/202411589-cd83703b-2b94-40e3-b2d4-a9c5c10dde1f.jpg)

Como se observa en el resultado, el Waveform obtenido por Vivado nos representa como la entrada del ejemplo *4 x 7*, se lleva a cabo el cálculo de multiplicación binario, y lo convertirá en un formato BCD. Al final, el último subsistema se encarga de los cátodos y ánodos correspondientes que se encargan de generar el dígito, en este caso **28**.











## Análisis de consumo de recursos en la FPGA (LUTs, FFs, etc.) y del consumo de potencia (reporte de Vivado)

![64a712ef-b2e6-4e4a-85cf-a9d8bd7c6914](https://user-images.githubusercontent.com/110042626/202401841-dc9488d9-f565-478a-96bd-5c7cc03dd65e.jpg)





## Reporte de velocidades máximas de reloj (mínima frecuencia de reloj para este diseño: 50 MHz)


![202389557-665d987d-8ea6-4e25-a6ad-9e7ce6dffcd3](https://user-images.githubusercontent.com/110042626/202401457-292c3aab-818d-431e-89f5-fb2f002ba7e9.jpg)

Como se puede observar en la imagen anterior, especificamente en el apartado de Setup, se puede ver quer la velocidad máxima del reloj posible corresponde a aproximadamente 1.65 ns, lo cual equivale a 606 Mhz.



## Análisis de principales problemas hallados durante el trabajo y de las soluciones aplicadas

Dentro de las dificultades al realizar el subsistema 2 fue elaborar la máquina de estados de manera que concordara con la estructura que proporcionaba el profesor y manipular el código que él nos había pasado. Lo anterior llevó consigo distintas revisiones para lograr entenderlo, sin embargo, con el paso del tiempo se logró entender el código proporcionado y con ayuda del profesor, terminar de elaborar la máquina de estados.

Uno de los problemas que tuvimos es que estábamos es que estábamos tomando las multiplicaciones como si fueran operaciones combinacionales, sin embargo, en algunos casos se debían de tomar las multiplicaciones como si fueran secuenciales, por lo tanto, tuvimos algunas complicaciones a la hora de hacerle el cambio con respecto al subsistema de multiplicación. No obstante, se realizaron los cambios correspondientes y pudimos arreglar dicho problema.

De la misma manera, una de las dificultades fue que al realizar las simulaciones, estas no coincidian con lo observado al ejecutar el código en la Nexys, ya que en las simulaciones este estaba trabajando adecuadamente, mientras que en la placa esto no era así. A través de las estrategias de depuración y corrección de errores, inclusive con la ayuda del profesor, se logró solucionar el problema.







