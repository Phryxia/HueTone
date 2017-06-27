public class LineGraph
{
  PGraphics pg = null;
  color cBg = color(1);
  color cGrid = color(0.5);
  color cLine = color(0);
  color cGridSub = color(0.75);
  color cText = color(0.1);
  ArrayList <PVector> ptList;
  float xMin = 0f;
  float xMax = 360.0f;
  float yMin = 0f;
  float yMax = 0.015f;
  float xRes = 10.0f;
  float yRes = 0.0005f;
  int xTextDiff = 6;
  int yTextDiff = 5;
  boolean isCached = false;
  
  public LineGraph(int w, int h)
  {
    pg = createGraphics(w, h);
    ptList = new ArrayList <PVector> ();
  }
  
  public void add(double x, double y)
  {
    ptList.add(new PVector((float)x, (float)y));
    isCached = false;
  }
  
  public void clear()
  {
    ptList.clear();
  }
  
  public void draw(int x, int y, int w, int h)
  {
    if(!isCached)
    {
      _draw();
      isCached = true;
    }
    image(pg, x, y, w, h);
  }
  
  private void _draw()
  {
    boolean isFirst = true;

    // Draw grid
    pg.beginDraw();
    pg.noStroke();
    pg.fill(cBg);
    pg.background(cBg);
    
    pg.stroke(cGrid);
    pg.strokeWeight(1.2);
    int cnt = 0;
    for(float x = xMin; x <= xMax; x += xRes)
    {
      float px = map(x, xMin, xMax, 0, pg.width);
      if(cnt++ % xTextDiff == 0) {
        pg.stroke(cGrid);
      } else {
        pg.stroke(cGridSub);
      }
      pg.line(px, 0, px, pg.height);
    }
    cnt = 0;
    for(float y = yMin; y <= yMax; y += yRes)
    {
      float py = map(y, yMin, yMax, pg.height, 0);
      if(cnt++ % yTextDiff == 0) {
        pg.stroke(cGrid);
      } else {
        pg.stroke(cGridSub);
      }
      pg.line(0, py, pg.width, py);
    }
    
    // Draw points
    pg.stroke(cLine);
    pg.strokeWeight(1);
    pg.fill(cLine);
    float ppx = 0, ppy = 0;
    for(PVector pt : ptList)
    {
      float px = map(pt.x, xMin, xMax, 0, pg.width);
      float py = map(pt.y, yMin, yMax, pg.height, 0);
      pg.ellipse(px, py, 2, 2);
      if(!isFirst)
      {
        pg.line(ppx, ppy, px, py);
      }
      ppx = px;
      ppy = py;
      isFirst = false;
    }
    
    // Draw Text
    pg.fill(cText);
    pg.textSize(8);
    cnt = 0;
    for(float x = xMin; x <= xMax; x += xRes)
    {
      float px = map(x, xMin, xMax, 0, pg.width);
      if(cnt++ % xTextDiff == 0) {
        pg.text(nf(x, 1, 0), px + 2, pg.height - 2);
      }
    }
    cnt = 0;
    for(float y = yMin; y <= yMax; y += yRes)
    {
      float py = map(y, yMin, yMax, pg.height, 0);
      if(cnt++ % yTextDiff == 0) {
        pg.text(nf(y, 1, 4), 2, py - 2);
      }
    }
    
    pg.endDraw();
  }
}