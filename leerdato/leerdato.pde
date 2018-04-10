size(1000, 400);
// Open a file and read its binary data 
byte b[] = loadBytes("pruebaUS.txt"); 
float a=0, s=0, y2, x=10, Total=0, Suma=0;
int k=11, contadorMax=4095, contadormin=0;
float[] hist = new float[4096];
float contador[]=new float[4096];;
float[] voltaje = new float[4096];
fill(0);


for (int i = 0; i < b.length; i++) { 
  if ( b[i]==49){
  a= pow(2, k);
  s=s+a;
  k--; 
  }
  if ( b[i]==48){
  k--;
  }
  if ( b[i]==13){
    Total++;
    for(int j=0; j < 4096; j++){
      if(j==s){
      hist[j]++;
      Suma = Suma+s;
      }
    }
    s = 0;
    k=11;
  }
}  


//Se dibuja el histograma
    
    float histMax = max(hist);
    x=0;
    a=0;
    for(int j=0; j < 4096; j++){
      voltaje[j] = a; //*3/4095;
      
      a++;
      if(hist[j]!=0)
      contador[j]=j;
    }
    
    while (hist[contadormin] == 0) {
      contadormin++;
    } 
    
    while (hist[contadorMax] == 0) {
      contadorMax--;
    } 
    
      strokeWeight(2);
      strokeCap(SQUARE);
      text("Valor", width/2, height-10 );
      text("Frecuencia(%)", 40, height-355 );
      
    for(int j=0; j < 11; j++){ 
      a=j*histMax*10/Total;
      String freq = nfc(a, 2);
      text(freq, 10, height-43-j*30);
      text("-", 50, height-45-j*30); 
      strokeWeight(0.5);
      line(55, height-49-j*30, width-25, height-49-j*30);
    }
    strokeWeight(2);
    for(int j=0; j < 4096; j++){
      y2=hist[j]*300/histMax;
      x= map(j, contadormin, contadorMax, 70, width-30);
      line(55, height-48, 55, height-350); //Linea vertical
      line(55, height-48, width-25, height-48); //Linea horizontal
      
      if(j%50==0 & x<width-25 & x>45 ){
        String valor = nfc(voltaje[j], 0);
        text(valor, x-15, height-25 );
        text("|", x, height-38 );
      }
      if(y2!=0){
        line(x, height-50, x, height-50-y2);
         println("["+j+"]"+ hist[j] + " " + y2 + " " + voltaje[j]);
      }   
    }
   float Prom = (Suma)/Total;
   String Promedio = nfc(Prom, 2);
   println("Total="+ Total +" Suma= "+ Suma + " Promedio= " + Promedio);
   text("Número de muestras= " + Total, 750, 25);
   text("Promedio= " + Promedio, 750, 40);