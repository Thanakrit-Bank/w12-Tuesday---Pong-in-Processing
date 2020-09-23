class PongPaddle {
  int score = 0;
  int x;
  int y = 240;
  int w = 30;
  int h = 240;
  
  PongPaddle(boolean left) {    
    if (left) {
      x = 5;
    } else {
      x = width - 35;
    }
  }
  
  // draw paddle
  void draw() {
    rect(x, y, w, h);
  }
  
  // switch player when ball bounce
  void bounce_ball() {
  }
}

class PongBall {
  float x = width/2;
  float y = height/2;
  float speedX = 5; 
  float speedY = random(-5,5);
  float diameter = 50;
  
  PongBall() {
  }
  
  // draw ball
  void draw() {
    ellipse(x,y,diameter,diameter);
  }
  
  // make the ball move
  void move() {
    y = y + speedY;
    x = x + speedX;
    
    // ball bounce top and bottom
    if (ball.bottom() > height || ball.top() < 0) {
      ball.speedY = -ball.speedY;
    }
  }
  
  // helper function
  float top() {
    return y-diameter/2;
  }
  float bottom() {
    return y+diameter/2;
  }
}

class PongGame {
  
  PongGame() {
  }
  
  // draw tabble
  void draw() {
    // line
    rect(490,0,20,720);
    
    textSize(70);
    // player1 score
    text(paddleLeft.score, 245, 70);
    // player2 score
    text(paddleRight.score, 755, 70);
  }
  
  // draw ball at center when ball out of table
  void serve_ball() {
    ball.x = width/2;
    ball.y = height/2;
    
    float angle = random(-PI/4, PI/4);
    ball.speedX = 5 * cos(angle);
    ball.speedY = 5 * sin(angle);
    
    if (random(1) < 0.5) {
      ball.speedY *= -1;
    }
  }
  
  // update player bounce and score
  void update() {
    if (ball.x - ball.diameter > width) {
      paddleLeft.score += 1;
      game.serve_ball();
    }
    
    if (ball.x + ball.diameter < 0) {
      paddleRight.score += 1;
      game.serve_ball();
    }
  }
  
  // move paddle
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

PongPaddle paddleLeft;
PongPaddle paddleRight;
PongBall ball;
PongGame game;
PongApp app;

void setup() {
  size(1000,720);
  paddleLeft = new PongPaddle(true);
  paddleRight = new PongPaddle(false);
  ball = new PongBall();
  game = new PongGame();
  app = new PongApp();
}

void draw() {
  background(0);
  
  paddleLeft.draw();
  paddleLeft.bounce_ball();
  paddleRight.draw();
  paddleRight.bounce_ball();
  
  game.draw();
  game.update();
  game.on_touch_move();
  
  ball.draw();
  ball.move();
}
