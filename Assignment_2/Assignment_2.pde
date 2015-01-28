ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Star> stars = new ArrayList<Star>();
boolean[] keys = new boolean[526];
int enemySize = 50;
int starSize = 25;
int playerSize = 15;
int numOfEnemies = 15;
int numOfStars = 2;
int screenWidth = 500;
int screenHeight = 500;
int loser;
PImage enemy;
PImage star1;
PImage star2;
PImage startscreen;
int splashScreens = 0;
PFont gameOver;
PFont playAgain;
PFont score;

void setup()
{
  size(500, 500);
  setUpPlayerControllers();
  setUpEnemies();
  setUpStars();
  enemy = loadImage("enemy.png");
  star1 = loadImage("star1.png");
  star2 = loadImage("star2.png");
  startscreen = loadImage("start.png");
  gameOver = loadFont("ARDELANEY-48.vlw");
  playAgain = loadFont("Andalus-30.vlw");
  score = loadFont("ARJULIAN-15.vlw");
}

void draw()
{
  if (splashScreens == 0)
  {
    startScreen();
  }
  else if (splashScreens == 2)
  {
    endScreen();
  }
  else
  {
    background(0);
    for(Player player:players)
    {
      player.update();
      player.display();
    }
    for(Enemy enemy:enemies)
    {
      enemy.update();
      if (enemy.alive == true)
      {
        enemy.display();
      }
    }
    for(Star star:stars)
    {
      star.update();
      if (star.alive == true)
      {
        star.display();
      }
    }
    for(int i = 0; i < bullets.size(); i++)
    {
      bullets.get(i).update();
      bullets.get(i).display();
      if (bullets.get(i).alive == false)
      {
        bullets.remove(i);
      }
    }
    bulletCollision();
    playerCollision();
  }
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

boolean checkKey(char theKey)
{
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName)
{
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value))
  {
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value))
  {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value))
  {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value))
  {
    return DOWN;
  }
  return value.charAt(0);  
}

void setUpPlayerControllers()
{
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  
  for(int i = 0 ; i < children.length ; i ++)  
  {
    XML playerXML = children[i];
    Player p = new Player(
            i
            , color(random(0, 255), random(0, 255), random(0, 255))
            , playerXML);
    int x = (i + 1) * gap;
    p.position.x = x;
    p.position.y = 300;
    players.add(p);         
  }
}

void startScreen()
{
  image(startscreen, 0, 0);
  if (keyPressed == true && key == '\n')
  {
    splashScreens = 1;
  }
}

void endScreen()
{
  background(0);
  textFont(gameOver, 70);
  fill(255, 48, 141);
  text("GAME OVER", 50, 150);
  textFont(playAgain, 40);
  fill(241, 85, 0);
  if (loser == 1)
  {
    text("PLAYER ONE WINS", 90, 240);
  }
  else if (loser == 0)
  {
    text("PLAYER TWO WINS", 90, 240);
  }
  textFont(playAgain, 25);
  fill(255);
  text("FINAL SCORES:", 180, 270);
  text("player one: " + players.get(0).score, 180, 290);
  text("player two: " + players.get(1).score, 180, 310);
  if (keyPressed == true && key == '\n')
  {
    splashScreens = 0;
  }
}

void setUpEnemies()
{
  for(int i = 0; i < numOfEnemies; i++)
  {
    Enemy e = new Enemy(enemySize, color(150));
    int x = (int) random(0, (screenWidth/enemySize));
    x = x * enemySize;
    e.location.x = x;
    int y = (int) random((-screenHeight/enemySize), 0);
    y = y * enemySize;
    e.location.y = y;
    enemies.add(e);
  }
}

void setUpStars()
{
  for(int i = 0; i < numOfStars; i++)
  {
    println("star");
    Star s = new Star(starSize, color(200));
    int x = (int) random(0, (screenWidth/starSize));
    x = x * starSize;
    s.location.x = x;
    int y = (int) random((-screenHeight/starSize), 0);
    y = y * starSize;
    s.location.y = y;
    stars.add(s);
  }
}

void bulletCollision()
{
  for(int i = 0; i < bullets.size(); i++)
  {
    for(int j = 0; j < enemies.size(); j++)
    {
      if(bullets.get(i).position.x >= enemies.get(j).location.x && bullets.get(i).position.x <= (enemies.get(j).location.x + enemySize))
      {
        if(bullets.get(i).position.y >= enemies.get(j).location.y && bullets.get(i).position.y <= (enemies.get(j).location.y + enemySize))
        {
          if(enemies.get(j).alive == true)
          {
             bullets.get(i).alive = false;
             enemies.get(j).health -= 1;
             if(enemies.get(j).health <= 0)
             {
               enemies.get(j).alive = false;
               int player = bullets.get(i).player;
               println(player);
               players.get(player).score += 1;
               if (players.get(player).score%10 == 0)
               {
                 players.get(player).health += 1;
               }
             }
          }
        }
      }
    }
  }           
}

void playerCollision()
{
  for(int i = 0; i < players.size(); i++)
  {
    for(int j = 0; j < enemies.size(); j++)
    {
      if((players.get(i).position.x + playerSize) >= enemies.get(j).location.x && (players.get(i).position.x - enemySize) <= enemies.get(j).location.x)
      {
        if(players.get(i).position.y + playerSize >= enemies.get(j).location.y && (players.get(i).position.y - enemySize) <= enemies.get(j).location.y)
        {
          if(enemies.get(j).alive == true)
          {
             enemies.get(j).alive = false;
             if(players.get(i).invincible == false)
             {
               players.get(i).health -= 1;
               players.get(i).healthBar[players.get(i).health] = 0;
               if(players.get(i).health <= 1)
               {
                 players.get(i).alive = false;
                 loser = i;
                 splashScreens = 2;
               }
             }
             else
             {
               players.get(i).score += 1;
               if (players.get(i).score%10 == 0)
               {
                 players.get(i).health += 1;
               }
             }
          }
        }
      }
    }
  }
  for(int i = 0; i < players.size(); i++)
  {
    for(int j = 0; j < stars.size(); j++)
    {
      if((players.get(i).position.x + playerSize) >= stars.get(j).location.x && (players.get(i).position.x - starSize) <= stars.get(j).location.x)
      {
        if(players.get(i).position.y + playerSize >= stars.get(j).location.y && (players.get(i).position.y - starSize) <= stars.get(j).location.y)
        {
          if(stars.get(j).alive == true)
          {
             stars.get(j).alive = false;
             players.get(i).invincible = true;
          }
        }
      }
    }
  }
}
