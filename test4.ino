#include <SoftwareSerial.h>
SoftwareSerial hc06(2, 3); 

const int FSR_PIN = A0; // FSR/저항 분배기에 연결된 핀
const float VCC = 4.98; // 아두이노 5V 선에서 측정된 전압
const float R_DIV = 10000.0; // 10k 저항의 측정 저항값

void setup() {
  // 시리얼 통신 시작
  Serial.begin(9600);

  // 블루투스 시리얼 포트 시작
  hc06.begin(9600);

  pinMode(FSR_PIN, INPUT);

}

void loop() {
  
  // FSR 읽기
  int fsrADC = analogRead(FSR_PIN);

  if (fsrADC != 0) { // 아날로그 읽기가 0이 아닐 경우
    // ADC 읽기를 사용하여 전압 계산:
    float fsrV = fsrADC * VCC / 1023.0;

    // 전압과 고정 저항 값을 사용하여 FSR 저항 계산:
    float fsrR = R_DIV * (VCC / fsrV - 1.0);

    // FSR 데이터시트의 기울기를 바탕으로 힘 추정:
    float force;
    float fsrG = 1.0 / fsrR; // 전도도 계산

    // 포물선 곡선을 두 개의 선형 기울기로 나누기:
    if (fsrR <= 600) 
      force = (fsrG - 0.00075) / 0.00000032639;
    else
      force = fsrG / 0.000000642857;

    // Serial.print("저항: " + String(fsrR) + " ohm \t"); 
    Serial.println(String(force));
    hc06.println("측정 무게: " + String(force) + " g");
    // 데이터를 시리얼 통신으로 전송

    delay(100); // 0.1초
  }
  else {
    // 압력이 감지되지 않음
  }
}
