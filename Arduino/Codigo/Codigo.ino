#include <Adafruit_Sensor.h>

#include <DHT.h>
#include <DHT_U.h>


// inclusão da bliblioteca do sensor DHT11
#include <DHT.h>

// Definição dos pinos para entrada de dados 
#define DHTPIN,A1;
#define LM35PIN,A0;

// inicialização Do monitor serial, das entradas(pins)
void setup()
{

    //Definindo que os pinos serão de entrada de Dados
    pinMode(DHTPIN, INPUT);
    pinMode(LM35PIN, INPUT);

    //Iniciando o Monitor Serial e a Biblioteca do DHT11
    Serial.begin(9600);
    dht.begin();

}

// codigo que irá ser repetido infinitamente (enquanto houver energia na placa do Arduino)
void loop()
{

    // Definição das Variaveis
    float umidade_dht11 = dht.readHumidity();
    float temperatura_dht11 = dht.readTemperature();
    float temperatura_lm35 = analogRead(LM35PIN);

    //Transformando o dado do LM35 em um numero inteiro
    temperatura_lm35 = (temperatura_lm35 * 0.00488) * 100;

    //Calculo da Media cas Duas Temperaturas para melhor Precisão
    float Media_Temp = (temperatura_lm35 + temperatura_dht11) / 2;

    // Verificação do funcionamento dos sensores
    if(isnan (umidade_dht11) or isnan (Media_Temp))
    {

        // mensagem de erro caso não consiga captar qualquer informação
        Serial.println("Erro ao captar os dados");
        
    }
    else
    {

        // Os dados que serão apresentados no monitor serial e futuramente no banco de dados
        Serial.print(umidade_dht11);
        Serial.print(";");
        Serial.print(Media_Temp);
        Serial.println(";");

    }
  
}

// FIM DO CODIGO
