PFont font, myFont;
String scene="title";

void setup() {
  //画面
  size(1920, 1080);
  frameRate(120);
  //日本語化
  font=loadFont("jp.vlw");
  textFont(font);
  textAlign(CENTER, TOP);
  //String[] fontList = PFont.list();
  //println(fontList);
  //myFont = createFont("メイリオ", 24);
  //textFont(myFont);
}
float x=100, y=100, dx=4, dy=8;
int a=0, col=0, b=0;


void draw() {
  background(255);

  if (scene=="title") {
    title();
  }
  if (scene=="game") {
    game_screen();
  }
  if (scene=="gameover") {
    result();
  }
  mousePressed=false;
}


void title() {

  fill(0);
  textSize(100);
  if (mouseX>width/2-350 & mouseX<width/2+350 && mouseY<3*height/4+100 && mouseY>3*height/4) {
    textSize(150);
    if (mousePressed) {
      scene="game";
    }
  }
  
  text("ゲームスタート", width/2, 3*height/4);
  fill(0,95,153);
  textSize(150);
  text("ぐるぐるぱんち",width/2,height/4);
  
}


void game_screen() {
  fill(0);
  text("score:"+a, width/2, height/10);
  fill(255);
  rectMode(CORNER);

  if (y>=1055||y<=25) {
    dy=-dy*1.01;
    dx=dx*1.01;
  }

  if (x<=25) {
    dx=-dx*1.05;
    col=0;
  }

  x+=dx;
  y+=dy;


  ellipse(x, y, 50, 50);






  translate(mouseX, mouseY); //座標変換

  float rad=frameCount*PI/80;

  rotate(rad); // 座標軸を回転
  stroke(128);
  line(0, 0, 170, 0);

  stroke(0);
  strokeWeight(5);
  ellipse(200, 0, 60, 60);

  fill(0);
  float X=(x-mouseX)*cos(rad)+(y-mouseY)*sin(rad), Y=(-x+mouseX)*sin(rad)+(y-mouseY)*cos(rad);

  if (dist(X, Y, 200, 0)<=55 && col==0) {
    a+=abs(dx*10);
    dx=-dx*1.1;
    col=1;
  }

  if (x>2000) {
    b=a;
    scene="gameover";
  }
}

String[] score={"0", "0", "0"};

void result() {

  fill(0);
  textSize(200);
  text("スコア:"+b, width/2, height/4-100);
  textSize(100);
  if (b<=0) {
    fill(0, 255, 255);
    text("え？", width/2, height/2);
  } else if (b<150) {
    fill(128, 0, 128);
    text("下手。", width/2, height/2);
  } else if (b<300) {
    fill(150, 255, 150);
    text("普通。", width/2, height/2);
  } else if (b<500) {
    fill(0, 102, 204);
    text("やるやん", width/2, height/2);
  } else {
    fill(255, 255, 0);
    textSize(300);
    text("ﾈ申", width/2, height/2-70);
  }
  textSize(100);
  fill(0);


  //スコア処理
  String[] data = loadStrings("score.txt");

  for (int i=0; i!=3; i++) {
    score[i]=data[i];

    if (a>=int(data[i])) {
      score[i] = str(a);
      a = int(data[i]);
    } else {
      score[i]=data[i];
    }
  }

  for (int t=0; t!=3; t++) {
    fill(t*100,(3-t)*100,t*100);
    text("No."+(t+1)+":"+score[t], (width/4)-200, (t*height/4)+400);
  }

  saveStrings("score.txt", score);




  if (mouseX>width/2-200 & mouseX<width/2+200 && mouseY<3*height/4+100 && mouseY>3*height/4) {
    textSize(150);
    if (mousePressed) {
      x=100;
      y=100;
      dx=4;
      dy=8;
      a=0;
      col=0;
      scene="game";
    }
  }
fill(0);
  text("やりなおし", width/2, 3*height/4);
}
