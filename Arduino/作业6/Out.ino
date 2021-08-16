#include <MsTimer2.h>

const uint8_t digitnum[10]={0xFC,0x60,0xDA,0xF2,0x66,0xB6,0xBE,0xE0,0xFE,0xF6};       //段码
const uint8_t numchc[8]={0x80,0x40,0x20,0x10,0x08,0x04,0x02,0x01};                    //检查码

int nowDig=0; //段
int nowLit=0; //位
int pinOD[8]={2,3,4,5,6,7,8,9}; //分段引脚
int pinOC[4]={10,11,12,13};     //公共端引脚
uint8_t num[4]={0,0,0,0};       //存储四位的段码
short numC=0;

void setup() 
{
  //初始化串口
  Serial.begin(9600);、
  //初始化中断器
  MsTimer2::set(1,dosLed);
  MsTimer2::start();
  //初始化各引脚
  for(int i=0;i<8;i++)
  {
    pinMode(pinOD[i],OUTPUT);
    digitalWrite(pinOC[i],HIGH);
  }
  for(int i=0;i<4;i++)
  {
    pinMode(pinOC[i],OUTPUT);
    digitalWrite(pinOC[i],LOW);
  }
}

void loop() 
{
  if(millis()%25==0)
    getnum();
}

void dosLed()
{
  //灭掉上一个段
  digitalWrite(pinOD[nowDig],HIGH);
  //段的切换
  if(nowDig==7)
  {
    //切换到下一位数字
    digitalWrite(pinOC[nowLit],LOW);
    if(nowLit==3)
    {
      nowLit=0;
    }
    else
    {
      nowLit++;
    }
    digitalWrite(pinOC[nowLit],HIGH);
    nowDig=0;
  }
  else
  {
    nowDig++;
  }

  //点亮新的段
  if((num[nowLit] & numchc[nowDig])!=0)
  {
    digitalWrite(pinOD[nowDig],LOW);
  }
  else
  {
    digitalWrite(pinOD[nowDig],HIGH);
  }
}

//数字处理
void getnum() 
{
  //找到开始符后开始读
  while(Serial.available())
  {
    if(Serial.read()=='#')
    {
      break;
    }
  }
  while(Serial.available())
  {
    char in=Serial.read();
    if(47<in && in<58)
    {
      num[numC]=digitnum[in-48]; //转换为数字再转成段码存进去
      if(numC!=3)
      {
        numC++;
      }
      else
      {
        //归零，小数点，跳出。
        numC=0;
        num[0]++;
        return;
      }
    }
  }
}
