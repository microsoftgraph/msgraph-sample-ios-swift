---
page_type: sample
description: This sample demonstrates how to use the Microsoft Graph Objective-C SDK to access data in Office 365 from iOS Swift apps.
products:
- ms-graph
- microsoft-graph-calendar-api
- office-exchange-online
languages:
- java
---

# Microsoft Graph sample iOS Swift app

This sample demonstrates how to use the Microsoft Graph Objective-C SDK with Swift to access data in Office 365 from native mobile iOS applications.

> **NOTE:** This sample was originally built from a tutorial published on the [Microsoft Graph tutorials](https://docs.microsoft.com/graph/tutorials) page. That tutorial has been removed.

## Prerequisites

To run the completed project in this folder, you need the following:

- [Xcode](https://developer.apple.com/xcode/) installed on your development machine.
- Either a personal Microsoft account with a mailbox on Outlook.com, or a Microsoft work or school account.

If you don't have a Microsoft account, there are a couple of options to get a free account:

- You can [sign up for a new personal Microsoft account](https://signup.live.com/signup?wa=wsignin1.0&rpsnv=12&ct=1454618383&rver=6.4.6456.0&wp=MBI_SSL_SHARED&wreply=https://mail.live.com/default.aspx&id=64855&cbcxt=mai&bk=1454618383&uiflavor=web&uaid=b213a65b4fdc484382b6622b3ecaa547&mkt=E-US&lc=1033&lic=1).
- You can [sign up for the Microsoft 365 Developer Program](https://developer.microsoft.com/microsoft-365/dev-program) to get a free Office 365 subscription.

## Register a web application with the Azure Active Directory admin center

1. Open a browser and navigate to the [Azure Active Directory admin center](https://aad.portal.azure.com) and login using a **personal account** (aka: Microsoft Account) or **Work or School Account**.

1. Select **Azure Active Directory** in the left-hand navigation, then select **App registrations** under **Manage**.

1. Select **New registration**. On the **Register an application** page, set the values as follows.

    - Set **Name** to `iOS Swift Graph Sample`.
    - Set **Supported account types** to **Accounts in any organizational directory and personal Microsoft accounts**.
    - Leave **Redirect URI** empty.

1. Select **Register**. On the **iOS Swift Graph Sample** page, copy the value of the **Application (client) ID** and save it, you will need it in the next step.

1. Select **Authentication** under **Manage**. Select **Add a platform**, then **iOS / macOS**.

1. Enter `com.contoso.GraphTutorial` in **Bundle ID** and select **Configure**, then select **Done**.

## Configure the sample

1. Rename the `AuthSettings.plist.example` file to `AuthSettings.plist`.
1. Edit the `AuthSettings.plist` file and make the following changes.
    1. Replace `YOUR_APP_ID_HERE` with the **Application (client) ID** you got from the App Registration Portal.
1. Open Terminal in the **GraphTutorial** directory and run the following command.

    ```Shell
    pod install
    ```

## Run the sample

In Xcode, select the **Product** menu, then select **Run**.

## Code of conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Disclaimer

**THIS CODE IS PROVIDED _AS IS_ WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.**
