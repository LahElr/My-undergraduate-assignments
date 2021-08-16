#define pinI A2     //输入端口
#define delTim 500  //闪频

int num[4];
const uint8_t digitnum[10]={0x7E,0x30,0x6D,0x79,0x33,0x5B,0x5F,0x70,0x7F,0x7B};
const uint8_t numchc[7]={0x40,0x20,0x10,0x08,0x04,0x02,0x01};
const int pinOD[8]={2,3,4,5,6,7,8,9};
const int pinOC[4]={10,11,12,13};

void setup() 
{
  Serial.begin(9600);
  //初始化
  for(int i=0;i<8;i++)
  {
    pinMode(pinOD[i],OUTPUT);
    digitalWrite(pinOD[i],HIGH);
  }
  for(int i=0;i<4;i++)
  {
    pinMode(pinOC[i],OUTPUT);
    digitalWrite(pinOC[i],LOW);
  }
}

void loop() 
{
  //读取
  int volt=analogRead(pinI);
  volt=map(volt,0,1023,0,5000);
  getnum(volt);

  //各位数字 
  for(int i=0;i<4;i++)
  {
    //停止显示上一位并打开新一位
    if(i)
    {
      digitalWrite(pinOC[i-1],LOW);
      digitalWrite(pinOC[i],HIGH);
    }
    else
    {
      digitalWrite(pinOC[3],LOW);
      digitalWrite(pinOC[0],HIGH);
    }
    
    //小数点
    if(i==1)
    {
      digitalWrite(pinOD[7],HIGH);
    }
    
    //各段
    for(int k=0;k<7;k++)
    {
      
      if(k!=0)
      {
        digitalWrite(pinOD[k-1],HIGH);
      }
      else
      {
        digitalWrite(pinOD[6],HIGH);
      }

      if(numchc[k] & digitnum[num[i]])
      {
        digitalWrite(pinOD[k],LOW);
      }
      else
      {
        digitalWrite(pinOD[k],HIGH);
      }
      delayMicroseconds(delTim);
    }

    if(i==0)
    {
      digitalWrite(pinOD[7],LOW);
      delayMicroseconds(2*delTim);//直接使用delTim的话，小数点较暗，不易看清，故使用2倍。
    }
  }
}

void getnum(int in) //数字处理
{
  Serial.println(in);
  num[3]=in%10;
  num[2]=(in/10)%10;
  num[1]=(in/100)%10;
  num[0]=(in/1000)%10;
}