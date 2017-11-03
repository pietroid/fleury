PImage photo;

void screenCapture (PImage img) {
  int tamanho = width*height;
  loadPixels();
  img.loadPixels();
  for (int i=0; i<tamanho; i++) {
    img.pixels[i] = pixels[i];
  }
}

color corMedia (PImage img, PImage marcada) {
  int tamanho = img.width*img.height;
  int vermelho, verde, azul;
  int pixCont = 0;
  vermelho = verde = azul = 0;

  for (int i=0; i<tamanho; i++) {
    if (marcada.pixels[i]==color(255, 0, 0)) {
      vermelho += red(img.pixels[i]);
      verde += green(img.pixels[i]);
      azul += blue(img.pixels[i]);
      pixCont++;
    }
  }
  vermelho /= pixCont;
  verde /= pixCont;
  azul /= pixCont;
  return color(vermelho, verde, azul);
}