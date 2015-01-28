class Star
{
  PVector velocity;
  PVector location;
  int starSize = 25;
  color colour;
  boolean alive;
  boolean flash;
  int count;
 
  Star()
  {
    location = new PVector((int) random(0, (displayWidth/starSize)), (int) random((-displayHeight/starSize), 0));
    velocity = new PVector(0, 1);
    alive = true;
  }
  
  Star(int starSize, color colour)
  {
    this();
    this.starSize = starSize;
    this.colour = colour;
  }
  
  void update()
  {
    count++;
    if(count%5 == 0)
    {
      flash = !flash;
    }
    location.add(velocity);
    for (int i = 0; i < stars.size(); i++)
    {
      stars.get(i);
      if (location.y > 525)
      {
        int x = (int) random(0, (screenWidth/starSize));
        x = x * starSize;
        location.x = x;
        int y = (int) random((-screenHeight/starSize), 0);
        y = y * starSize;
        location.y = y;
        println("respawn");
        alive = true;
      }
    }
  }
  
  void display()
  {
    if(flash == true)
    {
      image(star1, location.x, location.y);
    }
    else
    {
      image(star2, location.x, location.y);
    }
  }
}
