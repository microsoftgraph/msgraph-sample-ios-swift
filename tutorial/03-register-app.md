<!-- markdownlint-disable MD002 MD041 -->

In this exercise you will create a new Azure AD native application using the Azure Active Directory admin center.

1. Open a browser and navigate to the [Azure Active Directory admin center](https://aad.portal.azure.com) and login using a **personal account** (aka: Microsoft Account) or **Work or School Account**.

1. Select **Azure Active Directory** in the left-hand navigation, then select **App registrations** under **Manage**.

    ![A screenshot of the App registrations ](./images/aad-portal-app-registrations.png)

1. Select **New registration**. On the **Register an application** page, set the values as follows.

    - Set **Name** to `iOS Swift Graph Tutorial`.
    - Set **Supported account types** to **Accounts in any organizational directory and personal Microsoft accounts**.
    - Leave **Redirect URI** empty.

    ![A screenshot of the Register an application page](./images/aad-register-an-app.png)

1. Select **Register**. On the **iOS Swift Graph Tutorial** page, copy the value of the **Application (client) ID** and save it, you will need it in the next step.

    ![A screenshot of the application ID of the new app registration](./images/aad-application-id.png)

1. Select **Authentication** under **Manage**. Select **Add a platform**, then **iOS / macOS**.

1. Enter your app's Bundle ID and select **Configure**, then select **Done**.
