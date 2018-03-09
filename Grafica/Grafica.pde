import processing.serial.*;
byte[] inByte;
Serial myPort;  // The serial port
int trama1, trama2, trama3, trama4;
int analogA, datoA, analogB, datoB;
float xA1 = 10, xA2 = 40, yA1 = 0.0, yA2 = 0.0;
float xB1 = 10, xB2 = 40, yB1 = 0.0, yB2 = 0.0;
float angulo;
int relleno; 
color c1;
PrintWriter output;

void setup() {
  size(1350, 700);
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.buffer(5);
  background(0);
  // Create a new file in the sketch directory
  output = createWriter("prueba_ultrasonido  .txt"); 
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
     c1 = color(255, 255, 255);}*/
  strokeWeight(2);
  stroke(0, 0, 255);
  line(xA1, yA1, xA2, yA2);
  stroke(255, 0, 0);
  line(xB1, yB1, xB2, yB2);
  angulo= atan(datoB/datoA)*180/PI;
  println(angulo +"°");
  
  output.println(binary(datoA, 12)); // Write data
}

void serialEvent(Serial myPort) {
   while (myPort.available() > 0) {
    inByte = myPort.readBytes();
    
    trama1 = inByte[1];
    trama2 = inByte[2];
    analogA = (trama1 & 0x1F);
    analogA = (analogA << 7);
    analogA = (analogA | trama2);
    datoA = analogA;
    analogA = 690-(analogA*680/4095);
    
    trama3 = inByte[3];
    trama4 = inByte[4];
    analogB = (trama3 & 0x1F);
    analogB = (analogB << 7);
    analogB = (analogB | trama4);
    datoB = analogB;
    analogB = 690-(analogB*680/4095);
    
    if (xA1 >= 10 & xA1 < 1340){
    xA1 = xA2;
    xA2 += 30;
    yA1 = yA2;
    yA2 = analogA;
    }else{
       xA1=10;
       xA2=40;
     }
     
    if (xB1 >= 10 & xB1 < 1340){
    xB1 = xB2;
    xB2 += 30;
    yB1 = yB2;
    yB2 = analogB;
    }else{
       xB1=10;
       xB2=40;
     }
   }
}

void keyPressed() {
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
}