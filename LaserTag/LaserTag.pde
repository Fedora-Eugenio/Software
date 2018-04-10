import ddf.minim.*;
Minim soundengine;
AudioSample disparo;
AudioSample hit;
AudioSample recarga;
AudioSample cambio;
AudioSample Tron;
boolean Reset=true, Gatillo=false, Disponible=true, shoot=false, inicio=true;
PImage silueta;
float Disparos, Hit, Puntaje;
int Diana, Blanco, Tiempo=3600, Modo=1, objetivo=1, contador=0, espera=0, j=0, k=0;
float[] distribution = new float[360];
PFont font1;

void setup(){
  size(1000, 500);
  soundengine = new Minim(this);
  disparo = soundengine.loadSample("disparo.mp3", 1024);
  hit = soundengine.loadSample("hit.mp3", 1024);
  recarga = soundengine.loadSample("recarga.mp3", 1024);
  cambio = soundengine.loadSample("cambio.mp3", 1024);
  Tron = soundengine.loadSample("TronLegacy.mp3", 2048);
  silueta = loadImage("silueta.jpg");
  font1 = loadFont("Playbill-70.vlw");
  for (int i = 0; i < distribution.length; i++) {
    distribution[i] = int(randomGaussian() * 150);
  }
}

void draw() {
  if(contador==0){
    //Tron.trigger();
  }
  contador++;
   if(contador==11700){
      contador=0;
    }
    if (mousePressed==true) {
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
  Puntaje=Hit/Disparos;
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
        if(Blanco!=1){
          Hit++;
          hit.trigger();
          image(silueta, 15, 0);
          Blanco=1;
        }
        break;
      case 2: 
        ellipse(175, 200, 20, 20);
        if(Blanco!=2){
          Hit++;
          hit.trigger();
          image(silueta, 15, 0);
          Blanco=2;
        }
        break;
      case 3: 
        ellipse(325, 200, 20, 20); 
        if(Blanco!=3){
           Hit++;
           hit.trigger();
           image(silueta, 15, 0);
           Blanco=3;
        }
        break;
      case 4: 
        ellipse(175, 350, 20, 20); 
        if(Blanco!=4){
          Hit++;
          hit.trigger();
          image(silueta, 15, 0);
          Blanco=4;
        }
        break;
      case 5: 
        ellipse(325, 350, 20, 20);
        if(Blanco!=5){
          Hit++;
          hit.trigger();
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
        if(Diana!=0){
          Hit++;
          hit.trigger();
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
      if(Diana==objetivo){
         Hit++;
         hit.trigger();
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