
function calcular() {
            
    var nome_empresa = input_empresa.value //Variavel armazena nome da empresa
    var nome_produto = input_produto.value  //Variavel armazena nome do produto
    var preço_produto = Number(input_preço.value)   //Variavel armazena e transforma em número, o preço do produto
    var qtd_produto = Number(input_qtd_produto.value)   //Variavel armazena e transforma em número, a quantidade do produto
    var prejuízo_produto = Number(input_perda.value)    //Variavel armazena e transforma em número, a quantidade perdida do produto (não envolve valor financeiro) 

    var preçototal = preço_produto * qtd_produto   //Variavel armazena em valor financeiro o montante antes das perdas 
    var prejúizoTotal = preço_produto * input_perda // Variavel armazena em valor financeiro montante perdido
    var porcentagem_prejúizo = (prejuízo_produto * 100) / qtd_produto //Variavel armazena em porcentagem montante perdido em prejúizo
    var prejuízo_financeiro = prejuízo_produto * preço_produto // Variavel responsavel por calcular o prejuízo em valor financeiro


    span_mensagem.innerHTML = `
        <b>${nome_empresa}</b>, você é responsalvél por transportar <b>${qtd_produto}</b> ${nome_produto} por mês<br>
        Cada um deles custando <b>R$${preço_produto}</b>, mensalmente isso deveria totalizar <b>R$${preçototal}</b>.<br> Entretanto <b>${porcentagem_prejúizo}%</b>
        deles são perdidos por mês, totalizando um prejuizo de <b>R$${prejuízo_financeiro}</b><br> os maiores responsaveis por isso são a temperatura e a umidade. 
    `
    
}