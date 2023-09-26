class Particle 
{
  float PositionX;
  float PositionY;
  float increase = 0.8;
  float theta = 0;
  color CLR;

  Particle(float a, float b, color c) 
  {
     this.PositionX = a;
     this.PositionY = b;
     this.CLR = c;
  }
  
  void updated() 
  {
    theta = noise( PositionX * 0.006, PositionY * 0.004, increase) * TWO_PI;
    PositionX = PositionX + 2 * cos(theta);
    PositionX = PositionX + 2 * sin(theta);
  }

  void Show()
  {
    if ( PositionX > 0 &&  PositionX < width && PositionY > 0  && PositionY < height) 
    {
      pixels[(int)PositionX + (int)PositionY * width] =  CLR;
    }
  }

  void Cover() 
  {
    if (PositionX > width)
    {
       PositionX =  0;
    }
    else if (PositionX < 0) 
    {
       PositionX = width;
    }
    else if (PositionY > height)
    {
      PositionY =  0;
    }
    else if (PositionY < 0 ) 
    {
      PositionY = height;
    }
  }
}
