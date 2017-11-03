PImage photoAmarela;
PImage photoAzul;
PImage photoVerde;
PImage photoBrancoQuente;
PImage photoVermelho;



import processing.io.*; //  descomentar
 int brancoFrio = 20;
 int amarelo = 21;
 int azul = 2;
 int verde = 3;
 int brancoQuente = 4;
 int vermelho = 5;


//import processing.video.*;
//Capture video;

color leitura;
int estado = 0;
/*
num. estado  |  Estado
 0         | Esperando mouse/touch para pausar o vídeo
 1         | Preencher o ponto pintado com uma cor
 2         | Pega a média das cores dos pontos pintdos
 */

import gohai.glvideo.*;
GLCapture video;
boolean recording = false;

void setup() {
   GPIO.pinMode(brancoFrio, GPIO.OUTPUT);
   GPIO.pinMode(amarelo, GPIO.OUTPUT);
   GPIO.pinMode(azul, GPIO.OUTPUT);
   GPIO.pinMode(verde, GPIO.OUTPUT);
   GPIO.pinMode(brancoQuente, GPIO.OUTPUT);
   GPIO.pinMode(vermelho, GPIO.OUTPUT);
   
   GPIO.digitalWrite(brancoFrio, GPIO.LOW);
   GPIO.digitalWrite(amarelo, GPIO.HIGH);
   GPIO.digitalWrite(azul, GPIO.LOW);
   GPIO.digitalWrite(verde, GPIO.LOW);
   GPIO.digitalWrite(brancoQuente, GPIO.LOW);
   GPIO.digitalWrite(vermelho, GPIO.LOW);
   

  size(320, 200, P2D);
  String[] devices = GLCapture.list();
  println("Devices:");
  printArray(devices);
  if (0 < devices.length) {
    String[] configs = GLCapture.configs(devices[0]);
    println("Configs:");
    printArray(configs);
  }

  // this will use the first recognized camera by default
  video = new GLCapture(this);
  video.start();



  //println(Capture.list());
  //video = new Capture(this, 320, 240);
  //video.start();
}

//void captureEvent(Capture video) {
//  video.read();
//}

void draw() {
  background(0);
  if (video.available()) {
    video.read();
  }

  switch(estado) {
  case 0: 
    image(video, 0, 0);
    //println("video");
    break;


  case 1: 
    image(video, 0, 0);
    //println("1:video");
    break;


  case 2: 
    image(pintado, 0, 0);
    //println("2:pintado");
    leitura = corMedia (photo, pintado);
    println("Branco frio:               r: ", red(leitura), "    g: ", green(leitura), "      b: ", blue(leitura));
    estado++;
    break;

  case 3: 
    /*  descomentar
     GPIO.digitalWrite(brancoFrio, GPIO.LOW);
     GPIO.digitalWrite(amarelo, GPIO.HIGH);
     */
    delay(1000);
    image(video, 0, 0);
    photoAmarela = get();
    leitura = corMedia (photoAmarela, pintado);
    // println("Amarelo                    r: ", red(leitura), "    g: ", green(leitura), "      b: ", blue(leitura));
    estado++;
    break;

  case 4:
    /*  descomentar
     GPIO.digitalWrite(amarelo, GPIO.LOW);
     GPIO.digitalWrite(azul, GPIO.HIGH);
     */
    delay(1000);
    image(video, 0, 0);
    photoAzul = get();
    leitura = corMedia (photoAzul, pintado);
    // println("Azul                       r: ", red(leitura), "    g: ", green(leitura), "      b: ", blue(leitura));
    estado++;
    break;


  case 5:
    /*  descomentar
     GPIO.digitalWrite(azul, GPIO.LOW);
     GPIO.digitalWrite(verde, GPIO.HIGH);
     */
    delay(1000);
    image(video, 0, 0);
    photoVerde = get();
    leitura = corMedia (photoVerde, pintado);
    //  println("Verde                      r: ", red(leitura), "    g: ", green(leitura), "      b: ", blue(leitura));
    estado++;
    break;

  case 6:
    /*  descomentar
     GPIO.digitalWrite(verde, GPIO.LOW);
     GPIO.digitalWrite(brancoQuente, GPIO.HIGH);
     */
    delay(1000);
    image(video, 0, 0);
    photoBrancoQuente = get();
    leitura = corMedia (photoBrancoQuente, pintado);
    //  println("Branco quente              r: ", red(leitura), "    g: ", green(leitura), "      b: ", blue(leitura));
    estado++;
    break;


  case 7:
    /*  descomentar
     GPIO.digitalWrite(brancoQuente, GPIO.LOW);
     GPIO.digitalWrite(vermelho, GPIO.HIGH);
     */
    delay(1000);
    image(video, 0, 0);
    photoVermelho = get();
    leitura = corMedia (photoVermelho, pintado);
    //   println("vermelho                   r: ", red(leitura), "    g: ", green(leitura), "      b: ", blue(leitura));
    estado++;
    break;



  case 8:
    image(video, 0, 0);
    println("terminou");
    estado++;
    break;

  case 9:
    image(video, 0, 0);
    break;
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    switch(estado) {
    case 0: 
      //video.stop();
      photo = get();
      estado++;
      break;
    case 1: 
      saveFrame("output/frames################1.png");
      floodFill(mouseX, mouseY, get(mouseX, mouseY), 10);    
      saveFrame("output/frames################2.png");
      pintado = get();
      estado++;
      break;
    }
  }
  else if (mouseButton == RIGHT) {
    estado = 0;
  }
}

void keyPressed() {
  // If we press r, start or stop recording!
  if (key == 'r' || key == 'R') {
    estado = 0;
  }
}