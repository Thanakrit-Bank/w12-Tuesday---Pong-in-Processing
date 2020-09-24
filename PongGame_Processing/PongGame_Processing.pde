class PongPaddle {
  int score = 0;
  int x;
  int y = 240;
  int w = 20;
  int h = 180;
  
  PongPaddle(boolean left) {    
    if (left) {
      x = 5;
    } else {
      x = width - 25;
    }
  }
  
  // draw paddle
  void draw() {
    rect(x, y, w, h);
  }
  
  // ball bounce on paddle
  void bounce_ball() {
    // check paddleLeft
    if (ball.y - ball.diameter < y + h && ball.y + ball.diameter > y - h/4 && ball.x - ball.diameter/2 < x + w/2) {
      if (ball.x > x) {
        //ball.speedX *= -1;
        float diff = ball.y - (y - h/2);
        float rad = radians(45);
        float angle = map(diff, 0, h, -rad, rad);
        ball.speedX = 10 * cos(angle);
        ball.speedY = 10 * sin(angle);
      }
    }
    
    // check paddleRight
    if (ball.y - ball.diameter < y + h && ball.y + ball.diameter > y - h/4 && ball.x + ball.diameter/2 > x + w/2) {
      if (ball.x < x) {
        //ball.speedX *= -1;
        float diff = ball.y - (y - h/2);
        float angle = map(diff, 0, h, radians(225), radians(135));
        ball.speedX = 10 * cos(angle);
        ball.speedY = 10 * sin(angle); 
      }
    }
  }
}

class PongBall {
  float x = width/2;
  float y = height/2;
  float speedX = random(-8,8); 
  float speedY = random(-4,4);
  float diameter = 50;
  
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
  }
  
  // update score when ball out of table and serve the ball
  void update() {
    if (ball.x - ball.diameter > width) {
      paddleLeft.score += 1;
      delay(600);
      game.serve_ball();
    }
    
    if (ball.x + ball.diameter < 0) {
      paddleRight.score += 1;
      delay(600);
      game.serve_ball();
    }
  }
  
  // move paddle
  void on_touch_move() {
    if (mousePressed == true) {
      if (mouseX < width/2) {
        paddleLeft.y = mouseY-120;
      }
      if (mouseX > width/2) {
        paddleRight.y = mouseY-120;
      }
    }
  }
}

class PongApp {
  boolean gameStart;
  
  // start game
  void build() {
    if (mousePressed) {
      gameStart = true;
    }
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
  app.build();
  
  if (app.gameStart) {
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
}
