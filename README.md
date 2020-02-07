# DEVELOPMENT OF CROSS PLATFORM MOBILE APPLICATION FOR CROWD SOURCING IN DISASTER MANAGEMENT

This project , titled , ***“DEVELOPMENT OF CROSS PLATFORM MOBILE APPLICATION FOR CROWD SOURCING IN DISASTER MANAGEMENT”*** , aims to reduce or avoid the potential losses from hazards, assure prompt and appropriate assistance to victims of disaster, and achieve rapid and effective recovery. Communication during disaster time is very crucial for both rescue team and victim. Emergency never comes with prior intimation. The System is intended to function in case of emergencies in society.The emergencies include Fire, Medical Emergencies, accident and External Emergencies (Earthquake, Floods, Storm). The system works on the principles of client-Server system, wherein the server responds to the requests of the Clients. 
The Disaster management cycle illustrates the ongoing process by which governments, businesses, and civil society plan for and reduce the impact of disasters, react during and immediately following a disaster, and take steps to recover after a disaster has occurred. Appropriate actions at all points in the cycle lead to greater preparedness, better warnings, reduced vulnerability or the prevention of disasters during the next iteration of the cycle. There are 4 phases of the **CDM Cycle** :



   <p align='center'>
   <img src="CDM_cycle.jpg" style="width:500px;height:400px;">
   </p>




This project deals with the Response state of the CDM. It includes the actions carried out in a disaster situation with the objective to save life, alleviate suffering and reduce economic losses. The main tool in response is the implementation of plans which were prepared prior to the event. In this project I have developed a mobile app that can be used as an helpline portal for its users. The app is made in the DART language using the Flutter framework. Hence it is compatible with both Android and iOS. In this project I have used Firebase as the backend service. 

## OBJECTIVE

Communications technologies – including social and mobile tools – plays an ever increasing role in emergency response and rescue efforts , as well as overall personal safety. In order to achieve this aim, the objectives have been formulated as follows :

*To develop a cross platform application for providing emergency assistance.
*For Speeding recovery operations.
*Returning systems to normal level.


## TECHNICAL SPECIFICATION

### FLUTTER

Flutter was launched by Google and is an open-source mobile application development SDK.
It is a popular cross-platform app development and is written in the Dart language. It allows the programmer to develop applications for both android and iOS platforms , using a single code base. This software is best suited for the development of the hybrid apps. It makes use of the 2D rendering engine called Skia to develop the visuals. Flutter code is compiled directly into Native arm code , for the respective platform. So for iOS it will compile into Swift code and similarly , for android , it compiles to Java or Kotlin arm code. Now since this code conversion takes place during runtime , the application thus produced is no different from a native mobile application. 

### Structure of a flutter project

A flutter project contains all the folders shown in Table :

<table>
   <thead>
      <tr>
         <th>S.No</th>
         <th>Folder Name</th>
         <th>Description</th>
      </tr>
   </thead>
   <tbody>
      <tr>
         <td>1</td>
         <td>Android Folder</td>
         <td>Contains all the android related code and files in this project.</td>
      </tr>
      <tr>
         <td>2</td>
         <td>iOS Folder</td>
         <td>Contains all the iOS related code and files in this project.</td>
      </tr>
      <tr>
         <td>3</td>
         <td>Lib Folder</td>
         <td>It is the main folder where we have to write all of our application code. The default project template               currently only contains the main.dart file here which is kind of like an entry point for our flutter application.</td>
      </tr>
      <tr>
         <td>4</td>
         <td>Test Folder</td>
         <td>This folder is used to store and manage the testing code for the application.</td>
      </tr>
      <tr>
         <td>5</td>
         <td>.gitignore</td>
         <td>file is a hidden file that an IDE uses to store the list of files which need to be ignored when a source code is uploaded into any git versioning system like for eg GitHub.</td>
      </tr>
      <tr>
         <td>6</td>
         <td>.metadata</td>
         <td>file is also a hidden file which is used by IDEs to track the properties of a particular flutter project in question.</td>
      </tr>
      <tr>
         <td>7</td>
         <td>.packages</td>
         <td>file is one of the package managers which manage third party or reusable controls inside the IDE.</td>
      </tr>
      <tr>
         <td>8</td>
         <td>‘projectname’.iml</td>
         <td>file is an xml file which is used by the editor engine to get the configuration of java module which is used by this project.</td>
      </tr>
      <tr>
         <td>9</td>
         <td>pubspec.lock</td>
         <td>is used by pub package manager in order to get the concrete versions of every immediate and transitive dependency that a package relies on.</td>
      </tr>
      <tr>
         <td>10</td>
         <td>pubspec.yaml</td>
         <td>is the only file in all these files in which we have to make changes when we have to use any third party packages. This file is used by pub package manager again to get and load the packages that are used in the project which can also include include third party packages.</td>
      </tr>
      <tr>
         <td>11</td>
         <td>README.md</td>
         <td>is an optional file which can contain any information that you would want to mention about the project.</td>
      </tr>
   </tbody>
</table>
       



