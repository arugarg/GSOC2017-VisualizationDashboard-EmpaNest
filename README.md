
Google Summer of Code 2017 : Project Repository   
Organization : Urban Energy Systems Laboratory,Empa    
Project : Open Source Visualization Dashboard for Empa-NEST using Node-Red  
Mentors : Fricker Reto , Philipp Heer  
By : Arushee Garg  
----------------------------------------------------------
Github Link : https://github.com/arugarg/GSOC2017-VisualizationDashboard-EmpaNest  
----------------------------------------------------------
Introduction 


Data on the Empa NEST  is highly diverse and rapidly growing. Currently, this data is stored in separate platformsthe trend data in MSSQL and live data in OPC UA. The aim of this project is to develop an open source visualization dashboard integrated into a Website based on Node-Red and javascript charting library Highcharts which will have a connection to the Microsoft SQL Database and OPC UA server. The trend data is logged into a SQL Database in the NEST-Cloud, which is accessible for researchers and technicians from all over the world. And the live data will be accessible via OPC UA server. To bring the big data to life it is essential to have attractive visualization charts. Visual representations using graphical structures will help the researchers and practitioners for the development of models and analyses of distributed energy systems.

Node Red is a recent programming tool developed by IBM for wiring together hardware devices, APIs and online services in new and interesting ways. Will be implementing Node-red with libraries- SQL node connection, OPC - UA server, Dashboard UI nodes , http nodes and  javascript charting library Highcharts for creating the visualization dashboard and MS SQL querying for plugging in the data.

---------------------------------------------------------
The Dashboard can be accessed at the local where node-red runs or at http://192.168.223.70:1880/ui/#/0  

<img width="1678" alt="screen shot 2017-08-28 at 5 09 44 am" src="https://user-images.githubusercontent.com/23009481/29770089-eee23464-8bb2-11e7-9661-10ad20d4dc14.png"> 
<img width="1680" alt="screen shot 2017-08-28 at 5 10 18 am" src="https://user-images.githubusercontent.com/23009481/29770090-eee32748-8bb2-11e7-940a-61c32cc31b20.png">
<img width="1680" alt="screen shot 2017-08-28 at 4 10 21 am" src="https://user-images.githubusercontent.com/23009481/29770398-8773a432-8bb4-11e7-971b-e66dbdf7f7d5.png">

-------------------------------------------------------
Pre requisites:  
1. Node-red installed  
2. Connection to Empa NEST MSSQL DB  
Modules in node-red:    
1. Node-red-contrib-mssql  
2. Node-red-contrib-opcua  
3. node-red-dashboard  

-------------------------------------------------------
Work Done:  
Display of Individual Signal Tab  
Display of all the signals involving Weather Station  
Display of selective live OPC UA signals in Live Dashboard  

Work Left :  
Addition of further signals to Individual Signal Tab  
Cumulating signal groups as done in Weather Station  
Adding more signals to Live Dashboard  
 
--------------------------------------------------------

