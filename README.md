# Software

## Descripción 
Graficación, lectura de datos obtenidos a través del DEMOQE128 e interfaz gráfica, mediante la implementación de códigos realizados en Processing. 

## Tabla de contenidos
- [Lista de Módulos](#lista-de-módulos)
- [Interfaz Gráfica](#interfaz-gráfica)
- [Requisitos](#requisitos)
- [Software](#software)
- [License](#license)

## Lista de Módulos
- [Gráfica](https://github.com/Fedora-Eugenio/Software/blob/master/Grafica/Grafica.pde): Grafica la señal recibida por el DEMOQE128 y guarda los datos adquiridos en un archivo .txt.

- [Lectura de datos](https://github.com/Fedora-Eugenio/Software/blob/master/leerdato/leerdato.pde): Módulo de graficación de histograma a partir de la data obtenida en el módulo *Gráfica*. 

- [Interfaz Gráfica](https://github.com/Fedora-Eugenio/Software/blob/master/LaserTag/LaserTag.pde): Interfaz de interacción usuario-juego; visualización de modos de juego, puntaje, recargas y cronometraje.

## Interfaz gráfica
- **Inicio** 


- **Modo 1**: *Libre*
	
	Funciona con un contador de balas limitado (6 máx), simulando el estilo de un revólver real, donde se debe recargar una vez las balas se hayan acabado para poder continuar jugando.
	
![Recarga 2](https://github.com/Fedora-Eugenio/Software/blob/master/Recarga%202.PNG)

![RECARGA](https://github.com/Fedora-Eugenio/Software/blob/master/RECARGA.PNG)

- **Modo 2**: *Contrarreloj*
	
	Estilo de juego cronometrado, donde se puede realizar un número ilimitado de disparos en el tiempo establecido.
	
![Contrarreloj 1](https://github.com/Fedora-Eugenio/Software/blob/master/Contrarreloj%201.PNG)

![contrarreloj 2](https://github.com/Fedora-Eugenio/Software/blob/master/contrarreloj%202.PNG)

- **Score**

	Parámetros como la distancia y el número de disparos que se hacen en cada modo de juego afectarán el puntaje obtenido, que será calculado con la siguiente ecuación:
	
      Puntaje = Acumulado + (Hit*Distancia/Disparos)


## Requisitos
La siguiente implementación fue desarrollada y probada en Windows 10 - 64 bits.

## Software
Implementación hecha en Processing 3.

## License
Copyright (c) 2017-2018 Fedora Di Polo - Eugenio MartínezReleased under the [GNU GPLv3.0 License](LICENSE). 
