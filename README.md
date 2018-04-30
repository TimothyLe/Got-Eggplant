<h1 align="center">
  <strong>Got Eggplant? - Grocery List Application</strong>
</h1>

<div align="center">
    <img src="https://cdn.shopify.com/s/files/1/1061/1924/products/Eggplant_Emoji_large.png?v=1480481031" alt="Eggplant Logo"  width="250" height="250"/>
</div>

<p align="center"><i>An optimized grocery shopping list to reduce the busyness in your life</i>  </p>
<br />  

## CMPE 137: Swift Programming for Mobile Devices

<!---
[comment]: <> (This is a comment)
[//]: <> (This is a comment)
[//]: # (This is a comment) -->
<!---
Comment
-->

### Project Team Members:
Thinh Le, timothyle85@gmail.com
<!--- #010641462 -->
Cherie Sew, cheriemeiyee@gmail.com
<!--- #010108800 -->
David Tran, dtran0419@gmail.com
<!--- #009962771 -->
Timothy Wu, msgtimwu@gmail.com
<!--- #008867170 -->

### Process to build app:

Got Eggplant? uses several SDKs and components, which are the camera, UIKit, FirebaseKit, and MapKit. We require the use of MapKit as users should be able to view grocery stores nearby through a map. FirebaseKit is used to store user’s data, such as their grocery history and account information. UIKit is just the front-end framework/view architecture used for iOS development. Lastly, the camera is used for barcode scanning to retrieve an item's information and store into the grocery list.

The project can be loaded into the latest Xcode version 9.3, select the iPhone 8, and run the app.

### Approach of code:

For the camera, a separate class was created for access. This is so in development, we configure the use of the camera based on what is required by our app, which in this case only the back camera is used for scanning barcodes.

For UIKit, it was just a simple line of code: import UIKit. Testing whether it works is a given as our application has labels, buttons, textfields, etc. that are functional.

For FirebaseKit, we used the code provided on a Get Started manual to test out if we have access. Initially, the connection could not be establish, but the issue was solved after minor tweaks to the database. Once working, the firebase database was coded to work with the user account information, grocery list, and pantry list.

For MapKit, the application tracks the user's location on request through User Location Authorization. Based on that, the user's default location (or current location) should have directions to the 'Black Power Statue' landmark on the SJSU campus as a test. The statue feature a location indicator and bubble text when pressed on to display information about the landmark through the file 'Artwork.swift'.

Reference for Firebase Login:
https://www.appcoda.com/firebase-login-signup/

Reference for Firebase Database:
https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2
