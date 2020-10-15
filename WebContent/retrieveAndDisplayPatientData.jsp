<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Patient Data</title>
</head>

<script src="https://unpkg.com/react@16/umd/react.production.min.js"></script>
<script src="https://unpkg.com/react-dom@16/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>


<div id="rootContainer"></div>

<body>

<script type="text/babel">
class RetrievePatientDataForm extends React.Component {


constructor(props) {
    super(props);
    this.state = {value: '', responselements: '', responseArr:[], dbrecords:'', patientIdFromDbState:'', resourceType1FromDbState:'',resourceType2FromDbState:'',genderFromDbState:'',fullUrlFromDbState:'',lastUpdatedFromDbState:''};
	
	let insertDateFromDb = '';
	let Difference_In_Time = '';	

	this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
 	


}

	handleChange(event) {
    this.setState({value: event.target.value});
  }
 
  handleSubmit(event) {
    event.preventDefault();
	var patientId = this.state.value;
console.log("Patient Id received in handleSubmit function: " + patientId);




var urlgetdbrecs = "http://localhost:8082/getPatientRecord/?id="+ patientId;

var promise1 = fetch(urlgetdbrecs,{
        method: 'GET',
				headers: {
            'Content-Type': 'application/json'
        }
		});

var promise2 = promise1.then(response => response.json());
     
promise2.then(dbPatientData =>{this.setState({dbrecords:dbPatientData});
if(dbPatientData.length != 0){
console.log("1upHealth Api Response's length of dbPatientDataArray: " + dbPatientData.length);
var dbPatientDataAsStr = JSON.stringify(dbPatientData);
console.log("dbPatientDataAsStr: " + dbPatientDataAsStr);

var dbPatientDataAsStrHasPatientId = dbPatientDataAsStr.includes(patientId);
console.log("dbPatientDataAsStrHasPatientId " + dbPatientDataAsStrHasPatientId);


console.log("In retrieve from db block");
var patientIdArrIndex0FromDb = dbPatientData[0].patient_id;


var patientIdFromDb = dbPatientData[0].patient_id;
var resourceType1FromDb = dbPatientData[0].resourceType1;
var resourceType2FromDb = dbPatientData[0].resourceType2;
var genderFromDb = dbPatientData[0].gender;
var fullUrlFromDb = dbPatientData[0].fullUrl;
var lastUpdatedFromDb = dbPatientData[0].lastUpdated;
let insertDateFromDb = dbPatientData[0].insertTs;
console.log("insertTsFromDb: " + insertDateFromDb);

var splitStr = insertDateFromDb.split("-");
console.log("Split num1 results in: " + splitStr);
console.log("splitStr index 0 " + splitStr[0]);
var yearDbInsertTs = splitStr[0];
console.log("Year: " + yearDbInsertTs);
var monthDbInsertTs = splitStr[1];
console.log("Month: " + monthDbInsertTs);
var secondSplit = splitStr[2].split('T');
console.log("2nd split: " + secondSplit);
var dayDbInsertTs = secondSplit[0];
console.log("Day: " + dayDbInsertTs);

var thirdSplit = secondSplit[1].split(":");
console.log("3rd split: " + thirdSplit);
var hoursDbInsertTs = thirdSplit[0];
console.log("Hours: " + hoursDbInsertTs);

var minutesDbInsertTs = thirdSplit[1];
console.log("Minutes: " + minutesDbInsertTs);
var fourthSplit = thirdSplit[2].split(".");
console.log("4th split: " + fourthSplit);
var secondsDbInsertTs = fourthSplit[0];
console.log("Seconds: " + secondsDbInsertTs);



var currentDate = new Date();

var dateInsertTsDb = new Date(yearDbInsertTs, monthDbInsertTs, dayDbInsertTs, 10, minutesDbInsertTs, secondsDbInsertTs);
console.log("print: " + dateInsertTsDb);

let Difference_In_Time = currentDate.getTime() - dateInsertTsDb.getTime(); 
console.log("Diff: " + Difference_In_Time);

if(Math.abs(Difference_In_Time) < 3600000)
{
this.setState({
      patientIdFromDbState: patientIdFromDb
    });

this.setState({
      resourceType1FromDbState: resourceType1FromDb
    });

this.setState({
      resourceType2FromDbState: resourceType2FromDb
    });

this.setState({
      genderFromDbState: genderFromDb
    });

this.setState({
      fullUrlFromDbState: fullUrlFromDb
    });
this.setState({
      lastUpdatedFromDbState: lastUpdatedFromDb
    });

console.log("Completed if block - patient id exists in db.");
}

else{
console.log("Executing new else block");
var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything";
var bearer = 'Bearer 026b74a30e544248945ea5d75b59e056' ;
fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    }).then(response => response.json())
.then(data => this.setState({responselements:data})) 
}

}
else{
console.log("In retrieve from API block");
var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything";
var bearer = 'Bearer 026b74a30e544248945ea5d75b59e056' ;
fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    }).then(response => response.json())
.then(data => this.setState({responselements:data})) 

var testRetrieveTypeField = this.state.responselements.type;

console.log("Type field from 1upHealthApi: " + testRetrieveTypeField);
console.log("Finished executing click of onSubmit function" );


}


}
);


}




componentDidUpdate(){


var patientIdFromDb = this.state.patientIdFromDbState;
var resourceType1FromDb = this.state.resourceType1FromDbState;
var resourceType2FromDb = this.state.resourceType2FromDbState;
var genderFromDb = this.state.genderFromDbState;
var fullUrlFromDb = this.state.fullUrlFromDbState;
var lastUpdatedFromDb = this.state.lastUpdatedFromDbState;

checkIfDbRetrievedValuesAreAssignedToStateObjProps(patientIdFromDb,resourceType1FromDb,resourceType2FromDb,genderFromDb,fullUrlFromDb,lastUpdatedFromDb);

var rootApiResJsonObj = this.state.responselements;

if(rootApiResJsonObj){
	parseJsonFrom1upHealthApiRes(rootApiResJsonObj);
}

}







  render() {

    return (
	<div>
      <form onSubmit={this.handleSubmit}>
        <label>
          PatientId:
		  <input type="text" value={this.state.value} onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit" />
      </form>
	<br/>
	<div id="containerPatientId"></div>
	<br/>
	<div id="containerPatientGender"></div>
	<br/>
	<div id="containerfullUrl"></div>
	<br/>
	<div id="containerLastUpdatedValue"></div>	
	<br/>
	<br/>	
	<div id="containerResourceType1"></div>
	<br/>	
	<div id="containerResourceType2"></div>
	<br/>
	</div>
    );
  }

}

ReactDOM.render(<RetrievePatientDataForm/>,document.getElementById("rootContainer"));


function checkIfDbRetrievedValuesAreAssignedToStateObjProps(patientIdFromDb,resourceType1FromDb,resourceType2FromDb,genderFromDb,fullUrlFromDb,lastUpdatedFromDb){


if(patientIdFromDb.length != 0){
document.getElementById("containerPatientId").innerHTML = "The patient's id is : " + patientIdFromDb;
}
if(resourceType1FromDb.length != 0){
document.getElementById("containerResourceType1").innerHTML = "The resource type #1 found is : " + resourceType1FromDb;

}
if(resourceType2FromDb.length != 0){
document.getElementById("containerResourceType2").innerHTML = "The resource type #2 found is : " + resourceType2FromDb;
}
if(genderFromDb.length != 0){
document.getElementById("containerPatientGender").innerHTML = "The patient's gender is : " + genderFromDb;

}
if(fullUrlFromDb.length != 0){
document.getElementById("containerfullUrl").innerHTML = "Patient's full info can be found at url : " + fullUrlFromDb;
}
if(lastUpdatedFromDb.length != 0){
document.getElementById("containerLastUpdatedValue").innerHTML = "Patient's info was last updated on : " + lastUpdatedFromDb;
}


}


function parseJsonFrom1upHealthApiRes(rootApiResJsonObj){
const apiResJsonObjAsStr = JSON.stringify(rootApiResJsonObj);
console.log("rootApiResJsonObj as string: " + apiResJsonObjAsStr);

var resourceType1 = rootApiResJsonObj.resourceType;


var arrApiRes = rootApiResJsonObj.entry;
const apiResArrStr = JSON.stringify(arrApiRes);
console.log("apiResArr as string: " + apiResArrStr);



if(rootApiResJsonObj){
	document.getElementById("containerResourceType1").innerHTML = "The resource type #1 found is : " + resourceType1;
}
let arrApiResCopied = [];
let arrProps = "";
let arrChildren = "";
let fullUrl = "";
let resource = "";
let patientGender = "";
let patientId = "";
let resourceType2 = "";
let metaData = "";

if(arrApiRes){
console.log("Detected 'entry' array in API response");
const patientdata = arrApiRes.entry;
let arrApiResCopied = arrApiRes.map((patientvalue) => <li>{patientvalue}</li>);


let arrApiResCopiedStr = JSON.stringify(arrApiResCopied);
console.log("arrApiResCopiedStr" + arrApiResCopiedStr);

let arrProps = arrApiResCopied[0].props;
const arrPropsStr = JSON.stringify(arrProps);
console.log("api res arr props " + arrPropsStr);

let arrChildren = arrProps.children;
const arrChildrenStr = JSON.stringify(arrChildren);
console.log("api res arr children prop" + arrChildrenStr);

let fullUrl = arrChildren.fullUrl;
document.getElementById("containerfullUrl").innerHTML = "The full url to access this patient's data is: " + fullUrl;

let resource = arrChildren.resource;
const resourceStr = JSON.stringify(resource);
console.log("api res arr children resource prop" + resourceStr);

let patientGender = resource.gender;
document.getElementById("containerPatientGender").innerHTML = "The gender of this patient is: " + patientGender;

let patientId = resource.id;
document.getElementById("containerPatientId").innerHTML = "This ID of this patient is: " + patientId;

let resourceType2 = resource.resourceType;
document.getElementById("containerResourceType2").innerHTML = "The resource type #2 found is : " + resourceType2;

let metaData = resource.meta;
const metaDataStr = JSON.stringify(metaData);
console.log("api res arr children resource meta prop" + metaDataStr);

let lastUpdated = metaData.lastUpdated;
document.getElementById("containerLastUpdatedValue").innerHTML = "Patient's data was last updated on : " + lastUpdated;

submitDataToNodeJsServer(resourceType1,fullUrl,patientGender,patientId,resourceType2,lastUpdated);

}
}



function createHiddenField(type,name,value){
var hiddenField = document.createElement("input");
hiddenField.setAttribute("type", type);
hiddenField.setAttribute("name", name);
hiddenField.setAttribute("value", value);
return hiddenField;
}

function submitDataToNodeJsServer(p1,p2,p3,p4,p5,p6) {
console.log("Invoked function submitDataToNodeJsServer");
console.log("value of param1 " + p1);
console.log("value of param2 " + p2);
console.log("value of param3 " + p3);
console.log("value of param4 " + p4);
console.log("value of param5 " + p5);
console.log("value of param6 " + p6);

var form = document.createElement("form");
form.setAttribute("method", "post");
form.setAttribute("action", "http://localhost:8082/action");

// input field #1 of the form
var resourceType1HiddenFld = createHiddenField("hidden","p1",p1);
form.appendChild(resourceType1HiddenFld);

// input field #2 of the form
var fullUrlHiddenFld = createHiddenField("hidden","p2",p2);
form.appendChild(fullUrlHiddenFld);

// input field #3 of the form
var genderHiddenFld = createHiddenField("hidden","p3",p3);
form.appendChild(genderHiddenFld);

// input field #4 of the form
var patientIdHiddenFld = createHiddenField("hidden","p4",p4);
form.appendChild(patientIdHiddenFld);


// input field #5 of the form
var resourceType2HiddenFld = createHiddenField("hidden","p5",p5);
form.appendChild(resourceType2HiddenFld);

// input field #6 of the form
var resourceType2HiddenFld = createHiddenField("hidden","p6",p6);
form.appendChild(resourceType2HiddenFld);

document.body.appendChild(form);
form.submit();

console.log("finished submitting form to node js server.");

}


function hello(){
console.log("Invoked hello helper function");
}

</script>





</body>
</html>