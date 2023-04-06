
function calcular() {
            
var nome = input_nome.value
var perda = Number(input_perda.value)    
var vida_util = Number(input_vida_util.value)

var vida_util_aumentada = 90
var perda_reduzida = perda*0.95
    span_mensagem.innerHTML = `${nome}, com nosso monitoramento suas perdas serão reduzidas em <b>${perda_reduzida}</b> unidades e a vida útil será mantida em torno de ${vida_util_aumentada}% nos containers que haviam problemas com monitoramento de temperatura e umidade.`
}