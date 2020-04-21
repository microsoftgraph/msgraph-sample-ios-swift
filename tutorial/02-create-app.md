<!-- markdownlint-disable MD002 MD041 -->

Begin by creating a new Swift project.

1. Open Xcode. On the **File** menu, select **New**, then **Project**.
1. Choose the **Single View App** template and select **Next**.

    ![A screenshot of the Xcode template selection dialog](./images/xcode-select-template.png)

1. Set the **Product Name** to `GraphTutorial` and the **Language** to **Swift**.
1. Fill in the remaining fields and select **Next**.
1. Choose a location for the project and select **Create**.

## Install dependencies

Before moving on, install some additional dependencies that you will use later.

- [Microsoft Authentication Library (MSAL) for iOS](https://github.com/AzureAD/microsoft-authentication-library-for-objc) for authenticating to with Azure AD.
- [Microsoft Graph SDK for Objective C](https://github.com/microsoftgraph/msgraph-sdk-objc) for making calls to Microsoft Graph.
- [Microsoft Graph Models SDK for Objective C](https://github.com/microsoftgraph/msgraph-sdk-objc-models) for strongly-typed objects representing Microsoft Graph resources like users or events.

1. Quit Xcode.
1. Open Terminal and change the directory to the location of your **GraphTutorial** project.
1. Run the following command to create a Podfile.

    ```Shell
    pod init
    ```

1. Open the Podfile and add the following lines just after the `use_frameworks!` line.

    ```Ruby
    pod 'MSAL', '~> 1.1.1'
    pod 'MSGraphClientSDK', ' ~> 1.0.0'
    pod 'MSGraphClientModels', '~> 1.3.0'
    ```

1. Save the Podfile, then run the following command to install the dependencies.

    ```Shell
    pod install
    ```

1. Once the command completes, open the newly created **GraphTutorial.xcworkspace** in Xcode.

## Design the app

In this section you will create the views for the app: a sign in page, a tab bar navigator, a welcome page, and a calendar page. You'll also create an activity indicator overlay.

### Create sign in page

1. Expand the **GraphTutorial** folder in Xcode, then select **ViewController.swift**.
1. In the **File Inspector**, change the **Name** of the file to `SignInViewController.swift`.

    ![A screenshot of the File Inspector](./images/rename-file.png)

1. Open **SignInViewController.swift** and replace its contents with the following code.

    ```Swift
    import UIKit

    class SignInViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }

        @IBAction func signIn() {
            self.performSegue(withIdentifier: "userSignedIn", sender: nil)
        }
    }
    ```

1. Open the **Main.storyboard** file.
1. Expand **View Controller Scene**, then select **View Controller**.

    ![A screenshot of Xcode with the View Controller selected](./images/storyboard-select-view-controller.png)

1. Select the **Identity Inspector**, then change the **Class** dropdown to **SignInViewController**.

    ![A screenshot of the Identity Inspector](./images/change-class.png)

1. Select the **Library**, then drag a **Button** onto the **Sign In View Controller**.

    ![A screenshot of the Library in Xcode](./images/add-button-to-view.png)

1. With the button selected, select the **Attributes Inspector** and change the **Title** of the button to `Sign In`.

    ![A screenshot of the Title field in the Attributes Inspector in Xcode](./images/set-button-title.png)

1. With the button selected, select the **Align** button at the bottom of the storyboard. Select both the **Horizontally in container** and **Vertically in container** constraints, leave their values as 0, then select **Add 2 constraints**.

    ![A screenshot of the alignment constraints settings in Xcode](./images/add-alignment-constraints.png)

1. Select the **Sign In View Controller**, then select the **Connections Inspector**.
1. Under **Received Actions**, drag the unfilled circle next to **signIn** onto the button. Select **Touch Up Inside** on the pop-up menu.

    ![A screenshot of dragging the signIn action to the button in Xcode](./images/connect-sign-in-button.png)

### Create tab bar

1. Select the **Library**, then drag a **Tab Bar Controller** onto the storyboard.
1. Select the **Sign In View Controller**, then select the **Connections Inspector**.
1. Under **Triggered Segues**, drag the unfilled circle next to **manual** onto the **Tab Bar Controller** on the storyboard. Select **Present Modally** in the pop-up menu.

    ![A screenshot of dragging a manual segue to the new Tab Bar Controller in Xcode](./images/add-segue.png)

1. Select the segue you just added, then select the **Attributes Inspector**. Set the **Identifier** field to `userSignedIn`, and set **Presentation** to **Full Screen**.

    ![A screenshot of the Identifier field in the Attributes Inspector in Xcode](./images/set-segue-identifier.png)

1. Select the **Item 1 Scene**, then select the **Connections Inspector**.
1. Under **Triggered Segues**, drag the unfilled circle next to **manual** onto the **Sign In View Controller** on the storyboard. Select **Present Modally** in the pop-up menu.
1. Select the segue you just added, then select the **Attributes Inspector**. Set the **Identifier** field to `userSignedOut`, and set **Presentation** to **Full Screen**.

### Create welcome page

1. Select the **Assets.xcassets** file.
1. On the **Editor** menu, select **Add Assets**, then **New Image Set**.
1. Select the new **Image** asset and use the **Attribute Inspector** to set its **Name** to `DefaultUserPhoto`.
1. Add any image you like to serve as a default user profile photo.

    ![A screenshot of the Image Set asset view in Xcode](./images/add-default-user-photo.png)

1. Create a new **Cocoa Touch Class** file in the **GraphTutorial** folder named `WelcomeViewController`. Choose **UIViewController** in the **Subclass of** field.
1. Open **WelcomeViewController.swift** and replace its contents with the following code.

    ```Swift
    import UIKit

    class WelcomeViewController: UIViewController {

        @IBOutlet var userProfilePhoto: UIImageView!
        @IBOutlet var userDisplayName: UILabel!
        @IBOutlet var userEmail: UILabel!

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.

            // TEMPORARY
            self.userProfilePhoto.image = UIImage(imageLiteralResourceName: "DefaultUserPhoto")
            self.userDisplayName.text = "Default User"
            self.userEmail.text = "default@contoso.com"
        }

        @IBAction func signOut() {
            self.performSegue(withIdentifier: "userSignedOut", sender: nil)
        }
    }
    ```

1. Open **Main.storyboard**. Select the **Item 1 Scene**, then select the **Identity Inspector**. Change the **Class** value to **WelcomeViewController**.
1. Using the **Library**, add the following items to the **Item 1 Scene**.

    - One **Image View**
    - Two **Labels**
    - One **Button**
1. Using the **Connections Inspector**, make the following connections.

    - Link the **userDisplayName** outlet to the first label.
    - Link the **userEmail** outlet to the second label.
    - Link the **userProfilePhoto** outlet to the image view.
    - Link the **signOut** received action to the button's **Touch Up Inside**.

1. Select the image view, then select the **Size Inspector**.
1. Set the **Width** and **Height** to 196.
1. Use the **Align** button to add the **Horizontally in container** constraint with a value of 0.
1. Use the **Add New Constraints** button (next to the **Align** button) to add the following constraints:

    - Align Top to: Safe Area, value: 0
    - Bottom Space to: User Display Name, value: Standard
    - Height, value: 196
    - Width, value: 196

    ![A screenshot of the new constraints settings in Xcode](./images/add-new-constraints.png)

1. Select the first label, then use the **Align** button to add the **Horizontally in container** constraint with a value of 0.
1. Use the **Add New Constraints** button to add the following constraints:

    - Top Space to: User Profile Photo, value: Standard
    - Bottom Space to: User Email, value: Standard

1. Select the second label, then select the **Attributes Inspector**.
1. Change the **Color** to **Dark Gray Color**, and change the **Font** to **System 12.0**.
1. Use the **Align** button to add the **Horizontally in container** constraint with a value of 0.
1. Use the **Add New Constraints** button to add the following constraints:

    - Top Space to: User Display Name, value: Standard
    - Bottom Space to: Sign Out, value: 14

1. Select the button, then select the **Attributes Inspector**.
1. Change the **Title** to `Sign Out`.
1. Use the **Align** button to add the **Horizontally in container** constraint with a value of 0.
1. Use the **Add New Constraints** button to add the following constraints:

    - Top Space to: User Email, value: 14

1. Select the tab bar item at the bottom of the scene, then select the **Attributes Inspector**. Change the **Title** to `Me`.

The welcome scene should look similar to this once you're done.

![A screenshot of the Welcome scene layout](./images/welcome-scene-layout.png)

### Create calendar page

1. Create a new **Cocoa Touch Class** file in the **GraphTutorial** folder named `CalendarViewController`. Choose **UIViewController** in the **Subclass of** field.
1. Open **CalendarViewController.swift** and replace its contents with the following code.

    ```Swift
    import UIKit

    class CalendarViewController: UIViewController {

        @IBOutlet var calendarJSON: UITextView!

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.

            // TEMPORARY
            calendarJSON.text = "Calendar"
            calendarJSON.sizeToFit()
        }
    }
    ```

1. Open **Main.storyboard**. Select the **Item 2 Scene**, then select the **Identity Inspector**. Change the **Class** value to **CalendarViewController**.
1. Using the **Library**, add a **Text View** to the **Item 2 Scene**.
1. Select the text view you just added. On the **Editor** menu, choose **Embed In**, then **Scroll View**.
1. Using the **Connections Inspector**, connect the **calendarJSON** outlet to the text view.
1. Select the tab bar item at the bottom of the scene, then select the **Attributes Inspector**. Change the **Title** to `Calendar`.
1. On the **Editor** menu, select **Resolve Auto Layout Issues**, then select **Add Missing Constraints** underneath **All Views in Welcome View Controller**.

The calendar scene should look similar to this once you're done.

![A screenshot of the Calendar scene layout](./images/calendar-scene-layout.png)

### Create activity indicator

1. Create a new **Cocoa Touch Class** file in the **GraphTutorial** folder named `SpinnerViewController`. Choose **UIViewController** in the **Subclass of** field.
1. Open **SpinnerViewController.swift** and replace its contents with the following code.

    :::code language="swift" source="../demo/GraphTutorial/GraphTutorial/SpinnerViewController.swift" id="SpinnerSnippet":::

## Test the app

Save your changes and launch the app. You should be able to move between the screens using the **Sign In** and **Sign Out** buttons and the tab bar.

![Screenshots of the application](./images/app-screens.png)
