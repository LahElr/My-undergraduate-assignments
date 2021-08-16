
const int pinI=A0;
const int pinO=3;
int volt=0;

void setup()
{
    Serial.begin(9600);
    pinMode(pinO,OUTPUT);
}

void loop()
{
    volt=analogRead(pinI);
    analogWrite(pinO,map(volt,0,1024,0,255));
    Serial.println(map(volt,0,1024,0,5000));
}
