import ddf.minim.*;
Minim soundengine;
AudioSample disparo;
AudioSample hit;
AudioSample recarga;
AudioSample cambio;
AudioSample Tron;
boolean Reset=true, shoot=false, inicio=true;
PImage silueta;
float Disparos, Hit, Puntaje;
int Diana, Blanco, Tiempo=0, Modo=1, objetivo=1, contador=0;

void setup(){
  size(900, 500);
  soundengine = new Minim(this);
  disparo = soundengine.loadSample("disparo.mp3", 1024);
  hit = soundengine.loadSample("hit.mp3", 1024);
  recarga = soundengine.loadSample("recarga.mp3", 1024);
  cambio = soundengine.loadSample("cambio.mp3", 1024);
  Tron = soundengine.loadSample("TronLegacy.mp3", 2048);
  silueta = loadImage("silueta.jpg");
}

void draw() {
  if(contador==0){
    Tron.trigger();
   // Tron.setGain(0.9);
  }
  contador++;
   if(contador==11700){
      contador=0;
    }
  if(inicio){
    background(0);
    text("LASERTAG", 400, 200);
    text("Aprieta el gatillo para continuar", 350, 250);  
  }else{

  if(Reset){
      Disparos=0;
      Hit=0;
      Puntaje=0;
      Diana=0;
      Blanco=0;
      Tiempo=0;
      shoot=false;
      Reset=false;
  }
  background(0);
  fill(255);
  text("Modo= " + Modo, 600, 50 );
  text("Disparos= " + Disparos, 600, 100 );
  text("Hit= " + Hit, 600, 150 );
  text("Puntaje= " + Puntaje, 600, 200 );
  text("Tiempo= " + Tiempo, 600, 250 );
  text("Contador= " + contador, 600, 400 );
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
  switch(Modo){
    case 1:
      if(shoot){
        Disparos++;
        disparo.trigger();
        shoot=false;
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
      if((Tiempo>0 & Tiempo<3600) | (shoot & Disparos==0) ){
        Tiempo++;
        if(shoot){
          Disparos++;
          disparo.trigger();
          shoot=false;
        }
        if(Diana!=0){
          Hit++;
          hit.trigger();
          image(silueta, 15, 0);
          Diana=0;
        }
      }
      if(Tiempo==3600){
      text("El tiempo se acabó ", 600, 300 );
      }
      break;
      
    case 3:
      fill(255);
      text("Objetivo= " + objetivo, 600, 350 );
      if(shoot){
         Disparos++;
         disparo.trigger();
         shoot=false;
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
    if (key == 'd') {
      shoot=true;
      inicio=false;
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
      Reset=true;
    }
}