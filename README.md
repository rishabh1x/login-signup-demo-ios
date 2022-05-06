# login-signup-demo-ios
A demo of login & signup flow made as a part of assignment for recruitment.

=================================================================================

Deployment Instructions -

The code works on xcode 13(or newer). Not tested on other versions. The dependencies are already included in the git repo to avoid version related conflicts. In case of any error please run the 'pod install' command and then open .xcworkspace file from the project directory.

=================================================================================

General Overview - 

- The code follows Uncle Bob's Clean Architecture and strictly follows the VIP cycle. The separation of concerns is as follows:
    - View(ViewControllers) - Manager UI related logic such as user actions, showing proper messages to user etc.
    - Interactor - Triggered from the View with a request parameter when required that describes what action was taken in the view by user(i.e - click of submit button)
        - Worker(s) - An interactor can delegate its work to workers it owns based on the complexity of the work needed to be done. The interactor and workers have a 1-to-many relationship i.e an interactor can have a worker to call an api, fetch/insert any data into database etc. Worker classes are an optional component mainly utilised to avoid the common problem of massive class in this case, massive interactors.
    - Model - As is in most architectures, model are the representation of data objects that your application relies on. In VIP these include Request-Response models used by interactors and presenters as well as any REST API level models such as your typical Codable structs.
    - Presenter - It is responsible for taking the necessary information that is required by the view to reflect the output of the action that was triggered by the user. Presenter is responsible for taking the response from interactor to the view object.
    - Router - An optional component that is responsible for navigation logic where a view might need to present another view or move to a different screen. Routers are also responsible for passing data between classes as the transition takes place.

- The code is distributed in "Scene"s that act as a singular single-purpose module for achieving a specific purpose such as logging in the user using the email or verifying the user with the specified 2fa code or simply displaying a certain amount of information on the screen.
- Every 'scene' has the above mentioned components like views, interactor, presenter and routers. 
- The working of the internal code should be quite self explanatory due to the straight forward naming conventions used in each file be it the variables or the protocols or methods.

=================================================================================

The App's Logical Flow -

- The first screen asks for an email address. On SUBMIT, the email address is sent to the /email api endpoint which simply gives you a 'token' and a flag isLogin.
- The isLogin flag determines if the user account is already registered on the platform or not.
- The token and the 'code' input received from the second screen is then sent to the /verify endpoint which gives a response that tells if the OTP is invalid or successful.
- When an invalid otp is found the app gives a login error.
- When a valid otp is entered, the app has two checks to perform - if isLogin is true, that means a user has logged in. If the isLogin is false that mean a new user has just signed up in the app.
- The third screen has a bunch of image and label components that change depending upon the logic referred in the previous point - 'login error', 'sign-up' or 'login'
- In case of login error, the same is reflected in a label in red color. In case of 'sign-up' the same is reflected via the label text saying 'Signup Successful!'. Whereas in case of an existing user login, the response object contains their details such as first and last name which is displayed with a 'welcome' message.

=================================================================================

Credits - 

Raymond Law @ https://clean-swift.com/

vectorjuice @ https://www.freepik.com/vectorjuice

Clean Architecture - https://cleancoders.com/

Google Material Components - https://github.com/material-components/material-components-ios

IQ Keyboard Manager - https://github.com/hackiftekhar/IQKeyboardManager

[https://github.com/rishabh1x]
