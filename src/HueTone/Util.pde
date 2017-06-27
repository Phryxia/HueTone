float fmod(float x, float m) 
{
  return x - ((int)(x/m))*m;
}

float hmap(float x)
{
  return 2 * x * (1 - x);
}

float cPow(color c)
{
  /*
  float r = red(c);
  float g = green(c);
  float b = blue(c);
  return 0.5 * max(r, g, b) + 0.5 * min(r, g, b);*/
  //return saturation(c) * (1 - brightness(c));
  return saturation(c) * brightness(c);
}

void drawRainbow(int x, int y, int w, int h)
{
  for(int px = x; px < x + w; ++px) {
    stroke(map(px, x, x + w, 0, 1), 1, 1);
    line(px, y, px, y + h);
  }
}