public class Statistics
{
  private double[] pH_h; // P(H=h)
  private double[] hSum;
  private int   hCntTotal;
  
  public Statistics(int resolution)
  {
    pH_h = new double[resolution];
    hSum = new double[resolution];
    hCntTotal = 0;
  }
  
  public void scanImage(PImage img)
  {
    float h;
    int index;
    reset();
    img.loadPixels();
    for(int p = 0; p < img.pixels.length; ++p)
    {
      h = hue(img.pixels[p]);
      index = hueToIndex(h);
      //hSum[index] += brightness(img.pixels[p]) * saturation(img.pixels[p]);
      //hSum[index] += brightness(img.pixels[p]) * saturation(img.pixels[p]);
      hSum[index] += cPow(img.pixels[p]);
    }
    hCntTotal = img.pixels.length;
    analyze();
  }
  
  /**
    Return P(H=h) at scanned image.
  */
  public double getP_H_(float h)
  {
    return pH_h[hueToIndex(h)];
  }
  
  public int getResolution()
  {
    return pH_h.length;
  }
  
  protected int hueToIndex(float h)
  {
    h = fmod(h, 1);
    return (int)Math.round(map(h, 0, 1, 0, pH_h.length - 1));
  }
  
  protected float indexToHue(int index)
  {
    return map(index, 0, pH_h.length, 0, 1);
  }
  
  protected void reset()
  {
    for(int i = 0; i < getResolution(); ++i)
    {
      pH_h[i] = 0.0;
      hSum[i] = 0;
    }
    hCntTotal = 0;
  }
  
  protected void analyze()
  {
    for(int i = 0; i < getResolution(); ++i)
    {
      pH_h[i] = (double)hSum[i] / hCntTotal;
    }
  }
}