
const int a=12;
const int b=8;
unsigned long at,bt,atemp;
boolean ati,atei,bi;
int boolTurn(boolean in);

void setup() 
{
  pinMode(a, OUTPUT);
  pinMode(b,OUTPUT);
  at=millis();
  bt=millis();
  ati=true;
  atei=true;
  bi=false;
}

void loop() 
{
  //The action of LED a : at-on->atemp-off->at...
  if(ati && millis()-at>=125)
  {
    atemp=millis();
    ati=false;
    atei=true;
    digitalWrite(a,HIGH);
  }
  if(atei && millis()-atemp>=200)
  {
    at=millis();
    atei=false;
    ati=true;
    digitalWrite(a,LOW);
  }

  //The action of LED b : bt-on->bt-off->bt...
  if(millis()-bt>=250)
  {
    bt=millis();
    bi=!bi;
    digitalWrite(b,boolTurn(bi));
  }

  //For the condition of the unisgned long overflow
  if(bt>millis()||at>millis()||atemp>millis())
  {
    at=millis();
    bt=millis();
    bi=false;
  }


}

int boolTurn(boolean in)
{
  if(in)  return HIGH;
  else return LOW;
}
