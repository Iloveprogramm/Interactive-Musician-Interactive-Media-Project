class Firework
{
  int FireWorkLW = 10;
  int FireWorkWeight = 6;
  float TempPositionX;
  float TempPositionY;
  float OldPositionX;
  float OldPositionY;
  float UpSpeed = random(10) + 10;
  float TarGetX;
  float TarGetY;
  float ExplosionTime;
  int FireWorkAmount = ceil(random(30)) + 20;
  float FireWorkAngle = 1080/FireWorkAmount;
  int FireWorkduration = ceil(random(4))*20 + 30;
  boolean Launch;
  boolean Explosion;
  boolean Hide = true;
  void draw()
  {
    if((Launch == false) && (Explosion == true) && (Hide == false))
    {
      CalculationBang();
      strokeWeight(FireWorkWeight);
      stroke(random(255)*random(255),random(255)+200,random(255)+50);
      for(int i = 0; i < FireWorkAmount; i++)
      {
          pushMatrix();
          translate(TempPositionX,TempPositionY);
          point(sin(radians(i*FireWorkAngle))*ExplosionTime,cos(radians(i*FireWorkAngle))*ExplosionTime);
          popMatrix();
       }
    }
    else if((Launch == true) && (Explosion == false) && (Hide == false))
    {
      pushStyle();
      Calculationlaunching();
      strokeWeight(FireWorkLW);
      stroke(255);
      line(TempPositionX,TempPositionY,OldPositionX,OldPositionY);
      popStyle();
    }
  }
  
  void Launching()
  {
    TempPositionX = mouseX; 
    TempPositionY = height;
    TarGetX = mouseX;
    TarGetY = mouseY;
    Launch = true;
    Explosion = Hide = false;
  }
  
  void Calculationlaunching()
  {
    OldPositionX = TempPositionX;
    OldPositionY = TempPositionY;
    if(dist(TempPositionX,TempPositionY,TarGetX,TarGetY) > 6)
    {
      TempPositionX = TempPositionX + (TarGetX - TempPositionX)/2;
      TempPositionY = TempPositionY - UpSpeed;
    }
    else if(dist(TempPositionX,TempPositionY,TarGetX,TarGetY) < 6)
    {
      ExplosionTime = 0;
      Explosion = true;
      Launch = Hide = false;
    }
  }
  
  void CalculationBang()
  {
    if(ExplosionTime < FireWorkduration)
    {
      ExplosionTime = ExplosionTime + 0.4;
    }
    else if(ExplosionTime > FireWorkduration)
    {
      Hide = true;
      Launch = Explosion = false;
    }
  }
}
