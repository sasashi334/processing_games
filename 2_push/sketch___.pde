PFont font;
PImage hand, hako, dami, hakosita, damisita;

int x, y, vx;
//シーン切り替わり
String scene="title";

int count=0;
void setup() {
  frameRate(60);
  size(1080, 720);

  //日本語化
  font=loadFont("jp.vlw");
  textFont(font);

  textAlign(CENTER, TOP);

  hand = loadImage("hand.png");
  hako=loadImage("hako.png");
  dami=loadImage("dami.png");
  hakosita=loadImage("hakosita.png");
  damisita=loadImage("damisita.png");
}

void draw() {

  background(255);
  if (scene == "title") {
    title();
  } else if (scene == "stage1") {
    stage1();
  } else if (scene == "clear1") {
    clear1();
  } else if (scene=="miss1") {
    miss1();
  } else if (scene=="stage2") {
    stage2();
  }

  mousePressed=false;
}

void title() {
  //タイトル
  textSize(200);
  fill(0, 0, 0);
  text("押し  子", width/2, height/4);
  fill(255, 20, 147);
  text("の", 90+width/2, height/4);
  fill(1);

  textSize(50);
  text("画面をクリックしてね", width/2, 3*height/4);

  //クリック操作
  if (mousePressed) {
    scene="stage1";
  }
}
//ボール初期値
float ballx=0, bally=200, balldx=10, balldy=-8;

void stage1() {
  fill(0);
  //箱処理
  image(hako, 0, 546, 600, 200);

  //ボール描画
  ellipse(ballx, bally, 25, 25);

  //衝突処理
  for (int i=-130; i!=150; i++) {
    for (int t=0; t!=300; t++) {
      if (get(mouseX-27+t, mouseY-i)==color(0)&& count==0) {

        balldx=(mouseX-pmouseX-balldx)*0.8;
        balldy=mouseY-pmouseY;

        count++;
        break;
      }
    }
  }

  //for (int i=-130; i!=150; i++) {
  //for(int t=0;t!=80;t++){
  //point(mouseX-27+t, mouseY-i);}}

  //ボール速度パラメタ
  ballx+=balldx;
  balldy+=0.15;
  bally+=balldy;



  //手の処理
  image(hand, mouseX-80, mouseY-150, 200, 300);
  //箱処理
  if ( bally>660 && ballx>90 &&ballx<510) {
    scene="clear1";
  }

  if ( bally>1000) {
    scene="miss1";
  }
}

void clear1() {
  text("clear", width/2, height/2);
   ballx=0; 
   bally=200;
   balldx=10;
   balldy=-8;
   count=0;
  if (mousePressed) {
    scene="stage2";
  }
}

void miss1() {
  text("miss", width/2, height/2);
  ballx=0; 
   bally=200;
   balldx=10;
   balldy=-8;
   count=0;
  if (mousePressed) {
    scene="stage1";
  }
}

void stage2(){
  

  //箱の位置
  image(hako, noise(frameCount*0.05)*600, 546, 600, 200);
  
    ellipse(ballx, bally, 25, 25);
 
  
  //line(0,660,1000,660);
  //line(noise(frameCount*0.01)*700+90,0,noise(frameCount*0.01)*700+90,1000);
  //line(noise(frameCount*0.01)*700+510,0,noise(frameCount*0.01)*700+510,1000);
  //衝突判定
  for (int i=-130; i!=150; i++) {
    for (int t=0; t!=300; t++) {
      if (get(mouseX-27+t, mouseY-i)==color(0)&& count==0) {

        balldx=(mouseX-pmouseX-balldx)*0.8;
        balldy=mouseY-pmouseY;

        count++;
        break;
      }
  
}}
    //ボール速度パラメタ
  ballx+=balldx;
  balldy+=0.15;
  bally+=balldy;
  
  //for (int i=-130; i!=150; i++) {
  //for(int t=0;t!=80;t++){
  //point(mouseX-27+t, mouseY-i);}}
  
    //手の処理
  image(hand, mouseX-80, mouseY-150, 200, 300);
  
if(bally>660 && ballx>noise(frameCount*0.01)*600+90 &&ballx<noise(frameCount*0.01)*600+510){
  scene="clear1";
}
if(bally>1000){
  scene="miss1";
}
}
