PFont font;
Tanni[]  hisshu = new Tanni[2], sentaku = new Tanni[2]; //オブジェクト宣言
Tanni soturon,kakomon;

void setup() {
  //画面
  size(1800, 1200);
  frameRate(60);
  background(255);
  //日本語化
  font=loadFont("jp.vlw");
  textFont(font);
  textAlign(CENTER, TOP);

  hisshu[0]= new Tanni(150, random(-5, 5), 0, 0, 0.1, "必修", 255, 0, 0);
  hisshu[1]= new Tanni(600, random(-6, 5), 0, 1, 0.001, "必修", 255, 0, 0);
  sentaku[0]= new Tanni(1200, random(-3, 0), 0, -1, 0.01, "選択", 0, 255, 255);
  sentaku[1]= new Tanni(1200, random(1, 5), 0, random(5, 10), 3, "選択", 0, 255, 255);
  soturon=new Tanni(1600, -10, -200, 5, 3, "卒論", 0, 0, 0);
  kakomon= new Tanni(160,10,-200,random(5,10),1,"過去問",125,125,125);
}
int over=0,scene=0, count=0;
float gpa=0;

void draw() {
  if(over==1){
    game_over();}
  else if (count==1 && scene!=5) {
    wait_screen();
  } else if (scene == 0) {
    start_screen();
  } else if (scene==1) {

    game_screen1();
  } else if (scene ==2) {

    game_screen2();
  } else if (scene ==3) {

    game_screen3();
  } else if (scene ==4) {

    game_screen4();
  } else if (scene==5) {
    sotugyou();
  } 
  
  mousePressed=false;
}

void start_screen() {
  background(255);
  fill(0);
  textSize(300);
  text("単位ゲーム", width/2, height/4);
  textSize(100);
  text("画面をクリックしてください", width/2, 3*height/4);
  if (mousePressed) {
    scene++;
  }
}




//クラスの定義
class Tanni {
  float x, dx, y, dy, G;
  int r, g, b;
  String tanni;

  //コンストラクターの定義
  Tanni(float x, float dx, float y, float dy, float G, String tanni, int r, int g, int b) {
    this.x=x;
    this.dx=dx;
    this.y=y;
    this.dy=dy;
    this.G=G;
    this.tanni=tanni;
    this.r=r;
    this.g=g;
    this.b=b;
  }

  void drop() {
    textSize(128);
    fill(r, g, b);
    x+=dx;
    dy+=G;
    y+=dy;
    text(tanni, x, y);
    if (y<=0) {
      dy=-dy*0.9;
    }
    if (x>1680) {
      dx=-dx;
    }
    if (x<120) {
      dx=-dx;
    }
if(rectX==200){
    if (rectx-x<=200 && rectx-x>=-200 && recty-y>=0 && recty-y<=150) {
      if (tanni=="過去問"){
        rectX=800;
        y=-1000;
         dy=0;
        G=0;}else{
      dy=-1.1*dy;
      dx=random(-15, 15);
      if (tanni=="選択") {
        gpa+=1.0;
      } else if (tanni=="必修") {
        gpa+=0.5;
      } else if (tanni=="卒論") {
        gpa+=4.0;
      }
    }}}
    else if(rectX==800){
     if(rectx-x<=500 && rectx-x>=-500 && recty-y>=0 && recty-y<=150){
       dy=-1.1*dy;
      dx=random(-15, 15);
      if (tanni=="選択") {
        gpa+=2.0;
      } else if (tanni=="必修") {
        gpa+=1.0;
      } else if (tanni=="卒論") {
        gpa+=4.0;
      }
    }}
      
      
      
    if (y>1200 && tanni=="必修") {
      over=1;
      gpa=0;
    } else if (y>1200 && tanni=="卒論") {
      over=1;
      gpa=0;
    }
  }
}

void control() {
  rectMode(CENTER);

  //操作
  if (keyPressed) {
    if (rectx>=0) {
      if (keyCode==LEFT) {
        rectx-=50;
      }
    }
    if (rectx<=1800) {
      if (keyCode==RIGHT) {
        rectx+=50;
      }
    }
  }

  rect(rectx, recty, rectX, 50);
  if (gpa>=4) {
    count=1;
    scene++;
    gpa=0;
  }
}


int rectx=900, recty=800;
int rectX=200;

void game_screen1() {
  background(255);
  textSize(30);
  fill(0);
  text("現在gpa:"+nf(gpa, 1, 1), 100, 50);
  kakomon.drop();
  hisshu[0].drop();
  sentaku[0].drop();
  control();
}

void game_screen2() {
  background(255);
  textSize(30);
  fill(0);
  text("現在gpa:"+nf(gpa, 1, 1), 100, 50);
  hisshu[0].drop();
  sentaku[0].drop();
  sentaku[1].drop();
  kakomon.drop();
  control();
}

void game_screen3() {
  background(255);
  textSize(30);
  fill(0);
  text("現在gpa:"+nf(gpa, 1, 1), 100, 50);
  hisshu[0].drop();
  hisshu[1].drop();
  sentaku[1].drop();
  control();
}

void game_screen4() {
  background(255);
  textSize(30);
  fill(0);
  text("現在gpa:"+nf(gpa, 1, 1), 100, 50);
  hisshu[0].drop();
  soturon.drop();
  control();
}

void wait_screen() {
  background(255);
  rectx=900;
  recty=800;
  rectX=200;
  fill(255, 255, 0);
  textSize(300);
  text(scene+"年に進級!", width/2, height/4);
  textSize(100);
  fill(0);
  text("クリックしてください", width/2, 3*height/4);
  for (int i=0; i<2; i++) {
    hisshu[i].x=600;
    hisshu[i].y=0;
    hisshu[i].dy=0;
    sentaku[i].x=1200;
    sentaku[i].y=0;
    sentaku[i].dy=0;
  }
  kakomon.x=160;
  kakomon.dx=10;
  kakomon.y=-200;
  kakomon.dy=random(5,10);
  kakomon.G=1;
  if (mousePressed) {
    count=0;
  }
}



void game_over() {
  background(0);
  textSize(300);
  fill(#FF0000);
  text("留年", width/2, height/4);
  textSize(100);
  text("画面をクリックしてやり直し", width/2, 3*height/4);
  for (int i=0; i<2; i++) {
    hisshu[i].x=600;
    hisshu[i].y=0;
    hisshu[i].dy=0;
    sentaku[i].x=1200;
    sentaku[i].y=0;
    sentaku[i].dy=0;
  }
  rectx=900;
  recty=800;
  rectX=200;
  kakomon.x=160;
  kakomon.dx=10;
  kakomon.y=-200;
  kakomon.dy=random(5,10);
  kakomon.G=1;
  soturon.x=1600;
  soturon.dx=-10;
  soturon.y=-200;
  soturon.dy=5;
  if (mousePressed) {
    over=0;
  }
}

void sotugyou() {
  background(255);
  fill(255, 220, 236);
  textSize(600);
  text("卒業", width/2, height/4);
}
