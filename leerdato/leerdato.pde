size(1000, 400);
// Open a file and read its binary data 
byte b[] = loadBytes("prueba2x.txt"); 
float a=0, s=0, y, y2, x=10, suma=0;
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
    y= (s-7.5)*20;
    suma++;
    for(int j=0; j < 4096; j++){
      if(j==s){
      hist[j]++;
      }
    }
    s = 0;
    //println("y= " + y);
    k=11;
    //line(x, 160, x, (160-y));
    //x+=0.5;
  }
}  


//Se dibuja el histograma
    println("suma="+suma);
    float histMax = max(hist);
    //println(histMax);
    x=0;
    a=0;
    for(int j=0; j < 4096; j++){
      voltaje[j] = a*3/4095;
      a++;
      if(hist[j]!=0)
      contador[j]=j;
    }
    
    while (hist[contadormin] == 0) {
      contadormin++;
    } 
    //println(contadormin);
    
    while (hist[contadorMax] == 0) {
      contadorMax--;
    } 
    //println(contadorMax);
    
      strokeWeight(2);
      strokeCap(SQUARE);
      text("Voltaje (V)", width/2, height-10 );
      text("Frecuencia(%)", 40, height-355 );
      
    for(int j=0; j < 11; j++){ 
      a=histMax*10/suma;
      text(j*a, 10, height-43-j*30);
      text("-", 50, height-45-j*30);
     // println("a="+a);
    }
    for(int j=0; j < 4096; j++){
      y2=hist[j]*300/histMax;
      x= map(j, contadormin, contadorMax, 70, width-30);
      line(55, height-48, 55, height-350); //Linea vertical
      line(55, height-48, width-25, height-48); //Linea horizontal
      
      if(j%21==0 & x<width-25 & x>45 ){
        text(voltaje[j], x-15, height-25 );
        text("|", x, height-38 );
      }
      if(y2!=0){
        line(x, height-50, x, height-50-y2);
       // println("["+j+"]"+ hist[j] + " " + y2 + " " + voltaje[j]);  
      }   
    }
   