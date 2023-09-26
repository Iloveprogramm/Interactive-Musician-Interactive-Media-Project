import processing.sound.*;
import controlP5.*;
ControlP5 cp5;
SinOsc[] sin1;
SoundFile song;
SoundFile music;
Firework[] FW = new Firework[20];

ArrayList<Ball> balls;
int ballWidth = 48;
boolean ballTrue = false;
boolean flicker = false;
int PP = 0;
int AA = 0; 
int KK;
int space = 50;
int a = 1;
boolean [][] Choosed;
boolean run;
boolean OneTime;
boolean Con = false;
boolean play;
float [][] MusicSound;
float Speed;
float T[] = new float[1002]; 
float Y[] = new float[1002]; 
float U[] = new float[1002];
float I[] = new float[1002]; 
float OO[] = new float[1002]; 
float HHH; 
float R = 2*sqrt((4*PI*(200*200)/1000)/(2*sqrt(3)));
float BB; 
float CC; 
float DD; 
float FF; 
float GG; 
int CCC = 10000;
color buttonColor = #E5F77F;

Particle[] particles;
float Vra;

SoundFile soundFile;  
AudioIn in; 
Amplitude ananlysis;
float Transparency = 0;
float value = 0;
int lastminute = 0;

void setup()
{
  size(1300, 800); //define window size
  balls = new ArrayList<Ball>();//define a arraylist to store balls
  
  in = new AudioIn(this,0); 
  ananlysis = new Amplitude(this);
  in.start();  
  ananlysis.input(in);  
  
  sin1 = new SinOsc[300];
  song = new SoundFile(this, "FireWork.mp3"); //import music
  song.stop();
  
  music = new SoundFile(this, "ballaudio.mp3");//import music
  music.stop();
  
  for(int j =0; j<10; j++)
  {
    sin1[j] = new SinOsc(this);
  }
  
  Choosed = new boolean[10][30];
  MusicSound = new float[10][30];
  for (int i = 0; i<10; i++)
  {
    for (int t = 0; t<30; t++)
    {
      Choosed[i][t] = false;
    }
    for (int t = 0; t<30; t++)
    {
       MusicSound[0][t] = random(255)+500;    //Control the sound
       MusicSound[1][t] = random(255)+600;  
       MusicSound[2][t] = random(255)+700; 
       MusicSound[3][t] = random(255)+800; 
       MusicSound[4][t] = random(255)+700;
       MusicSound[5][t] = random(255)+1000;
       MusicSound[6][t] = random(255)+300;
       MusicSound[7][t] = random(255)+1200;
       MusicSound[8][t] = random(255)+200;
       MusicSound[9][t] = random(255)+1400;
    }
  }

  cp5 = new ControlP5(this); //buttons
  cp5.addButton("Mute")
  .setPosition(10, 740)
  .setSize(100, 40);
  
  cp5.addButton("UnMute")
  .setPosition(120, 740)
  .setSize(100, 40);
  
  cp5.addButton("START")
  .setPosition(10, 650)
  .setSize(100, 40);
  
  cp5.addButton("Wave")
  .setPosition(280, 550)
  .setSize(100, 40);
  
  cp5.addButton("STOPWave")
  .setPosition(390, 550)
  .setSize(100, 40);
  
  cp5.addButton("TWinkling")
  .setPosition(280, 740)
  .setSize(100, 40);
  
  cp5.addButton("STOPTwinking")
  .setPosition(390, 740)
  .setSize(100, 40);
  
  cp5.addButton("MODEBALL")
  .setPosition(10, 550)
  .setSize(100, 40);
  
  cp5.addButton("MODEFIREWORK")
  .setPosition(120, 550)
  .setSize(100, 40);
  
  cp5.addSlider("a")
  .setPosition(500, 740)
  .setSize(100, 40)
  .setRange(0, 3)
  .setValue(1)
  .setColorCaptionLabel(color(20,20,20));
  

  for (int i = 0; i < FW.length; i++) //firework
  {
    FW[i] = new Firework();
  }
 
 
 //Code for changing ball
 for (int A = 0; A <= 1000; A++)
  {
    T[A] = random(-300,300);
    Y[A] = random(-300,300);
    U[A] = random(-300,300);
  }
 
 //Code for Particle
  noStroke();
  setParticles();
}

void draw()
{   
  fill(0, 408, 612); //text
  textSize(15);
  text("START TO PLAY", 10, 640);
  
  fill(0, 408, 612);
  textSize(15);
  text("TWINKING", 360, 730);
  
  fill(0, 408, 612);
  textSize(15);
  text("MUTE", 100, 730);
  
  fill(0, 408, 612);
  textSize(15);
  text("MODE(Pressed)", 70, 530);
  
  fill(0, 408, 612);
  textSize(15);
  text("WAVE", 360, 530);
  
  fill(0, 408, 612);
  textSize(15);
  text("Speed Control", 500, 730);
  
  fill(0, 408, 612);
  textSize(15);
  text("STOP", 210, 620);
  
  fill(0, 408, 612);
  textSize(15);
  text("FORWARD", 260, 620);
  
  fill(0, 408, 612);
  textSize(15);
  text("BACKWARD", 130, 620);
  
  
  
  //Code for Particle
  frameRate(40);
  Vra = map(mouseX, 0, width, 5, 35);
  fill(0, Vra);
  rect(0, 0, width, height);

  loadPixels();
  for (Particle p : particles) 
  {
    p.updated();
    p.Cover();
    p.Show();
  }
  updatePixels();
  

    //Code for music play
   if(run == true)
   {
     PP=(PP+1*a)%30;
   }
   
   for (int t =0; t<10; t++)
   {
      sin1[t].stop();
   }
    
   for (int i = 0; i<10; i++)
   {
      if (Choosed[i][PP]) 
      {
        sin1[i].freq(MusicSound[i][PP]);
        sin1[i].play();
        if(sin1[i].isPlaying()) //if the sin[i] is playing, change the particles
        {
          setParticles();
        }
    }
  }

   for (int i = 0; i<10; i++)
   {
      for (int j = 0; j<30; j++)
      {
            if (Choosed[i][j])
            {
                fill(#FF8383); //agfer pressed it
                if(flicker == true)
                {
                  fill(random(255),  random(255), random(255));
                }
            }
            else 
            {
                fill(255);//orginer color
            }
            if (j==PP) 
            {
                fill(#FF0303);//itertor color
            }
            rect(j*space+(space-20)/2, i*space+10+(space-20)/2, space-20, space-20, 12, 24, 48, 72);
       }
           //first
           fill(buttonColor);
           rect(140, 630, 50, 50);
           fill(#23DBFA);
           triangle(140, 655, 185, 635, 185, 675);
    
           //stop button, second
           fill(buttonColor);
           rect(200, 630, 50, 50);
           fill(#23DBFA);
           rect(205, 635, 40, 40);
       
          //third
          fill(buttonColor);
          rect(265, 630, 50, 50);
          fill(#23DBFA);
          triangle(270, 634, 270, 676, 313, 655);
          noStroke();
          fill(50,0,40,20);
          rect(0,0,width,height);
          for (int y = 0; y< FW.length; y++)
          {
                 FW[i].draw();
          }
    }
  

 //Code for changeing ball
for(int y = 0 ; y <= 1000 ; y++)
  {
     for (AA = y+1 ; AA <= 1000; AA++)
     {
        HHH = sqrt(((T[y]-T[AA])*(T[y]-T[AA]))+((Y[y]-Y[AA])*(Y[y]-Y[AA])));
        HHH = sqrt(((U[y]-U[AA])*(U[y]-U[AA]))+(HHH*HHH));
        if (U[y] > U[AA])
        {
          BB = T[y]; 
          CC = Y[y];
          DD = U[y]; 
          FF = I[y];
          GG = OO[y]; 
          T[y] = T[AA]; 
          Y[y] = Y[AA]; 
          U[y] = U[AA]; 
          I[y] = I[AA]; 
          OO[y] = OO[AA];  
          T[AA] = BB; 
          Y[AA] = CC; 
          U[AA] = DD; 
          I[AA] = FF; 
          OO[AA] = GG; 
        }
        else if(HHH < R)
        {
          T[y]  = T[y] - ((T[AA]-T[y])*((R-HHH)/(10*HHH)));
          Y[y]  = Y[y] - ((Y[AA]-Y[y])*((R-HHH)/(10*HHH)));
          U[y]  = U[y] - ((U[AA]-U[y])*((R-HHH)/(10*HHH)));
          T[AA] = T[AA] + ((T[AA]-T[y])*((R-HHH)/(10*HHH)));
          Y[AA] = Y[AA] + ((Y[AA]-Y[y])*((R-HHH)/(10*HHH)));
          U[AA] = U[AA] + ((U[AA]-U[y])*((R-HHH)/(10*HHH)));
          OO[y] = OO[y] + ((I[AA]-I[y])/50);
          OO[AA] = OO[AA] - ((I[AA]-I[y])/50);
          pushStyle();
          stroke(random(255),  random(255), random(255));
          line(T[y]*1.2*(200+I[y])/700+680,Y[y]*1.2*(200+I[y])/700+680,T[AA]*1.2*(200+I[AA])/700+680,Y[AA]*1.2*(200+I[AA])/700+680); 
          popStyle();
        }
     }
     HHH = sqrt((T[y]*T[y])+(Y[y]*Y[y]));
     HHH = sqrt((U[y]*U[y])+(HHH*HHH));
     T[y] = T[y] + (T[y]*(200-HHH)/(2*HHH));
     Y[y] = Y[y] + (Y[y]*(200-HHH)/(2*HHH));
     U[y] = U[y] + (U[y]*(200-HHH)/(2*HHH));
     DD = U[y];
     BB = T[y];
     U[y] = (DD*cos(float(300+-mouseX)/CCC))-(BB*sin(float(300+-mouseX)/CCC));
     T[y] = (DD*sin(float(300+-mouseX)/CCC))+(BB*cos(float(300+-mouseX)/CCC));
     DD = U[y]; 
     CC = Y[y];
     U[y] = (DD*cos(float(300+-mouseY)/CCC))-(CC*sin(float(300+-mouseY)/CCC));
     Y[y] = (DD*sin(float(300+-mouseY)/CCC))+(CC*cos(float(300+-mouseY)/CCC));
     OO[y] = OO[y] - (I[y]*0.01); 
     I[y] = I[y] + OO[y]; 
     OO[y] = OO[y] * 0.99;
  }
  
  
  if(Con == true)
  {
    for (int i = 0; i<10; i++)
    {
          for (int j = 0; j<30; j++)
          {
               if (Choosed[i][PP])
               {
                   fill(#23E4F7); //agfer pressed it
               }
             rect(j*space+(space-20)/2, i*space+10+(space-20)/2, space-20, space-20, 12, 24, 48, 72);
          }
    }
  }
  
  
  int m = millis();
  if(m>lastminute)
  {
    value = ananlysis.analyze();
  }
  
  OutsideDJSHAPE(value);
  
  fill(255);
  ellipse(1150,650,200,200);


  fill(255);
  ellipse(1150,650,180,180);

  
  InsideDJSHAPE(value);

  fill(255);
  ellipse(1150,650,50,50);
  
  for (int i = balls.size()-1; i >= 0; i--) 
  { 
    Ball ball = balls.get(i);
    ball.move();
    ball.display();
    if (ball.Ended()) 
    {
      balls.remove(i);
    }
  }
}

void mousePressed()
{
  int box2 = mouseY/space;
  int box1 = mouseX/space;
  if (box1>-1 && box1<30 && box2>-1 && box2<10) 
  {
     Choosed[box2][box1]=!Choosed[box2][box1];
     OneTime = false;
     if(ballTrue == true)
     {
         balls.add(new Ball(mouseX, mouseY, ballWidth));
         music.play();
     }
     else
     {
         for (int i = 0; i < FW.length; i++)
         {
             if((FW[i].Hide)&&(OneTime == false))
             {
                 FW[i].Launching();
                 OneTime = true;
                 song.play();
             }
         }
     }
     if(song.isPlaying()) //if the firework audio is playing, change the ball
     {
       for (int i = 0 ; i <= 1000 ; i++)
       {
           HHH = sqrt(((mouseX-(300+T[i]))*(mouseX-(300+T[i])))+((mouseY-(300+Y[i]))*(mouseY-(300+Y[i]))));
           if (U[i] > 0 && HHH < 600)
           { 
               AA = i;
               HHH = 600; 
           }
        }
        if (KK == 0)
        { 
              OO[AA] = -200;
              KK = 1;
        }
        else if(KK != 0)
        { 
             OO[AA] = 200;
             KK = 0;
        } 
   }
   if(music.isPlaying())
   {
     for (int i = 0 ; i <= 1000 ; i++)
       {
           HHH = sqrt(((mouseX-(300+T[i]))*(mouseX-(300+T[i])))+((mouseY-(300+Y[i]))*(mouseY-(300+Y[i]))));
           if (U[i] > 0 && HHH < 600)
           { 
               AA = i;
               HHH = 600; 
           }
        }
        if (KK == 0)
        { 
              OO[AA] = -200;
              KK = 1;
        }
        else if(KK != 0)
        { 
             OO[AA] = 200;
             KK = 0;
        } 
   }
}


  if (mouseX > 130 && mouseX < 180 && mouseY > 630 && mouseY < 680 )
  {
     PP = 1;
  }
  else if (mouseX > 210 && mouseX < 260 && mouseY > 630 && mouseY < 680 )
  {
     a = 0; 
  }
  else if (mouseX > 270 && mouseX < 320 && mouseY > 630 && mouseY < 680 )
  {
     a = 1; 
  }
}

void Mute()
{
  for (int j =0; j<30; j++)
  {
    MusicSound[0][j] = 0;     //set to 0 to mute
    MusicSound[1][j] = 0;  
    MusicSound[2][j] = 0; 
    MusicSound[3][j] = 0; 
    MusicSound[4][j] = 0;
    MusicSound[5][j] = 0;
    MusicSound[6][j] = 0;
    MusicSound[7][j] = 0;
    MusicSound[8][j] = 0;
    MusicSound[9][j] = 0;
  }
}

void UnMute() //UnMute method
{
  for (int j =0; j<30; j++)
  {
    MusicSound[0][j] = random(255)+500;    
    MusicSound[1][j] = random(255)+600;  
    MusicSound[2][j] = random(255)+700; 
    MusicSound[3][j] = random(255)+800; 
    MusicSound[4][j] = random(255)+700;
    MusicSound[5][j] = random(255)+1000;
    MusicSound[6][j] = random(255)+300;
    MusicSound[7][j] = random(255)+1200;
    MusicSound[8][j] = random(255)+200;
    MusicSound[9][j] = random(255)+1400;
  }
}

void START()
{
  run = true;
}

void Wave()
{
   Con = true;
}

void STOPWave()
{
  Con = false;
}

void TWinkling()
{
  flicker = true;
}

void STOPTwinking()
{
  flicker = false;
}


void MODEBALL()
{
  ballTrue = true;
}

void MODEFIREWORK()
{
  ballTrue = false;
}

//Method For Particle
void setParticles() 
{
  particles = new Particle[17800];
  for (int i = 0; i < 17800; i++) 
  { 
    float x = random(width);
    float y = random(height);
    int c = (color(random(255)*2, random(255)+100, random(255))+50);
    particles[i]= new Particle(x, y, c);
  }
}

void OutsideDJSHAPE(float ampvalue) //draw DJ
{
  Transparency = ampvalue*10000;
  fill(255,0,255,Transparency);
  ellipse(1150,550,5,5);

  fill(255,0,255,Transparency/5);
  ellipse(1150,550,5,5);
}

void InsideDJSHAPE(float ampvalue)//draw DJ
{
  float SIZE = 100;
  SIZE = 100*ampvalue*100 + 100;
  if(SIZE>380)
  {
     SIZE = 380;
  }
  fill(#14F5E4);
  ellipse(1150,650, SIZE,SIZE);

  fill(255,0,0,80);
  ellipse(1150,760, SIZE,SIZE/10);

  stroke(3);
  ellipse(1150,650, 50,50);
  ellipse(1150,650, 100, 100);

}
