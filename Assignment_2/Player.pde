class Player
{
  PVector position;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  color colour;
  float theta = 0;
  float w = 25;
  float h = 25;
  float timeDelta = 0.5f / 60.0f;
  float fireRate = 10.0f;
  float ellapsed = 0.0f;
  float toPass = 1.0f / fireRate;
  boolean alive;
  boolean invincible;
  int health;
  float timer = 0.0f;
  int score;
  int[] healthBar = new int[10];
    
  Player()
  {
    position = new PVector(width / 2, height / 2);
    alive = true;
    invincible = false;
    health = 10;
    score = 0;
    for(int i=0; i<10; i++)
    {
      healthBar[i] = 1;
    }
  }
  
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
  }
  
  Player(int index, color colour, XML xml)
  {
    this(index
        , colour
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  void update()
  {
    ellapsed += timeDelta;
    if(invincible == true)
    {
      timer += 0.00025f;
      if(timer > toPass)
      {
        invincible = false;
      }
    }
    if (checkKey(up) && position.y > 0)
    {
      if (theta < 0)
      {
        theta += 0.1f;
      }
      if (theta > 0)
      {
        theta -= 0.1f;
      }
      position.y -= 1;
    }
    if (checkKey(down) && position.y < height)
    {
      position.y += 1;
    }
    if (checkKey(left) && position.x > 0)
    {
      if (theta >= -1.5f)
      {
        theta -= 0.1f;
      }
      position.x -= 1;
    }    
    if (checkKey(right) && position.x < width)
    {
      if (theta <= 1.5f)
      {
        theta += 0.1f;
      }
      position.x += 1;
    }
    if (checkKey(start))
    {
      println("Player " + index + " start");
    }
    if (checkKey(button1))
    {
      println("Player " + index + " button 1");
      if (ellapsed > toPass)
      {
        Bullet b = new Bullet();
        b.position = position.get();
        b.theta = theta;
        bullets.add(b);
        
        ellapsed = 0.0f;
      }
    }
    if (checkKey(button2))
    {
      println("Player " + index + " butt2");
    }    
  }
  
  void display()
  {
    float halfWidth = w / 2;
    float halfHeight = h / 2;
    
    pushMatrix();
    translate(position.x, position.y);   
    rotate(theta);
    stroke(colour);
    if(invincible == true)
    {
      stroke(255, 215, 0);
    }
    line(-halfWidth, halfHeight, 0, -halfHeight);
    line(0, -halfHeight, halfWidth, halfWidth);
    line(halfWidth, halfHeight, 0, 0);
    line(0,0,  -halfWidth, halfHeight);
    popMatrix();
  
    healthBar1();
    healthBar2();
  }  
  
  void healthBar1()
  {
    stroke(162);
    noFill();
    rect(screenWidth/14, screenHeight/8, 180, 20);
    
    if (players.get(0).health > 0)
    {
      for(int i=0; i < 10; i++)
      {
        if (players.get(0).healthBar[i] == 1)
        {
          //if statement to determine colour of health depending on level of health
          if (players.get(0).healthBar[2] == 0)
          {
            fill(255, 0, 0);
          }
          else if (players.get(0).healthBar[5] == 0)
          {
            fill(255, 170, 0);
          }
          else
          {
            fill(0, 255, 0);
          }
          rect(screenWidth/14, screenHeight/8, (20*i), 20);
        }
      }
    }
    fill(255);
    text("Player 1 Score: " + players.get(0).score, 35, 60);
  }
  
  void healthBar2()
  {
    stroke(162);
    noFill();
    rect((screenWidth/14)*8, screenHeight/8, 180, 20);
    
    if (players.get(1).health > 0)
    {
      for(int i=0; i < 10; i++)
      {
        if (players.get(1).healthBar[i] == 1)
        {
          //if statement to determine colour of health depending on level of health
          if (players.get(1).healthBar[2] == 0)
          {
            fill(255, 0, 0);
          }
          else if (players.get(1).healthBar[5] == 0)
          {
            fill(255, 170, 0);
          }
          else
          {
            fill(0, 255, 0);
          }
          rect((screenWidth/14)*8, screenHeight/8, (20*i), 20);
        }
      }
    }
    fill(255);
    text("Player 2 Score: " + players.get(1).score, 370, 60);
  }
}

