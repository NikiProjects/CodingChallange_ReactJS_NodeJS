/**
 * 
 */
const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
var app = express();


app.use(bodyParser.urlencoded({ extended: true })); 

app.post("/action", function(req , res){
	console.log("hello from db.js");
})

//Setting up server
var server = app.listen(8082,function(){
    var port = server.address().port;
    console.log("App now running on port ",port);
});


