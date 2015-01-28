class Enemy
{
  PVector velocity;
  PVector location;
  int enemySize = 50;
  color colour;
  boolean alive;
  int health;
 
  Enemy()
  {
    alive = true;
    health = 2;
    location = new PVector((int) random(0, (displayWidth/enemySize)), (int) random((-displayHeight/enemySize), 0));
    velocity = new PVector(0, 1);
  }
  
  Enemy(int enemySize, color colour)
  {
    this();
    this.enemySize = enemySize;
    this.colour = colour;
  }
  
  void update()
  {
    location.add(velocity);
    for (int i = 0; i < enemies.size(); i++)
    {
      enemies.get(i);
      if (location.y > 550)
      {
        int x = (int) random(0, (screenWidth/enemySize));
        x = x * enemySize;
        location.x = x;
        int y = (int) random((-screenHeight/enemySize), 0);
        y = y * enemySize;
        location.y = y;
        alive = true;
      }
    }
  }
  
  void display()
  {
    stroke(colour);
    fill(colour);
    image(enemy, location.x, location.y);
  }
}
