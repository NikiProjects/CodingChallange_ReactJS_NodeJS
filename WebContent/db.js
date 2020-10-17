/**
 * 
 */
const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
var cors = require('cors');
var app = express();


app.use(bodyParser.urlencoded({ extended: true })); 
app.use(cors());


function createHtmlDocWithResponse(res,p1FromReqBody,p5FromReqBody,p4FromReqBody,p3FromReqBody,p2FromReqBody,p6FromReqBody){
	res.write('<html>');
	res.write('<head> <title> Patient Information </title> </head>');
	res.write(' <body> <b>Resource Type 1: </b>' + p1FromReqBody + '      <br/><br/> <b>Resource Type 2: </b>' + p5FromReqBody + '      <br/><br/> <b>PatientId: </b>' + p4FromReqBody + '      <br/><br/><b>Gender: </b>' + p3FromReqBody + '       <br/><br/><b>Patient Full Url: </b>' + p2FromReqBody + '       <br/><br/><b>Patient Data Last Updated: </b>' + p6FromReqBody + '</body>');
	res.write('</html>');
		
	
}


app.post("/action", function(req , res){
	console.log("");
	console.log("");
	console.log("");
	console.log("");
	console.log("");
	console.log("Begin POST controller execution");
	var reqBody = req.body
	console.log('Post Controller Request Body:', reqBody);
	
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
		console.log("Connection pool created successfully Node JS Server GET controller")	
	
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


createHtmlDocWithResponse(res,p1FromReqBody,p5FromReqBody,p4FromReqBody,p3FromReqBody,p2FromReqBody,p6FromReqBody);
//write end to mark it as stop for node js response.
res.end();

//res.render('/');
// return res.send("Hello");
// app.use('/', routes);
//res.status(200).send();
//return res.redirect('http://localhost:8081/RetrievePatientData/retrieveAndDisplayPatientData.jsp');
//res.redirect('/retrieveAndDisplayPatientData.jsp');
//res.redirect('back');
//return res.redirect('/');'
//return res.redirect('/');

//return;

})  // end of post controller


app.get('/getPatientRecord', function (req, res) {
	console.log("");
	console.log("");
	console.log("");
	console.log("");
	console.log("");
	console.log("Begin Node JS Server GET controller");
	const connection = mysql.createPool({
		  host     : 'localhost',
		  user     : 'root',
		  password : 'ILN19#',
		  database : '1uphealthpatientpool',
		  dateStrings: 'date' 
		});

	if(connection){
		// Connecting to the database.
		console.log("Connection pool created successfully Node JS Server GET controller");
	    connection.getConnection(function (err, connection) {

	    	var patientId = req.query.id;
	    	console.log("GET controller: url param retrieved from request object: " + patientId);
	    
	    	var getPatientRecSqlStmt = "SELECT * FROM patients WHERE patient_id = '" + patientId + "'";
			console.log("GET controller: retrieve pateint's record sql stmt: " + getPatientRecSqlStmt);	
	    	
	    	
	    connection.query(getPatientRecSqlStmt, function(error,results,fields) {
	    	if (error) throw error;
	    	var outputRes = JSON.stringify(results);
	    	console.log("GET controller: query results as json string " + outputRes);
	    	res.send(results)
	        console.log('Connected Id:- ' + connection.threadId);
	    }); // end of connection.query
	  }); // end of connection.getConnection
	}
	
	
	
})

//Setting up server
var server = app.listen(8082,function(){
    var port = server.address().port;
    console.log("App now running on port ",port);
});


