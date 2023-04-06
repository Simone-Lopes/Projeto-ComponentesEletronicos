
function calcular() {
            
var nome = input_nome.value
var perda = Number(input_perda.value)    
var vida_util = Number(input_vida_util.value)
var preco = Number(input_preco_produto.value)

var vida_util_aumentada = 90
var perda_reduzida = perda*0.95
var valor_salvo = perda_reduzida*preco
    span_mensagem.innerHTML = `${nome}, com nosso monitoramento suas perdas serão reduzidas em <b>${perda_reduzida}</b> unidades e a vida útil será mantida em torno de ${vida_util_aumentada}% nos containers que haviam problemas com monitoramento de temperatura e umidade.
    Salvando até <b>R$${valor_salvo}!</b>`
}