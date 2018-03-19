import processing.serial.*;
byte[] inByte;
Serial myPort;  // The serial port
int trama1, trama2, trama3, trama4, trama5, trama6, trama7, trama8;
int Ultrasonido, datoUS, EjeX, EjeY,  EjeZ;
int datoEjeX, datoEjeY, datoEjeZ;
float xA1 = 10, xA2 = 40, yA1 = 0.0, yA2 = 0.0;
float xB1 = 10, xB2 = 40, yB1 = 0.0, yB2 = 0.0;
float xC1 = 10, xC2 = 40, yC1 = 0.0, yC2 = 0.0;
float xD1 = 10, xD2 = 40, yD1 = 0.0, yD2 = 0.0;
float anguloV, anguloH;
int relleno; 
color c1;
PrintWriter output;

void setup() {
  size(1350, 700);
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.buffer(9);
  background(0);
  // Create a new file in the sketch directory
  output = createWriter("prueba1z.txt"); 
}

void draw() {
  
  if (xA1==10 || xB1==10){
  background(0);
  }
  noFill();
  stroke(255);
  rect(10, 10, 1330, 680);
  /*relleno = (trama1 & 0x60);
  fill(255);
  relleno = (relleno >> 5); 
  if (relleno==00){
     c1 = color(255, 0, 0);}
  if (relleno==01){
     c1 = color(0, 255, 0);}
  if (relleno==2){
     c1 = color(0, 0, 255);}
   if (relleno==3){
     c1 = color(255, 255, 255);}
  strokeWeight(2);
  */
  
  
  
 if(sqrt(pow(datoEjeX, 2)+pow(datoEjeY, 2)+pow(datoEjeZ, 2)) > 1000){
   if ( datoEjeY < 50 & datoEjeY > -50){
    anguloV= atan2(datoEjeZ, datoEjeX)*180/PI;
    println("ángulo vertical= " + anguloV + "°");
    println("Eje Y= " + datoEjeY);
   }
    if ( datoEjeX < 50 & datoEjeX > -50){
      anguloH= atan2(datoEjeZ, datoEjeY)*180/PI;
      println("ángulo horizontal= " + anguloH + "°");
      println("Eje X= " + datoEjeX);
   }
 }
  
  //println("Distancia= " + datoUS + "cm"); 
  //linea blanca Ultrasonido
  stroke(255);
  //line(xA1, yA1, xA2, yA2);
  
  //linea roja Eje X
  stroke(255, 0, 0);
  line(xB1, yB1, xB2, yB2);
  
  //linea verde Eje Y
  stroke(0, 255, 0);
  line(xC1, yC1, xC2, yC2);
  
  //linea azul Eje Z
  stroke(0, 0, 255);
  line(xD1, yD1, xD2, yD2);
  println("X= " + datoEjeX + "  Y= " + datoEjeY + "  Z= " + datoEjeZ);
   //float modulo = sqrt(pow(datoEjeX, 2)+pow(datoEjeY, 2)+pow(datoEjeZ, 2));
   //println(modulo);
 // output.print(modulo + " "); // Write data
 anguloV= atan2(datoEjeZ, datoEjeX)*180/PI;
 anguloH= atan2(datoEjeZ, datoEjeY)*180/PI;
  println("ángulo horizontal= " + anguloH + "°");
  println("ángulo vertical= " + anguloV + "°");
}

void serialEvent(Serial myPort) {
   while (myPort.available() > 0) {
    inByte = myPort.readBytes();
    
    trama1 = inByte[5];
    trama2 = inByte[6];
    Ultrasonido = (trama1 & 0x1F);
    Ultrasonido = (Ultrasonido << 7);
    Ultrasonido = (Ultrasonido | trama2);
    datoUS = Ultrasonido;
    Ultrasonido = 690-(Ultrasonido*680/4095);
    
    trama3 = inByte[3];
    trama4 = inByte[4];
    EjeX = (trama3 & 0x1F);
    EjeX = (EjeX << 7);
    EjeX = (EjeX | trama4);
    datoEjeX = EjeX-1870;
    EjeX = 690-(EjeX*680/4095);
    
    trama5 = inByte[1];
    trama6 = inByte[2];
    EjeY = (trama5 & 0x1F);
    EjeY = (EjeY << 7);
    EjeY = (EjeY | trama6);
    datoEjeY = EjeY-1996;
    EjeY = 690-(EjeY*680/4095);
    
    trama7 = inByte[7];
    trama8 = inByte[8];
    EjeZ = (trama7 & 0x1F);
    EjeZ = (EjeZ << 7);
    EjeZ = (EjeZ | trama8);
    datoEjeZ = EjeZ-1982;
    
    EjeZ = 690-(EjeZ*680/4095);
    
    if (xA1 >= 10 & xA1 < 1340){
    xA1 = xA2;
    xA2 += 30;
    yA1 = yA2;
    yA2 = Ultrasonido;
    }else{
       xA1=10;
       xA2=40;
     }
     
    if (xB1 >= 10 & xB1 < 1340){
    xB1 = xB2;
    xB2 += 30;
    yB1 = yB2;
    yB2 = EjeX;
    }else{
       xB1=10;
       xB2=40;
     }
     
    if (xC1 >= 10 & xC1 < 1340){
    xC1 = xC2;
    xC2 += 30;
    yC1 = yC2;
    yC2 = EjeY;
    }else{
       xC1=10;
       xC2=40;
     }
     
    if (xD1 >= 10 & xD1 < 1340){
    xD1 = xD2;
    xD2 += 30;
    yD1 = yD2;
    yD2 = EjeZ;
    }else{
       xD1=10;
       xD2=40;
     }
   }
}

void keyPressed() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}