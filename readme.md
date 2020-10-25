Notes on Coding Challange Pre requisites: 
My application name: RetrieveAllPatientData

Location of project on C drive: C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData

Step1: 
C:\WINDOWS\system32>curl -X POST "https://api.1up.health/user-management/v1/user" -d "app_user_id=nkulkarni" -d "client_id=providedBy1upHealth" -d "client_secret=providedBy1upHealth"
{"success":true,"code":"6c0f9239fab149478792968225454d97","oneup_user_id":123311463,"app_user_id":"nkulkarni","active":true}
C:\WINDOWS\system32>

Above 'app_user_id' key is set to the username we provided when we created a new account.
Also, when we created a new application, certain values were provided that we included in above command(application details, see notes above). 
Now, using the 'code' property value in above command, we will generate the access token and refresh token. 

Step2:

Microsoft Windows [Version 10.0.19041.508]
(c) 2020 Microsoft Corporation. All rights reserved.


C:\WINDOWS\system32>curl -X POST "https://api.1up.health/user-management/v1/user/auth-code" -d "client_id=provided by 1upHealth" -d "client_secret=providedBy1upHealth" -d "app_user_id=nkulkarni"
{"success":true,"code":"b3e18eb6de9c480ebb7ea5836aba18a6","oneup_user_id":123311463,"app_user_id":"nkulkarni","active":true}
C:\WINDOWS\system32>


Step 3: (results in generation of access token)
Microsoft Windows [Version 10.0.19041.508]
(c) 2020 Microsoft Corporation. All rights reserved.

C:\WINDOWS\system32>curl -X POST "https://api.1up.health/fhir/oauth2/token" -d "client_id=providedBy1upHealth" -d "client_secret=providedBy1upHealth" -d "code=b3e18eb6de9c480ebb7ea5836aba18a6" -d "grant_type=authorization_code"
{"refresh_token":"0c0cc2334431431b99cec8a828f67b00","token_type":"bearer","access_token":"f2d5fe0c162b407099396f91884ff7f8","expires_in":7200,"scope":"user/*.*"}
C:\WINDOWS\system32>

Step 4: Creation of patient using Postman: 
Request using Postman: 
Request Type: POST
Navigate to 'Authorization' tab  ----> Select Type as 'Bearer Token' 
Request URL: https://api.1up.health/fhir/dstu2/Patient  
Body: is 'Raw'
Body: {"resourceType": "Patient","id": "tomhanks","gender": "male"}

How to create a new access token: 
To generate a new token run the following command: (YOU DO NOT HAVE TO REPEAT ANY OF THE PREVIOUS STEPS)
Microsoft Windows [Version 10.0.19041.508]
(c) 2020 Microsoft Corporation. All rights reserved.
C:\WINDOWS\system32>curl -X POST https://api.1up.health/fhir/oauth2/token -d "client_id=providedBy1upHealth" -d "client_secret=providedBy1UpHealth" -d "refresh_token=0c0cc2334431431b99cec8a828f67b00" -d "grant_type=refresh_token"
{"refresh_token":"86e9f5f5fb45427c835631b89244dca2","token_type":"bearer","access_token":"6c0fa6f011d3451d82a44418aface40f","expires_in":7200}

C:\WINDOWS\system32>

How to retrieve patient info using Postman: 

Was able to retrieve created patient's info using Postman: 
method: GET 
In the 'Authorization' tab, we need to supply the newly created access token 
Request url we specified as: https://api.1up.health/fhir/dstu2/Patient/tomhanks
response/output: {
    "gender": "male",
    "meta": {
        "lastUpdated": "2020-10-10T12:04:03.178Z",
        "versionId": "9000000000000"
    },
    "id": "4ed6307403a1",
    "resourceType": "Patient"
}


To access all of the Patient resources using Postman, submit the following request: 
Type: GET 
Request URL: https://api.1up.health/fhir/dstu2/Patient 
Navigate to Authorization tab Select Type as 'Bearer Token' 
The response/output(a total of 2 patient resources were created)
is the following: 
 {
    "resourceType": "Bundle",
    "type": "searchset",
    "total": 2,
    "entry": [
        {
            "fullUrl": "https://api.1up.health/fhir/dstu2/Patient/4ed6307403a1",
            "search": {
                "mode": "match"
            },
            "resource": {
                "meta": {
                    "lastUpdated": "2020-10-10T12:04:03.178Z",
                    "versionId": "9000000000000"
                },
                "gender": "male",
                "resourceType": "Patient",
                "id": "4ed6307403a1"
            }
        },
        {
            "fullUrl": "https://api.1up.health/fhir/dstu2/Patient/6e7c6386bfca",
            "search": {
                "mode": "match"
            },
            "resource": {
                "meta": {
                    "lastUpdated": "2020-10-10T00:26:23.050Z",
                    "versionId": "9000000000000"
                },
                "gender": "male",
                "resourceType": "Patient",
                "id": "6e7c6386bfca"
            }
        }
    ]
}


To get details about 1 Patient resource, use the URL's shown in above section. The url's shown above are used as request urls. This request was submitted using 
Postman: 
Request Type: GET
Request URL: https://api.1up.health/fhir/dstu2/Patient/4ed6307403a1
Response Body: 
{
    "meta": {
        "lastUpdated": "2020-10-10T12:04:03.178Z",
        "versionId": "9000000000000"
    },
    "gender": "male",
    "resourceType": "Patient",
    "id": "4ed6307403a1"
}


How to use the $everything syntax: We can demo the $everything syntax using Postman:
Request Type: GET
Request URI: https://api.1up.health/fhir/dstu2/Patient/6e7c6386bfca/$everything
In the URI above, the dstu2 can be changed to stu3. Or it can be changed to r4 as these values represent the version of FHIR. 
Also we can vary the id. Responses in above section provide the patient id. For example, in above line, 6e7c6386bfca represents the patient id. When submitting this request, we
we need to specify the authorization header. 
The Response is the following: 
{
    "resourceType": "Bundle",
    "type": "searchset",
    "total": 1,
    "entry": [
        {
            "fullUrl": "https://api.1up.health/fhir/dstu2/Patient/6e7c6386bfca",
            "search": {
                "mode": "match"
            },
            "resource": {
                "gender": "male",
                "meta": {
                    "lastUpdated": "2020-10-10T00:26:23.050Z",
                    "versionId": "9000000000000"
                },
                "id": "6e7c6386bfca",
                "resourceType": "Patient"
            }
        }
    ]
}


Downloaded and installed NodeJS to implement Node JS Server. The following Node JS modules were used to implement the Node JS Server: 

Microsoft Windows [Version 10.0.19041.508]
(c) 2020 Microsoft Corporation. All rights reserved.

C:\Users\Nikita>cd C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData

C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData>npm install express
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\package.json'
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\package.json'
npm WARN RetrievePatientData No description
npm WARN RetrievePatientData No repository field.
npm WARN RetrievePatientData No README data
npm WARN RetrievePatientData No license field.

+ express@4.17.1
added 50 packages from 37 contributors and audited 50 packages in 6s
found 0 vulnerabilities


C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData>npm install body-parser
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\package.json'
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\package.json'
npm WARN RetrievePatientData No description
npm WARN RetrievePatientData No repository field.
npm WARN RetrievePatientData No README data
npm WARN RetrievePatientData No license field.

+ body-parser@1.19.0
updated 1 package and audited 88 packages in 1.255s
found 0 vulnerabilities


C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData>npm install mysql
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\package.json'
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\package.json'
npm WARN RetrievePatientData No description
npm WARN RetrievePatientData No repository field.
npm WARN RetrievePatientData No README data
npm WARN RetrievePatientData No license field.

+ mysql@2.18.1
added 9 packages from 14 contributors and audited 97 packages in 2.138s
found 0 vulnerabilities


Script that was used to setup the database for this project: 
CREATE SCHEMA `1uphealthpatientpool`;

USE 1uphealthpatientpool;

CREATE TABLE `patients` (
  `patient_id` varchar(15) NOT NULL,
  `resourceType1` varchar(100) DEFAULT NULL,
  `resourceType2` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `fullUrl` varchar(600) DEFAULT NULL,
  `lastUpdated` varchar(50) DEFAULT NULL,
  `insertTs` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;


In order to implement the React client, the following files were imported:
<script src="https://unpkg.com/react@16/umd/react.production.min.js"></script>
<script src="https://unpkg.com/react-dom@16/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>

Node JS installation notes: 

Getting latest version of the Chocolatey package for download.
Getting Chocolatey from https://chocolatey.org/api/v2/package/chocolatey/0.10.15.
Extracting C:\Users\Nikita\AppData\Local\Temp\chocolatey\chocInstall\chocolatey.zip to C:\Users\Nikita\AppData\Local\Temp\chocolatey\chocInstall...
Installing chocolatey on this machine
Creating ChocolateyInstall as an environment variable (targeting 'Machine')
  Setting ChocolateyInstall to 'C:\ProgramData\chocolatey'
WARNING: It's very likely you will need to close and reopen your shell
  before you can use choco.
Restricting write permissions to Administrators
We are setting up the Chocolatey package repository.
The packages themselves go to 'C:\ProgramData\chocolatey\lib'
  (i.e. C:\ProgramData\chocolatey\lib\yourPackageName).
A shim file for the command line goes to 'C:\ProgramData\chocolatey\bin'
  and points to an executable in 'C:\ProgramData\chocolatey\lib\yourPackageName'.

Creating Chocolatey folders if they do not already exist.

WARNING: You can safely ignore errors related to missing log files when
  upgrading from a version of Chocolatey less than 0.9.9.
  'Batch file could not be found' is also safe to ignore.
  'The system cannot find the file specified' - also safe.
WARNING: Not setting tab completion: Profile file does not exist at
'C:\Users\Nikita\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'.
Chocolatey (choco.exe) is now ready.
You can call choco from anywhere, command line or powershell by typing choco.
Run choco /? for a list of functions.
You may need to shut down and restart powershell and/or consoles
 first prior to using choco.
Ensuring chocolatey commands are on the path
Ensuring chocolatey.nupkg is in the lib folder
Chocolatey v0.10.15
Upgrading the following packages:
python;visualstudio2017-workload-vctools
By upgrading you accept licenses for the packages.
python v3.9.0 is the latest version available based on your source(s).
visualstudio2017-workload-vctools is not installed. Installing...
Progress: Downloading visualstudio2017-workload-vctools 1.3.2... 100%
Progress: Downloading visualstudio2017-workload-vctools 1.3.2... 100%

visualstudio2017buildtools v15.9.27.0 [Approved]
visualstudio2017buildtools package files upgrade completed. Performing other installation steps.
File appears to be downloaded already. Verifying with package checksum to determine if it needs to be redownloaded.
Hashes match.
Hashes match.
Installing visualstudio2017buildtools...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1028\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\2052\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1055\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1046\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1042\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1029\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1036\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\3082\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1040\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1031\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1045\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1041\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1049\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\HelpFile\1033\help.html...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\vs_setup_bootstrapper.exe...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.Diagnostics.Tracing.EventSource.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.RemoteControl.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.Setup.Common.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.Setup.Configuration.Interop.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.Setup.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.Setup.Download.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.Setup.Engine.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.Telemetry.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Microsoft.VisualStudio.Utilities.Internal.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\Newtonsoft.Json.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\zh-Hans\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\zh-Hant\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\cs\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\es\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\pt-BR\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\tr\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\de\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\fr\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\it\vs_setup_bootstrapper.resources.dll...


Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\pl\vs_setup_bootstrapper.resources.dll...
Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\ko\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\ja\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\ru\vs_setup_bootstrapper.resources.dll...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\vs_setup_bootstrapper.config...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\vs_setup_bootstrapper.exe.config...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\detection.json...

Preparing: C:\Users\Nikita\AppData\Local\Temp\chocolatey\a30afeeca8d50015de257430\vs_bootstrapper_d15\vs_setup_bootstrapper.json...

visualstudio2017buildtools has been installed.
  visualstudio2017buildtools may be able to be automatically uninstalled.
 The upgrade of visualstudio2017buildtools was successful.
  Software installed to 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools'

visualstudio2017-workload-vctools v1.3.2 [Approved]
visualstudio2017-workload-vctools package files upgrade completed. Performing other installation steps.
Installing visualstudio2017-workload-vctools...

visualstudio2017-workload-vctools has been installed.
  visualstudio2017-workload-vctools may be able to be automatically uninstalled.
 The upgrade of visualstudio2017-workload-vctools was successful.
  Software install location not explicitly set, could be in package or
  default install location if installer.

Chocolatey upgraded 2/3 packages.
 See the log for details (C:\ProgramData\chocolatey\logs\chocolatey.log).
Type ENTER to exit:

Giving a demo of this project: 
1) Open Eclipse Mars 1 and navigate to project C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData. 
2) Run the C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\WebContent\retrieveAndDisplayPatientData.jsp file on Tomcat7 Server included by the Eclipse environment. 
3) Start the Node JS Server, by: 
- in the cmd navigate into the path  C:\Users\Nikita\Nex-G-wkspace\RetrievePatientData\WebContent\. This is the directory location of the db.js file. The Node JS Server is implemented in the db.js file. 
- using the cmd run the command node db.js. 
4) In the new browser page that pops up when the jsp file is run, a React form will be displayed to the user. The form includes 1) 1 input field 2) a submit button. In the input field, the user should enter a patient id that exists in the 1upHealth system. After entering the patient id, the submit button should be pressed. 

Implementation logic at a high level: 
Upon the click of the 'Submit' button, the logic within the handleSubmit(event) function is executed. This logic first checks if the user provided patient id exist in the db. This is done by sending a GET request to our Node JS Server. 2)If a record exists in the '1uphealthpatientpool.patients' table with that patient's id, the logic analyzes the insertTs column for this record in the db. 3)Next, the value of the insertTs column is compared to the current timestamp. The insertTs timestamp indicates the time at which the 1upHealth Api was called, and when this api delivered info was inserted into the db. If the logic finds that the difference between the current timestamp and insertTs timestamp is greater than 2 hours, then the logic invokes the 1upHealthApi to retrieve the patient info. If the difference is less than 2 hours, the function logic extracts patient info from db and displays it to the user on the DOM. In the case, this patient id does not exist in the db, the 1upHealth API is invoked, and the response from the 1upHealth API is displayed to the user. 

The componentDidUpdate() function serves two major function:
The logic within this function takes values that have been set into the 'state' variable and displays these values on the DOM. This 'state' variable contains the   
database retrieved values that are rendered on the DOM by using syntax like document.getElementById("containerPatientId").innerHTML = "The patient's id is : " + patientIdFromDb;
2) The componentDidUpdate() function also extracts values from the JSON response and displays these values on the DOM. 

The render() function is used to create the form and the other DOM elements. 

The logic within this JSP depends on helper functions that are placed outside of the React Component. Also, within the React Component, we declare helper function that can be called with the keyword 'this'. Any references to this.setState should take place within these internal helper functions. 

Project Technical Details: 
The client/form is implemented using React JS. (RetrievePatientData\WebContent\retrieveAndDisplayPatientData.jsp)
The server is implemented in Node JS. (RetrievePatientData\WebContent\retrieveAndDisplayPatientData.jsp). 

The features include: 
1) A front end form that accepts the patient id and a SUBMIT button. 
2) Upon click of submit button validation is performed to determine if patient already exists in local db(MySql). 
3) If patient already exists in local db, GET request is submitted to Node JS Server to retrieve the patient data from db. The db retrieved values are displayed on JSP page.  
4) If patient does not exist in local db, a POST request is submitted to Node JS Server to insert the new data in db. In this case user is navigated to Node JS server, which renders the patient info. In this case, the client sends request using the 1upHealth FHIR $everything query.  The project's logic parses through the JSON response delivered by the 1upHeath API. The info was parsed for human readability and is stored in db and displayed to the user. 
5) I used Eclipse Mars to develop this project. 
6) Tomcat version 7 at localhost was used to run the client on port 8081. 
7) The NodeJS Server was run on port 8082. Configuration was added in this project to allow for cross port communication. 

Notes: 
- If we make changes in the db.js file, we need to restart the Node JS Server for the changes to take affect. 
The console.log statements in the db.js file are output the the Windows cmd.   
- If we make changes to the JSP file, we simply need to refresh the browser page for the changes to take affect. In this case, we do not need to restart the Tomcat Server. 