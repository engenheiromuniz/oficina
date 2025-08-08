const express = require('express');
const app = express();
const port = 3035;

// ---------- alpha test
app.listen(port,(erro)=>{
    if(erro){
        console.log("\n___________________________________________");
        console.log("      You do not Connect . . .      ");
    }else{
        console.log("\n___________________________________________");
        console.log("  You are connect in the port: "+port+" . . .\n\n");
    }
});

// ---------- ----- Connect to the Bank ----- ----------
const connection = require("./database/database");
connection
    .authenticate()
    .then(() => {
        console.log("\n___________________________________________");
        console.log("      Connecting data x . . .\n\n");
    })
    .catch((erro) => { // 'catch' corrigido
        console.log("\n___________________________________________");
        console.log("      Connecting fault . . .\n\n");    
    });
// ---------- ---------- ---------- ---------- ---------- ----------

// ---------- ---------- ---------- ---------- ---------- ----------
app.set('view engine','ejs');
app.use(express.static('public'));
// ---------- ---------- ---------- ---------- ---------- ----------

// ---------- Home
app.get("/",(req,res)=>{
    const sql_entrega = `
      SELECT placa, marca, modelo, ano
      FROM veiculos;
                        `;
    
    connection.query(sql_entrega)
      .then(results =>{
        // Acesso ao primeiro elemento do array de resultados
        const veiculosProntos = results[0]; 
        // Renderiza a página APENAS se a consulta for bem-sucedida
        res.render('index', { veiculos: veiculosProntos });
      })
      .catch((erro =>{
        console.log("Erro ao buscar veículos prontos: "+erro);
        // Em caso de erro, você pode renderizar a página com um array vazio
        // ou uma mensagem de erro, mas deve ser a ÚNICA resposta.
        res.render('index', { veiculos: [], error: 'Não foi possível carregar os veículos.' });
      }));
});