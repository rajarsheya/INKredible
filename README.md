[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-c66648af7eb3fe8bc4f294546bfd86ef473780cde1dea487d3c4ff354943c9ae.svg)](https://classroom.github.com/online_ide?assignment_repo_id=8937628&assignment_repo_type=AssignmentRepo)
Hint: [Markup Guide](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

# INKredible
*Project Members : Arsheya Raj, Sunjil Gahatraj*

*Version # : 2.0.0*

## Summary of Project
*Our application will allow user to create professional documents from handwritten notes or tables in seconds. User will scan notes, and application will generate a PDF/Word document or markdown file, which can be downloaded, saved, and emailed. It will be very useful for someone who wants professional document on the go or does not have access to workstation all the time. On average, it will save about 12.5 minutes per page compared to typing same thing on computer. Also, writing digitally is 25% slower, hence users can have the text written by hand and then scan them to save time.*

## Project Analysis
### Target Audience
*INKredible will be very useful for someone who wants professional document on the go or does not have access to workstation all the time. We will be able to reach these users, as they just have to download it from the App Store. INKredible will also provide persons who are blind or visually impaired with the capacity to scan handwritten text and then have it saved to a computer file and then they can hear the file as synthetic speech. Our app will be very useful for people in the insurance sector. As, Data extraction can be particularly challenging in the insurance sector, given the varying document layouts and formats for quotes, insurance forms, claims, and receipts. Using our app, they can scan the data with less amount of time. Our app will also be useful for business operations and workflows which work alot with handwritten texts/receipts.*

### Primary Purpose
*INKredible will allow users to extract the handwritten data and then use them in very less amount of time. Users can have their data in digital format so that it is safe and will last longer.*

### Value Proposition
The problems which we are solving with our app are as follows :
 - People don't tend to carry their workstation everywhere. They can scan their documents and use them anywhere.
 -  It is said that writing digitally is 25% slower than writing with hands. So, people can have their handwritten texts and then they can scan them in seconds. Hence, Digitisation will be easier. It will help to keep the data safe and also have more storage.
 - As it takes 12.5 minutes to write on page of word doc on average, and our app will do it in seconds. Hence, our app will be saving time of people.
 - Automate document routing and content processing. For future scope, businesses can provide improved services by ensuring that employees have the most up-to-date, accurate information when they need it.
### Success Criteria
Translation without error: Handwriting and doodle varies based on persons and handwriting patterns. We would like to achieve 95% or higher accuracy on translation to consider a translation successful.

Number of application downloads: As application is designed to be self-contained application without login requirement, we will be relying on number of downloads to estimate success of our application. For marketing, we will rely on recommendations from user and expect number to grow gradually.

Number of successful executions: We will provide user option to report crash and 99.9% or higher successful execution will be marked as success. Also, we will log Google’s API response to track over success/failure transaction.

### Competitor Analysis
*The competitor for our app can be LINKSQUARES. The strength which our comeptitor has are that they will be using AI-Powered CLM(Contract Lifecycle Management) and hence their translation correctness percentage will be higher. Also, our competitors are maily focused on companies and legal firms, hence they can reach more people in less amout of time. Due to our monetization model, we will rely on donations, hence, our growth will be gradual. The weakness which our competitor has that they mainly focus in-house legal teams and lawyers. They generally use their solution to scan the handwrittne documents which are legal, however, our app will be able to scan any type of handwritten documents and hence regular users can use our app in their day-to-day lives.*

### Monetization Model
*One of the appealing features of our application will be clean UI and low barriers to entry by eliminating login requirements which means we will not be able to harvest user’s personal data and run targeted ad, therefore we have decided to rely on donation as the source of revenue.*
### Initial Design
Below are the MVP identified for our application:
-	Ask permissions to access camera and storage and store response 
-	Open scan window if camera and storage access are granted 
-	Display pop-up message asking for permission, if camera and storage access are denied 
-	Scan button to take picture of document
-	Ask user to select file format
-	View window to check result
-	Download button to download document

### UI/UX Design
*There are three essential elements of our app INKredible —scanning & recognition, generating the desired output file, donations.
First page of the application contains donation button and scan button to initiate two different flows. Scan button will initiate scan functionality by opening camera and allowing user to take a picture of item they want to translate. Second page contains, camera view and capture button. Third page contains, image preview and crop function. Fourth page contains preview of cropped image and "Save" option to use that picture for translation. Fifth page contains, list of scanned documents and allow user to select one from the list. Seventh page contains preview of translation and download button. Eight page contains, option to select file type and button to finish download. 

For Payment flow, user will select "Donate" button located at the homepage. Next page contains, textarea to fill out payment amount, followed by payment detail page to fill out bank/account details.

### Technical Architecture
-	Camera will be used to scan document
-	Available internal storage will be used to store downloaded document
-	Main memory (RAM) will be used to store session data like type of document user wants to download, and temporary storage for document until it is downloaded and stored in internal storage
-	Handwriting detection with Optical Character Recognition (OCR) will be our main processing engine. We will log API response type and keep count to measure success/failure. This can also be used to track overall application traffic
-	Minimal amount of meta-data will be stored in Apple OCR kit servers. This will not contains any PII
-	File type data storage to store document
-	PayPal/Apple Pay API will be used to get donation from users

### Limitation 
-	Application will only run on physical device. It will not run simulator due to camera dependency
-   MD file download option is currently unavailable
-   In current version of the application, user need to enter index of the document they are trying to download. This will be replaced with 
    drop down in next version
-   Payment gateway is currently unavailable due to complication on getting credentials from Apple Pay and Paypal
