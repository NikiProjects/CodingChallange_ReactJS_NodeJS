/**
 * 
 */
const express = require('express');
// const router = express.Router();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const routes = require('routes');
var app = express();


app.use(bodyParser.urlencoded({ extended: true })); 


app.post("/action", function(req , res){
	console.log("hello from db.js");
	var reqBody = req.body
	console.log('Got body:', reqBody);
	
	var p1FromReqBody = reqBody.p1;
	var p2FromReqBody = reqBody.p2;
	var p3FromReqBody = reqBody.p3;
	var p4FromReqBody = reqBody.p4;
	var p5FromReqBody = reqBody.p5;
	var p6FromReqBody = reqBody.p6;
	
	console.log("value of p1 property from req body: " + p1FromReqBody);
	console.log("value of p2 property from req body: " + p2FromReqBody);
	console.log("value of p3 property from req body: " + p3FromReqBody);
	console.log("value of p4 property from req body: " + p4FromReqBody);
	console.log("value of p5 property from req body: " + p5FromReqBody);
	console.log("value of p6 property from req body: " + p6FromReqBody);
	
	const connection = mysql.createPool({
		  host     : 'localhost',
		  user     : 'root',
		  password : 'ILN19#',
		  database : '1uphealthpatientpool'
		});

if(connection){
		console.log("pool created successfully")	
	
	// Connecting to the database.
    connection.getConnection(function (err, connection) {

    	var insertSqlStmt = "REPLACE INTO patients (patient_id, resourceType1, resourceType2, gender, fullUrl, lastUpdated) VALUES ('" + p4FromReqBody +"', '" + p1FromReqBody + "', '" + p5FromReqBody +"', '" + p3FromReqBody + "', '" + p2FromReqBody + "', '" + p6FromReqBody + "')";
		console.log("insert sql stmt: " + insertSqlStmt);	
    	
    	
    // Executing the MySQL query (select all data from the 'users' table).
    connection.query(insertSqlStmt, function(err) {
        if (err) {
            console.error('Error:- ' + err.stack);
            return;
        }
     
        console.log('Connected Id:- ' + connection.threadId);
    }); // end of connection.query
  }); // end of connection.getConnection
	

}
	else{
		console.log("could not connect to database");
	}

res.write('<html>');
res.write('<head> <title> Hello TutorialsPoint </title> </head>');
res.write(' <body> Resource Type 1: ' + p1FromReqBody + '  Resource Type 2: ' + p5FromReqBody + '  PatientId: ' + p4FromReqBody + '  Gender: ' + p3FromReqBody + '  Patient Full Url: ' + p2FromReqBody + '  Patient Data Last Updated: ' + p6FromReqBody + '</body>');
res.write('</html>');
//write end to mark it as stop for node js response.
res.end();


// return res.send("Hello");
// app.use('/', routes);
//res.status(200).send();
//return res.redirect('http://localhost:8081/RetrievePatientData/retrieveAndDisplayPatientData.jsp');
//res.redirect('/retrieveAndDisplayPatientData.jsp');
//res.redirect('back');
//return res.redirect('/');'
//return res.redirect('/');

//return;

})

//Setting up server
var server = app.listen(8082,function(){
    var port = server.address().port;
    console.log("App now running on port ",port);
});


