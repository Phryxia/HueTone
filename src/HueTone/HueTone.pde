import controlP5.*;

/*
  UI Library
*/
int RESOLUTION = 360;
PImage img = null;
ControlP5 cp5;
Statistics imgSt;
LineGraph lg;
void setup()
{
  size(720, 360);
  colorMode(HSB, 1.0f);
  
  // CP5
  cp5 = new ControlP5(this);
  cp5.addButton("openImage", 0, 20, height - 35, 80, 15);
  cp5.addButton("saveImage", 0, 120, height - 35, 80, 15);
  
  // Statistics
  imgSt = new Statistics(RESOLUTION);
  
  // Graph
  lg = new LineGraph(880, 400);
}

void draw()
{
  background(1);
  if(img != null)
  {
    image(img, 20, 20, 200, 200);
    lg.draw(240, 20, 440, 200);
    drawRainbow(240, 240, 440, 20);
  }
}

boolean isLoaded = false;
void openImage()
{
  selectInput("Select imagem file", "_openImage");
  isLoaded = false;
  while(!isLoaded) print();
}

void _openImage(File iFile)
{
  if(iFile != null)
  {
    img = loadImage(iFile.getAbsolutePath());
    imgSt.scanImage(img);
    lg.clear();
    for(int i = 0; i < RESOLUTION; ++i)
    {
      float h = map(i, 0, RESOLUTION, 0, 1);
      lg.add(h * 360, imgSt.getP_H_(h));
    }
  }
  isLoaded = true;
}

void saveImage()
{
  selectOutput("Save image...", "_saveImage");
  isLoaded = false;
  while(!isLoaded) print();
}

void _saveImage(File oFile)
{
  if(oFile != null)
  {
    lg.pg.save(oFile.getAbsolutePath());
  }
}