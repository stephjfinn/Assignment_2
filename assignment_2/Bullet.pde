class Bullet
{
  float toLive = 10.0f;
  float ellapsed = 0.0;
  float timeDelta = 1.0f / 60.0f;
  PVector position;
  PVector forward;
  float theta;
  int player;
  color colour;
  boolean alive;
  PVector velocity;
  
  Bullet()
  {
    alive = true;
    position = new PVector(width / 2, height / 2);
    forward = new PVector(0, -1);
  }
  
  void update()
  {
    ellapsed += timeDelta;
    if (ellapsed > toLive)
    {
      alive = false;
    }
    forward.x = sin(theta);
    forward.y = -cos(theta);
    float speed = 10.0f;
 
    PVector velocity = PVector.mult(forward, speed);
    position.add(forward);
        
  }
  
  void display()
  {
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    stroke(234);
    line(0, - 5, 0, 5);
    popMatrix();
  }
}
