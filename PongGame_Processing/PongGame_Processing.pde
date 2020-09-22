class PongPaddle {
  int score;
  int posX;
  
  PongPaddle(int tempX) {
    score = 0;
    posX = tempX;
  }
  
  // draw paddle
  void draw() {
    rect(posX,240,30,240);
  }
  
  // animate bounce ball
  void bounce_ball() {
  }
}

class PongBall {
  float x, y;
  float speedX, speedY;
  float diameter;
  
  PongBall(float tempX, float tempY, float tempDiameter) {
    x = tempX;
    y = tempY;
    speedX = 0;
    speedY = 0;
    diameter = tempDiameter;
  }
  
  // draw ball
  void draw() {
    ellipse(x,y,diameter,diameter);
  }
  
  // make the ball move
  void move() {
    y = y + speedY;
    x = x + speedX;
  }
}

class PongGame {
  String entry_text = "";
  
  PongGame() {
  }
  
  // draw tabble
  void draw() {
    // line
    rect(490,0,20,720);
    
    textSize(70);
    // player1 score
    text("0", 245, 70);
    // player2 score
    text("0", 755, 70);
  }
  
  // draw ball at center when ball out of table
  void serve_ball() {
  }
  
  // update player bounce and score
  void update() {
  }
  
  // move paddle?
  void on_touch_move() {
  }
}

class PongApp {
  
  PongApp() {
  }
  
  // start game?
  void build() {
  }
}

PongPaddle paddle1;
PongPaddle paddle2;
PongBall ball;
PongGame game;
PongApp app;

void setup() {
  size(1000,720);
  paddle1 = new PongPaddle(0);
  paddle2 = new PongPaddle(width-30);
  ball = new PongBall(width/2,height/2,50);
  game = new PongGame();
  app = new PongApp();
  
  ball.speedX = 5;
  ball.speedY = random(-3,3);
}

void draw() {
  background(0);
  
  paddle1.draw();
  paddle2.draw();
  
  game.draw();
  
  ball.draw();
  ball.move();
}
