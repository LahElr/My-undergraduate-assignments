#include <SoftwareSerial.h>
SoftwareSerial mySerial(A0,A1);
void setup() {
  // put your setup code here, to run once:
  //mySerial.begin(9600);
 // mySerial.listen();
 Serial.begin(9600);
  
}

void loop() {
  // put your main code here, to run repeatedly:
  //mySerial.listen();
  while(Serial.available()){
    Serial.println(Serial.read());
  }
  
}
