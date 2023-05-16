var database = require("../database/config");

function buscarUltimasMedidas_Umi(idLocal, limite_linhas, idSensor) {

    var limite_linhas = 10;

    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fk_aquario = ${idAquario}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `
        SELECT 
        Distinct(Leitura_Umi) AS umidade, 
        DATE_FORMAT(Data_Hora,'%H:%i') AS momento_grafico 
        FROM 
        Leitura 
        JOIN Localização 
        ON FKLocal_LE = idLocal
        WHERE idLocal = ${idLocal}
        ORDER BY momento_grafico DESC
        LIMIT ${limite_linhas};`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal_Umi(idLocal, limite_linhas, idSensor) {

    var limite_linhas = 10;

    instrucaoSql = '';

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `
        SELECT 
        Distinct(Leitura_Umi) AS umidade, 
        DATE_FORMAT(Data_Hora,'%H:%i') AS momento_grafico 
        FROM 
        Leitura 
        JOIN Localização 
        ON FKLocal_LE = idLocal
        WHERE idLocal = ${idLocal}
        ORDER BY momento_grafico DESC
        LIMIT ${limite_linhas};`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarUltimasMedidas_Temp(idLocal, limite_linhas, idSensor) {

    var limite_linhas = 10;


    instrucaoSql = ''

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top ${limite_linhas}
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        momento,
                        FORMAT(momento, 'HH:mm:ss') as momento_grafico
                    from medida
                    where fk_aquario = ${idAquario}
                    order by id desc`;
    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `
        SELECT 
        Distinct(Leitura_Temp) AS temperatura, 
        DATE_FORMAT(Data_Hora,'%H:%i') AS momento_grafico 
        FROM 
        Leitura 
        JOIN Localização 
        ON FKLocal_LE = idLocal
        WHERE idLocal = ${idLocal}
        ORDER BY momento_grafico DESC
        LIMIT ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal_Temp(idLocal, limite_linhas, idSensor) {

    var limite_linhas = 15;


    instrucaoSql = '';

    if (process.env.AMBIENTE_PROCESSO == "producao") {
        instrucaoSql = `select top 1
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,  
                        CONVERT(varchar, momento, 108) as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc`;

    } else if (process.env.AMBIENTE_PROCESSO == "desenvolvimento") {
        instrucaoSql = `
        SELECT 
        Distinct(Leitura_Temp) AS temperatura, 
        DATE_FORMAT(Data_Hora,'%H:%i') AS momento_grafico 
        FROM 
        Leitura 
        JOIN Localização 
        ON FKLocal_LE = idLocal
        WHERE idLocal = ${idLocal}
        ORDER BY momento_grafico DESC
        LIMIT ${limite_linhas}`;
    } else {
        console.log("\nO AMBIENTE (produção OU desenvolvimento) NÃO FOI DEFINIDO EM app.js\n");
        return
    }

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas_Umi,
    buscarMedidasEmTempoReal_Umi,
    buscarUltimasMedidas_Temp,
    buscarMedidasEmTempoReal_Temp,
}
