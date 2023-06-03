
var alertas_Umi = [];
var alertas_Temp = [];

function obterdados_Umi(idLocal) {
    fetch(`/medidas/tempo-real_Umi/${idLocal}`)
        .then(resposta => {
            if (resposta.ok) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    alertar_Umi(resposta, idLocal);
                });
            } else {

                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do aquario p/ gráfico: ${error.message}`);
        });

}

function obterdados_Temp(idLocal) {
    fetch(`/medidas/tempo-real_Temp/${idLocal}`)
        .then(resposta => {
            if (resposta.ok) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    alertar_Temp(resposta, idLocal);
                });
            } else {

                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do aquario p/ gráfico: ${error.message}`);
        });

}

function alertar_Umi(resposta, idLocal) {

    // var temp = resposta[0].temperatura;
    var umi = resposta[0].umidade;

    console.log(idLocal === resposta[0].idLocal)
    
    var grauDeAviso ='';

    var limites_Umi = {
        muito_Umido: 75,
        Umido: 60,
        ideal: 45,
        seco: 30,
        muito_seco: 25
    };

    // var limites_temp = {
    //     muito_quente: 75,
    //     quente: 60,
    //     ideal: 45,
    //     frio: 30,
    //     muito_frio: 25
    // };

    var classe = 'cor-alerta';

    if (umi >= limites_Umi.muito_Umido) {
        classe = 'cor-alerta perigo-quente';
        grauDeAviso = 'perigo Umido'
        grauDeAvisoCor = 'cor-alerta perigo-quente'
        exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
    }
    else if (umi < limites_Umi.muito_Umido && umi >= limites_Umi.Umido) {
        classe = 'cor-alerta alerta-quente';
        grauDeAviso = 'alerta Umido'
        grauDeAvisoCor = 'cor-alerta alerta-quente'
        exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
    }
    else if (umi < limites_Umi.Umido && umi > limites_Umi.seco) {
        classe = 'cor-alerta ideal';
        removerAlerta_Umi(idLocal);
    }
    else if (umi <= limites_Umi.seco && umi > limites_Umi.muito_seco) {
        classe = 'cor-alerta alerta-frio';
        grauDeAviso = 'alerta Seco'
        grauDeAvisoCor = 'cor-alerta alerta-frio'
        exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
    }
    else if (umi <= limites_Umi.muito_seco) {
        classe = 'cor-alerta perigo-frio';
        grauDeAviso = 'perigo Seco'
        grauDeAvisoCor = 'cor-alerta perigo-frio'
        exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
    }

    var umi_local = document.getElementById(`Umi_local_${idLocal}`);
    var card_umi = document.getElementById(`card_umi_${idLocal}`);

    // var temp_local = document.getElementById(`temp_local_${idLocal}`);
    // var card_temp = document.getElementById(`card_temp_${idLocal}`);

    umi_local.innerHTML = umi + "%";
    // temp_local.innerHTML = temp + "C°";
    card_umi.className = classe;
    // card_temp.className = classe;

    }

    function alertar_Temp(resposta, idLocal) {

        var temp = resposta[0].temperatura;
        // var umi = resposta[0].umidade;
    
        console.log(idLocal === resposta[0].idLocal)
        
        var grauDeAviso ='';
    
        // var limites_Umi = {
        //     muito_Umido: 75,
        //     Umido: 60,
        //     ideal: 45,
        //     seco: 30,
        //     muito_seco: 25
        // };
    
        var limites_temp = {
            muito_quente: 75,
            quente: 60,
            ideal: 45,
            frio: 30,
            muito_frio: 25
        };
    
        var classe = 'cor-alerta';
    
        // if (umi >= limites_Umi.muito_Umido) {
        //     classe = 'cor-alerta perigo-quente';
        //     grauDeAviso = 'perigo Umido'
        //     grauDeAvisoCor = 'cor-alerta perigo-quente'
        //     exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
        // }
        // else if (umi < limites_Umi.muito_Umido && umi >= limites_Umi.Umido) {
        //     classe = 'cor-alerta alerta-quente';
        //     grauDeAviso = 'alerta Umido'
        //     grauDeAvisoCor = 'cor-alerta alerta-quente'
        //     exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
        // }
        // else if (umi < limites_Umi.Umido && umi > limites_Umi.seco) {
        //     classe = 'cor-alerta ideal';
        //     removerAlerta(idLocal);
        // }
        // else if (umi <= limites_Umi.seco && umi > limites_Umi.muito_seco) {
        //     classe = 'cor-alerta alerta-frio';
        //     grauDeAviso = 'alerta Seco'
        //     grauDeAvisoCor = 'cor-alerta alerta-frio'
        //     exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
        // }
        // else if (umi <= limites_Umi.muito_seco) {
        //     classe = 'cor-alerta perigo-frio';
        //     grauDeAviso = 'perigo Seco'
        //     grauDeAvisoCor = 'cor-alerta perigo-frio'
        //     exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor)
        // }
    
        if (temp >= limites_temp.muito_quente) {
            classe = 'cor-alerta perigo-quente';
            grauDeAviso = 'perigo quente'
            grauDeAvisoCor = 'cor-alerta perigo-quente'
            exibirAlerta_Temp(temp, idLocal, grauDeAviso, grauDeAvisoCor)
        }
        else if (temp < limites_temp.muito_quente && temp >= limites_temp.quente) {
            classe = 'cor-alerta alerta-quente';
            grauDeAviso = 'alerta quente'
            grauDeAvisoCor = 'cor-alerta alerta-quente'
            exibirAlerta_Temp(temp, idLocal, grauDeAviso, grauDeAvisoCor)
        }
        else if (temp < limites_temp.quente && temp > limites_temp.frio) {
            classe = 'cor-alerta ideal';
            removerAlerta_Temp(idLocal);
        }
        else if (temp <= limites_temp.frio && temp > limites_temp.muito_frio) {
            classe = 'cor-alerta alerta-frio';
            grauDeAviso = 'alerta frio'
            grauDeAvisoCor = 'cor-alerta alerta-frio'
            exibirAlerta_Temp(temp, idLocal, grauDeAviso, grauDeAvisoCor)
        }
        else if (temp <= limites_temp.muito_frio) {
            classe = 'cor-alerta perigo-frio';
            grauDeAviso = 'perigo frio'
            grauDeAvisoCor = 'cor-alerta perigo-frio'
            exibirAlerta_Temp(temp, idLocal, grauDeAviso, grauDeAvisoCor)
        }
    
        // var umi_local = document.getElementById(`Umi_local_${idLocal}`);
        // var card_umi = document.getElementById(`card_umi_${idLocal}`);
    
        var temp_local = document.getElementById(`temp_local_${idLocal}`);
        var card_temp = document.getElementById(`card_temp_${idLocal}`);
    
        // umi_local.innerHTML = umi + "%";
        temp_local.innerHTML = temp + "C°";
        // card_umi.className = classe;
        card_temp.className = classe;
    
        }


function exibirAlerta_Umi(umi, idLocal, grauDeAviso, grauDeAvisoCor) {
    var indice = alertas_Umi.findIndex(item => item.idLocal == idLocal);

    if (indice >= 0) {
        alertas_Umi[indice] = {idLocal, umi, grauDeAviso, grauDeAvisoCor };
    } else {
        alertas_Umi.push({ idLocal, umi, grauDeAviso, grauDeAvisoCor });
    }

    exibirCards_Umi();
    
// Dentro da div com classe grauDeAvisoCor há um caractere "invisível", 
// que pode ser inserido clicando com o seu teclado em alt+255 ou pelo código adicionado acima.
}

function exibirAlerta_Temp(temp, idLocal, grauDeAviso, grauDeAvisoCor) {
    var indice = alertas_Temp.findIndex(item => item.idLocal == idLocal);

    if (indice >= 0) {
        alertas_Temp[indice] = {idLocal, temp, grauDeAviso, grauDeAvisoCor };
    } else {
        alertas_Temp.push({ idLocal, temp, grauDeAviso, grauDeAvisoCor });
    }

    exibirCards_Temp();
    
// Dentro da div com classe grauDeAvisoCor há um caractere "invisível", 
// que pode ser inserido clicando com o seu teclado em alt+255 ou pelo código adicionado acima.
}

function removerAlerta_Umi(idLocal) {
    alertas_Umi = alertas_Umi.filter(item => item.idLocal != idLocal);
    exibirCards_Umi();
}

function removerAlerta_Temp(idLocal) {
    alertas_Temp = alertas_Temp.filter(item => item.idLocal != idLocal);
    exibirCards_Temp();
}
 
function exibirCards_Umi() {
    alerta_Umi.innerHTML = '';

    for (var i = 0; i < alertas_Umi.length; i++) {
        var mensagem = alertas_Umi[i];
        alerta_Umi.innerHTML += transformarEmDiv_Umi(mensagem);
    }
}

function exibirCards_Temp() {
    alerta_Temp.innerHTML = '';

    for (var i = 0; i < alertas_Temp.length; i++) {
        var mensagem = alertas_Temp[i];
        alerta_Temp.innerHTML += transformarEmDiv_Temp(mensagem);
    }
}

function transformarEmDiv_Umi({idLocal, umi, grauDeAviso, grauDeAvisoCor}) {
    return `<div class="mensagem-alarme">
    <div class="informacao">
    <div class="${grauDeAvisoCor}">&#12644;</div> 
     <h3>Seu Local de Numero:${idLocal} está em estado de ${grauDeAviso}!</h3>
    <small>Umidade ${umi}</small>   
    </div>
    <div class="alarme-sino"></div>
    </div>`;
}

function transformarEmDiv_Temp({idLocal, temp, grauDeAviso, grauDeAvisoCor}) {
    return `<div class="mensagem-alarme">
    <div class="informacao">
    <div class="${grauDeAvisoCor}">&#12644;</div> 
     <h3>Seu Local de Numero:${idLocal} está em estado de ${grauDeAviso}!</h3>
    <small>Temperatura ${temp}</small>   
    </div>
    <div class="alarme-sino"></div>
    </div>`;
}
