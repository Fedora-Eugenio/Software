import ddf.minim.*;
import processing.serial.*;
byte[] inByte;
Serial myPort;  // The serial port
int trama1, trama2, trama3, trama4, trama5, trama6, trama7, trama8;
int Ultrasonido, datoUS, EjeX, EjeY,  EjeZ, datoEjeX, datoEjeY, datoEjeZ;
int Boton, Foto1, Foto2, Foto3, Foto4, Foto5;
float anguloV, anguloH;
Minim soundengine;
AudioSample disparo;
AudioSample hit;
AudioSample recarga;
AudioSample cambio;
AudioSample Shootist;
boolean Reset=true, Gatillo=false, Disponible=true, shoot=false, inicio=true;
PImage silueta;
float Disparos, Hit, Puntaje, acumulado;
int Diana, multi, Blanco, Tiempo=3600, Modo=1, objetivo=1, contador=0, espera=0, j=0, k=0;
float[] distribution = new float[360];
PFont font1;

void setup(){
  size(1000, 500);
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.buffer(9);
  soundengine = new Minim(this);
  disparo = soundengine.loadSample("disparo.mp3", 1024);
  hit = soundengine.loadSample("hit.mp3", 1024);
  recarga = soundengine.loadSample("recarga.mp3", 1024);
  cambio = soundengine.loadSample("cambio.mp3", 1024);
  Shootist = soundengine.loadSample("TheShootist.mp3", 2048);
  silueta = loadImage("silueta.jpg");
  font1 = loadFont("Playbill-70.vlw");
  for (int i = 0; i < distribution.length; i++) {
    distribution[i] = int(randomGaussian() * 150);
  }
}

void draw() {
  println(datoUS);
  if(sqrt(pow(datoEjeX, 2)+pow(datoEjeY, 2)+pow(datoEjeZ, 2)) > 2100){
   if ( datoEjeY < 0 & datoEjeY > -500){
    anguloV= atan2(datoEjeZ, datoEjeX)*180/PI;
    //println("ángulo vertical= " + anguloV + "°");
    if ( anguloV < -105 ){
      println("reset" );
      recarga.trigger();
      inicio=false;
      Reset=true;
      }
    if ( anguloV > -85 ){
      println("Modo3" );
      Modo=3;
      cambio.trigger();
      Reset=true;
      }
    
   }
    if ( datoEjeX < 200 & datoEjeX > -300){
      anguloH= atan2(datoEjeZ, datoEjeY)*180/PI;
     // println("ángulo horizontal= " + anguloH + "°");
      if ( anguloH > -85 ){
      println("Modo2" );
      Modo=2;
      cambio.trigger();
      Reset=true;
      }
      if ( anguloH < -105 ){
      println("Modo1" );
      constrain (Modo, 1, 3);
      Modo=1;
      cambio.trigger();
      Reset=true;
      }
   }
 }
  if(contador==0){
   //Shootist.trigger();
  }
  contador++;
   if(contador==14400){
      contador=0;
    }
    if (mousePressed==true) {
      Gatillo=true;  
    }
    if (Boton!=0) {
      Gatillo=true;  
    }
  if(inicio){
    background(0);
   
    translate(width/2, height/2);

  for (int i = 0; i < distribution.length; i++) {
    rotate((TWO_PI)/distribution.length);
    float dist = abs(distribution[i]);
    stroke(255, 0, 0);
    line(0, 0, dist, 0);
    j++;
  }
  fill(255);
  textFont(font1, 70);
     text("LASER-TAG", -90, -50);
    text("Recarga para continuar", -175, 50); 
   
  }else{

  if(Reset){
      Disparos=0;
      Hit=0;
      Puntaje=0;
      acumulado=0;
      Diana=0;
      Blanco=0;
      Tiempo=3600;
      shoot=false;
      Reset=false;
  }
  background(0);
  fill(255);
  image(silueta, 0, 0);
  fill(0, 0, 255);
  ellipse(250, 100, 20, 20);
  ellipse(175, 200, 20, 20);
  ellipse(325, 200, 20, 20);
  ellipse(175, 350, 20, 20);
  ellipse(325, 350, 20, 20);
  fill(255, 0, 0);
  
  
  Puntaje= acumulado + (Hit*multi/Disparos);
  if(Disparos==0){
    Puntaje=0;
  }
  
  if(Gatillo & espera==0){
    shoot=true;
  }
  if(shoot){
    espera++;
  }
  if(espera==2){
    shoot=false; 
  }
  if(!Gatillo){
    espera=0;
    shoot=false;
  }
  
  if (Foto1!=0) {
      Diana=1;
    }
  if (Foto2!=0) {
      Diana=2;
    }
  if (Foto3!=0) { 
      Diana=3;
    }
  if (Foto4!=0) {
      Diana=4;
    }
  if (Foto5!=0) {
      Diana=5;
    }
    switch(Modo){
    case 1:
    text("Modo= " + Modo, 550, 75 );
    text("Disparos= " + Disparos, 550, 175 );
    text("Hit= " + Hit, 550, 275 );
    text("Puntaje= " + Puntaje, 550, 375 );
      if(shoot){
        Disparos++;
        disparo.trigger();
      }
      switch(Diana) {
      case 1: 
        ellipse(250, 100, 20, 20);
        if(Blanco!=1 & shoot){
          Hit++;
          hit.trigger();
          multi=datoUS;
          acumulado = Puntaje;
          image(silueta, 15, 0);
          Blanco=1;
        }
        break;
      case 2: 
        ellipse(175, 200, 20, 20);
        if(Blanco!=2 & shoot){
          Hit++;
          hit.trigger();
          multi=datoUS;
          acumulado = Puntaje;
          image(silueta, 15, 0);
          Blanco=2;
        }
        break;
      case 3: 
        ellipse(325, 200, 20, 20); 
        if(Blanco!=3 & shoot){
           Hit++;
           hit.trigger();
           multi=datoUS;
           acumulado = Puntaje;
           image(silueta, 15, 0);
           Blanco=3;
        }
        break;
      case 4: 
        ellipse(175, 350, 20, 20); 
        if(Blanco!=4 & shoot){
          Hit++;
          hit.trigger();
          multi=datoUS;
          acumulado = Puntaje;
          image(silueta, 15, 0);
          Blanco=4;
        }
        break;
      case 5: 
        ellipse(325, 350, 20, 20);
        if(Blanco!=5 & shoot){
          Hit++;
          hit.trigger();
          multi=datoUS;
          acumulado = Puntaje;
          image(silueta, 15, 0);
          Blanco=5;
        }
        break;
        default:
        Puntaje=0;
        break;
      }
      break;
    
    case 2:
    text("Modo= " + Modo, 550, 75 );
    text("Disparos= " + Disparos, 550, 175 );
    text("Hit= " + Hit, 550, 275 );
    text("Puntaje= " + Puntaje, 550, 375 );
    text("Tiempo= " + Tiempo/60, 550, 475 );
      if((Tiempo>0 & Tiempo<3600) | (shoot & Disparos==0) ){
        Tiempo--;
        if(shoot){
          Disparos++;
          disparo.trigger();
        }
        if(Diana!=0 & shoot){
          Hit++;
          hit.trigger();
          multi=datoUS;
          acumulado = Puntaje;
          image(silueta, 15, 0);
          Diana=0;
        }
      }
      if(Tiempo==0){
        fill(0);
        text("Tiempo= " + Tiempo/60, 550, 475 );
        fill(255, 0, 0);
      text("El tiempo se acabó ", 550, 475 );
      }
      break;
      
    case 3:
    text("Modo= " + Modo, 550, 75 );
    text("Disparos= " + Disparos, 550, 175 );
    text("Hit= " + Hit, 550, 275 );
    text("Puntaje= " + Puntaje, 550, 375 );
    text("Objetivo= " + objetivo, 550, 475 );
      if(shoot){
         Disparos++;
         disparo.trigger();
        }
      fill(0, 255, 0);  
      switch(objetivo) {
      case 1: 
        ellipse(250, 100, 20, 20);
        break;
      case 2: 
        ellipse(175, 200, 20, 20);
        break;
      case 3: 
        ellipse(325, 200, 20, 20); 
        break;
      case 4: 
        ellipse(175, 350, 20, 20); 
        break;
      case 5: 
        ellipse(325, 350, 20, 20);
        break;
      }
      if(Diana==objetivo & shoot){
         Hit++;
         hit.trigger();
         multi=datoUS;
         acumulado = Puntaje;
         image(silueta, 15, 0);
         objetivo = int(random (1, 6));
        }
    
    }
    Gatillo=false;
  }
}
void keyPressed() {
    if (key == 'm') {
      Modo++;
      Modo = constrain (Modo, 1, 3);
      cambio.trigger();
      Reset=true;
    }
    if (key == 'n') {
      constrain (Modo, 1, 3);
      Modo--;
      Modo = constrain (Modo, 1, 3);
      cambio.trigger();
      Reset=true;
    }
    
    if (key == '8') {
      Diana=1;
    }
    if (key == '4') {
      Diana=2;
    }
    if (key == '6') { 
      Diana=3;
    }
    if (key == '1') {
      Diana=4;
    }
    if (key == '3') {
      Diana=5;
    }
    if (key == 'r' ) {
      recarga.trigger();
      inicio=false;
      Reset=true;
    }
}

void serialEvent(Serial myPort) {
   while (myPort.available() > 0) {
    inByte = myPort.readBytes();

    trama1 = inByte[1];
    trama2 = inByte[2];
    Ultrasonido = (trama1 & 0x1F);
    Ultrasonido = (Ultrasonido << 7);
    Ultrasonido = (Ultrasonido | trama2);
    datoUS = Ultrasonido;
    Boton = trama1 & 0x40;
    Foto1 = trama1 & 0x20;
    
    trama3 = inByte[3];
    trama4 = inByte[4];
    EjeX = (trama3 & 0x1F);
    EjeX = (EjeX << 7);
    EjeX = (EjeX | trama4);
    datoEjeX = EjeX-1870;
    Foto2 = trama3 & 0x40;
    Foto3 = trama3 & 0x20;

    trama5 = inByte[5];
    trama6 = inByte[6];
    EjeY = (trama5 & 0x1F);
    EjeY = (EjeY << 7);
    EjeY = (EjeY | trama6);
    datoEjeY = EjeY-1996;
    Foto4 = trama5 & 0x40;
    Foto5 = trama5 & 0x20;
 
    trama7 = inByte[7];
    trama8 = inByte[8];
    EjeZ = (trama1 & 0x7F);
    EjeZ = (EjeZ << 7);
    EjeZ = (EjeZ | trama8);
    datoEjeZ = EjeZ-1982;
   }
}