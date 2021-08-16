void setup ()
{
  Serial.begin(9600);
}

void loop ()
{
  int volt=analogRead(A2);
  Serial.println(volt);
}
