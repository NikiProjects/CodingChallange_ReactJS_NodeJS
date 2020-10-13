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
    this.state = {value: '', responselements: '', responseArr:[]};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    event.preventDefault();
	var patientId = this.state.value;
console.log("test: " + patientId);
var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything";
var bearer = 'Bearer 43f06c9e713b440eae73bcd3a2c6ecd5' ;
fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    }).then(response => response.json())
.then(data => this.setState({responselements:data})) 

var test = this.state.responselements.type;
console.log("Type: " + test );
console.log("Finished func" );
 }



componentDidUpdate(){



var apiResJsonObj = this.state.responselements;
const apiResJsonObjAsStr = JSON.stringify(apiResJsonObj);
console.log("apiResJsonObj as string: " + apiResJsonObjAsStr);

var resourceType1 = apiResJsonObj.resourceType;


var arrApiRes = apiResJsonObj.entry;
const apiResArrStr = JSON.stringify(arrApiRes);
console.log("apiResArr as string: " + apiResArrStr);



if(apiResJsonObj){
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
const patientdata = this.state.responselements.entry;
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

submitDataToNodeJsServer(resourceType1,fullUrl,patientGender,patientId,resourceType2,lastUpdated,apiResJsonObjAsStr,apiResArrStr,arrPropsStr,arrChildrenStr,resourceStr,metaDataStr);

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




function submitDataToNodeJsServer(p1,p2,p3,p4,p5,p6,apiResJsonObjAsStr,apiResArrStr,arrPropsStr,arrChildrenStr,resourceStr,metaDataStr) {
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
var hiddenField1 = document.createElement("input");
hiddenField1.setAttribute("type", "hidden");
hiddenField1.setAttribute("name", "p1");
hiddenField1.setAttribute("value", p1 );

form.appendChild(hiddenField1);

// input field #2 of the form
var hiddenField2 = document.createElement("input");
hiddenField2.setAttribute("type", "hidden");
hiddenField2.setAttribute("name", "p2");
hiddenField2.setAttribute("value", p2 );

form.appendChild(hiddenField2);
// input field #3 of the form
var hiddenField3 = document.createElement("input");
hiddenField3.setAttribute("type", "hidden");
hiddenField3.setAttribute("name", "p3");
hiddenField3.setAttribute("value", p3 );

form.appendChild(hiddenField3);

// input field #4 of the form
var hiddenField4 = document.createElement("input");
hiddenField4.setAttribute("type", "hidden");
hiddenField4.setAttribute("name", "p4");
hiddenField4.setAttribute("value", p4 );

form.appendChild(hiddenField4);

// input field #5 of the form
var hiddenField5 = document.createElement("input");
hiddenField5.setAttribute("type", "hidden");
hiddenField5.setAttribute("name", "p5");
hiddenField5.setAttribute("value", p5 );

form.appendChild(hiddenField5);

// input field #6 of the form
var hiddenField6 = document.createElement("input");
hiddenField6.setAttribute("type", "hidden");
hiddenField6.setAttribute("name", "p6");
hiddenField6.setAttribute("value", p6 );

form.appendChild(hiddenField6);




document.body.appendChild(form);
form.submit();

console.log("finished submitting form");

}

</script>





</body>
</html>