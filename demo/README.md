# How to run the completed project

## Prerequisites

To run the completed project in this folder, you need the following:

- [Xcode](https://developer.apple.com/xcode/)
- [CocoaPods](https://cocoapods.org)
- Either a personal Microsoft account with a mailbox on Outlook.com, or a Microsoft work or school account.

> **Note:** This tutorial was written using Xcode version 11.4 and CocoaPods version 1.9.1. The steps in this guide may work with other versions, but that has not been tested.

If you don't have a Microsoft account, there are a couple of options to get a free account:

- You can [sign up for a new personal Microsoft account](https://signup.live.com/signup?wa=wsignin1.0&rpsnv=12&ct=1454618383&rver=6.4.6456.0&wp=MBI_SSL_SHARED&wreply=https://mail.live.com/default.aspx&id=64855&cbcxt=mai&bk=1454618383&uiflavor=web&uaid=b213a65b4fdc484382b6622b3ecaa547&mkt=E-US&lc=1033&lic=1).
- You can [sign up for the Office 365 Developer Program](https://developer.microsoft.com/office/dev-program) to get a free Office 365 subscription.

## Register a web application with the Azure Active Directory admin center

1. Open a browser and navigate to the [Azure Active Directory admin center](https://aad.portal.azure.com). Login using a **personal account** (aka: Microsoft Account) or **Work or School Account**.

1. Select **Azure Active Directory** in the left-hand navigation, then select **App registrations** under **Manage**.

    ![A screenshot of the App registrations ](/tutorial/images/aad-portal-app-registrations.png)

1. Select **New registration**. On the **Register an application** page, set the values as follows.

    - Set **Name** to `iOS Swift Graph Tutorial`.
    - Set **Supported account types** to **Accounts in any organizational directory and personal Microsoft accounts**.
    - Leave **Redirect URI** empty.

    ![A screenshot of the Register an application page](/tutorial/images/aad-register-an-app.png)

1. Choose **Register**. On the **iOS Swift Graph Tutorial** page, copy the value of the **Application (client) ID** and save it, you will need it in the next step.

    ![A screenshot of the application ID of the new app registration](/tutorial/images/aad-application-id.png)

1. Select **Authentication** under **Manage**. Select **Add a platform**, then **iOS / macOS**.

1. Enter your app's Bundle ID and select **Configure**, then select **Done**.

## Configure the sample

1. Rename the `AuthSettings.plist.example` file to `AuthSettings.plist`.
1. Edit the `AuthSettings.plist` file and make the following changes.
    1. Replace `YOUR_APP_ID_HERE` with the **Application Id** you got from the App Registration Portal.
1. Open Terminal in the **GraphTutorial** directory and run the following command.

    ```Shell
    pod install
    ```

## Run the sample

In Xcode, select the **Product** menu, then select **Run**.
