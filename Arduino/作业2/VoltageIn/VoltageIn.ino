const int pinI=A0;
int volt=0;

void setup()
{
    Serial.begin(9600);
}

void loop()
{
    volt=map(analogRead(pinI),0,1023,0,5000);
    Serial.println(volt);
}
