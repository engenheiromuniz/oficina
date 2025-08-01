const express = require("express");
const app = express();
const port  = 3035;

const bodyparser = require("body-parser");

app.set('view engine', 'ejs');
app.use(express.static('public'));


//----- Connect -----
app.listen(port,function(erro){
    if(erro){
    console.erro("Sistema enfrentando problema de conexão.");
    }else{
        console.log("Conectado na porta ",port);
    }
});


//----- Primeiro Teste -----
app.get("/teste1",function(req,res){
    res.send("<h1>Sistema em funcionamento ... <h1>");
});



//----- -----

//----- -----

//----- -----

//----- -----

//----- -----
