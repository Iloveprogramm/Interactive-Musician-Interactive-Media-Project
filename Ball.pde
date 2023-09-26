class Ball 
{
  float Positionx;
  float Positiony;
  float BallSpeed = 30;
  float W;
  float duration = 255;
  
  Ball(float tempX, float tempY, float tempW)
  {
    this.Positionx = tempX;
    this.Positiony = tempY;
    this.W = tempW;
  }
  
  void move() 
  {
    BallSpeed = BallSpeed + 0.1;
    Positiony = Positiony + BallSpeed;
    if (Positiony > height) 
    {
      BallSpeed = BallSpeed * -0.8;
      Positiony = height;
    }
  }
  
  boolean Ended()
  {
    duration--;
    if (duration < 0) 
    {
      return true;
    } 
    else
    {
      return false;
    }
  }
  
  void display() 
  {
    fill(random(duration), random(duration), random(duration));
    ellipse(Positionx,Positiony,W,W);
  }
} 
