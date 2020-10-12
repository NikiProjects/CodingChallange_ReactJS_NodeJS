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
var bearer = 'Bearer 14bb63e934514e2cabcf2ea39e47774b' ;
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

var arrApiRes = apiResJsonObj.entry;
const apiResArrStr = JSON.stringify(arrApiRes);
console.log("apiResArr as string: " + apiResArrStr);



if(apiResJsonObj){
	document.getElementById("containerResourceType1").innerHTML = "The resource type #1 found is : " + apiResJsonObj.resourceType;
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

myFunction(fullUrl);

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




function myFunction(p1) {
  console.log("my test function invoked in componentDidUpdate" + p1);   // The function returns the product of p1 and p2
}

</script>





</body>
</html>