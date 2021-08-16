boolean trig=true;
boolean echo=false;
unsigned long tim1,tim2;
unsigned long pul=0;

void setup()
{
  
  pinMode(12,INPUT);
  pinMode(11,OUTPUT);
 
  for(int i=2;i<10;i++)
  {
    pinMode(i,OUTPUT);
    digitalWrite(i,LOW);
  }

  Serial.begin(9600);
}


void loop() 
{
  tim1=millis();
  int reading=digitalRead(12);
  int m=tim1%100;
  
  //触发脉冲
  if(m<1 && trig)
  {
    digitalWrite(11,HIGH);
    trig=false;
    tim2=micros();
  }
  else if((micros()-tim2>10)&&(!trig))
  {
    digitalWrite(11,LOW);
    trig=true;
  }//回传信号
  else if(!echo && reading==HIGH)
  {
    echo=true;
    tim2=micros();
  }
  else if(echo && reading==LOW)
  {
    echo=false;
    pul=micros()-tim2;
    //Serial.println(pul);
    Serial.println(caldis(pul));
    light(pul);
  }
  
}

void light(unsigned long in)
{
  //清空
  for(int i=2;i<10;i++)
  {
    digitalWrite(i,HIGH);
  }
  //从桌至对面空间的最大距离对应回传时间约为12000
  if(in>12000)
    in=10;
  else
    in=map(in,0,12000,2,9)+1;
  
  //Serial.println(in);
  //亮灯
  int i=2;
  while(i<in)
  {
    digitalWrite(i,LOW);
    i++;
  }
}

int caldis(unsigned int in)
{
  in=in*340/1000;//单位是mm
  return in;
}