import processing.serial.*;
Serial myPort;

int x; 
int i1,i2;
int ReceiveData[] = new int[512];
int OtherData[] = new int[32];
char flgStart = 0;

void setup() {
  size(768, 768);
  myPort = new Serial(this, "COM24", 57600);
  println("Dsky LineScanMonitor");
}

void draw() {
  background(255);
  stroke(255,0,0);
    line(256,256-OtherData[1],512,256-OtherData[1]);
    line(256-OtherData[1],256,256-OtherData[1],512);
    line(256,512+OtherData[1],512,512+OtherData[1]);
    line(512+OtherData[1],512,512+OtherData[1],256);
    
    fill(240,200,200);
    rect(256,256,OtherData[2]*2,-256);
    rect(256,256,-256,OtherData[3]*2);
    rect(512,512,-OtherData[2]*2,256);
    rect(512,512,256,-OtherData[3]*2);
    
    rect(256,512,OtherData[2]*2,256);
    rect(256,512,-256,-OtherData[3]*2);
    rect(512,256,-OtherData[2]*2,-256);
    rect(512,256,256,OtherData[3]*2);
    
    //Line
    stroke(0);
for(i2=0; i2<128; i2++){
  line(512-i2*2,0+512,512-i2*2,ReceiveData[i2]+512);  

}
for(i2=128; i2<256; i2++){
  line(i2*2,0+256,i2*2,256-ReceiveData[i2]);
}
for(i2=256; i2<384; i2++){
  line(256,i2*2-256,-ReceiveData[i2]+256,i2*2-256);
}
for(i2=384; i2<512; i2++){
  line(512,i2*2-512,512+ReceiveData[i2],i2*2-512);
}
fill(0);
textSize(20);
text("Dsky  LineScanSensor",10,20);
int s = 22;
text("LoopTime : ",30,60);
text(OtherData[0],140,60);
text("Thureshold : ",30,80);
text(OtherData[1],160,80);

text("LinePos1 : ",30,100);
text(OtherData[4],160,100);

text("LinePos2 : ",30,120);
text(OtherData[5],160,120);

text("LinePos3 : ",30,140);
text(OtherData[6],160,140);

text("LinePos4 : ",30,160);
text(OtherData[7],160,160);

text("Data0 : ",30,180);
text(OtherData[8],160,180);

text("Data1 : ",30,200);
text(OtherData[9],160,200);

text("Data2 : ",30,220);
text(OtherData[10],160,220);

text("Data3 : ",30,240);
text(OtherData[11],160,240);

stroke(0,255,0);
strokeWeight(5);
if(OtherData[4]!=21 && OtherData[5]!=21){
line(512-OtherData[4]*2,512,256+OtherData[5]*2,256);
}
if(OtherData[7]!=21 && OtherData[6]!=21){
line(256,256+OtherData[6]*2,512,256+OtherData[7]*2);
}

strokeWeight(1);

}

void serialEvent(Serial p) {
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
      flgStart = 3;
    }
    break;
  case 3:
    OtherData[i1] = p.read();
    i1++;
        if (i1==32) {
      i1=0;
      flgStart = 0;
    }  
    break;
    
  }
}

