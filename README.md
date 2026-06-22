# Laboratorios realizados en FODISEGUA 2026
Universidad Galileo

Universidad de San Carlos de Guatemala

Kevin Lajpop

# Herramientas utilizadas
Para este laboratorio se utiliza Systemverilog en una Raspberry Pi 4 pero puede ejecutarse en cualquier plataforma que cuente con Systemverilog

# Laboratorio 1
Creación de un multiplexor de 4x1 como se muestra en la siguiente imagen:

![alt text](image.png)

la solución de este laboratorio está en la carpeta 1. Lab I/mux4.sv

Creación de un banco de registros como se muestra en la siguiente imagen:
![alt text](image-2.png)

la solución de este laboratorio está en la carpeta 1. Lab I/registerbank.sv

Creación de un mux con memoria como se muestra en la siguiente imagen:
![alt text](image-3.png)

la solución de este laboratorio está en la carpeta 1. Lab I/muxregister.sv

# Laboratorio 2
Realizar el test de lo realizado en el laboratorio 1. Por ejemplo:

```bash
 iverilog -g2012 -o sim lab1.sv ../2. Lab II/tb_mux4.sv
 ```