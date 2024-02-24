# Sample Flutter Application

This is a sample application to demonstrate how to integrate the Sentiance SDK in a Flutter mobile application.

![](assets/screenshots/home.png?1) &nbsp; ![](assets/screenshots/dashboard.png?1)

## What's in this?

In this sample application we cover the SDK Integration (and SDK user creation) - with [user linking](https://docs.sentiance.com/important-topics/user-linking-2.0)

There are three places you need to look at

1. `SentianceHelper.shared.initialize` in the `AppDelegate.m`. // iOS native initialization
2. `initializeSentianceSDK` in the `MainApplication.kt`. // Android native initialization
3. `_onCreateUserClick` in the `lib/src/screens/setup_screen.dart`. // sentiance user creation

## To run this project:

1. Request a developer account by [contacting Sentiance](mailto:support@sentiance.com).
2. Setup your backend to provide authentication code to Application. See: [**sample api server**](https://github.com/sentiance/sample-apps-api)
3. Run this Flutter application using the environment you prefer.

## More info

* [Full documentation on the Sentiance SDK](https://docs.sentiance.com/)