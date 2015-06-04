// シリアルライブラリを取り入れる
import processing.serial.*;

// myPort（任意名）というインスタンスを用意
Serial myPort;

int x; //図形のX座標の変数を用意
int i1,i2;
int ReceiveData[] = new int[512];
char flgStart = 0;

void setup() {
  // 画面サイズ
  size(768, 768);
  // シリアルポートの設定
  // "/dev/tty.usbmodem1411" の部分を前述の「シリアルポートを選択する」で選択したシリアルポートにあわせて書き換える
  myPort = new Serial(this, "COM24", 9600);
}

void draw() {
  // 背景色を白に設定
  background(255);

for(i2=0; i2<128; i2++){
  line(i2*2+256,0+256,i2*2+256,256-ReceiveData[i2]);
}
for(i2=128; i2<256; i2++){
  line(i2*2,0+512,i2*2,ReceiveData[i2]+512);
}
for(i2=256; i2<384; i2++){
  line(256,i2*2-256,-ReceiveData[i2]+256,i2*2-256);
}
for(i2=384; i2<512; i2++){
  line(512,i2*2-512,512+ReceiveData[i2],i2*2-512);
}
}

void serialEvent(Serial p) {
//  x = p.read();

  switch(flgStart) {
  case 0:
    if (p.read()=='s') {  
      flgStart = 1;
    }
    break;

  case 1:
    if (p.read()=='t') {  
      flgStart = 2;
    }
    break;

  case 2:
    ReceiveData[i1] = p.read();
    i1++;
    if (i1==512) {
      i1=0;
      flgStart = 0;
    }

    break;
  }

  println(x);
}

