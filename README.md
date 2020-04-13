# ai_workout

## Clean 
```flutter clean``` 

## Xcode setup for Analytics Debugging
1. In Xcode, select Product > Scheme > Edit scheme...
2. Select Run from the left menu.
3. Select the Arguments tab.
4. In the Arguments Passed On Launch section, add -FIRAnalyticsDebugEnabled.
5. Run the app in XCode 
6. See your debug event in firebase DebugView

## Compiling 
```
open -a Simulator
flutter run
``` 

## Force Pull 
```
git fetch origin branch_name
git reset --hard origin/branch_name
```


## Resources  
[https://firebase.google.com/docs/flutter/setup?platform=ios](https://firebase.google.com/docs/flutter/setup?platform=ios)

[https://console.firebase.google.com/u/1/project/ai-workout-4be10/overview](https://console.firebase.google.com/u/1/project/ai-workout-4be10/overview)

Firebase Plugins: [https://firebase.google.com/docs/ios/setup#available-pods](https://firebase.google.com/docs/ios/setup#available-pods)

Vaidate with debugview: [https://support.google.com/firebase/answer/7201382?hl=en&utm_id=ad&authuser=1](https://support.google.com/firebase/answer/7201382?hl=en&utm_id=ad&authuser=1)

Analytics: [https://medium.com/flutterpub/using-firebase-analytics-in-flutter-2da5be205e4](https://medium.com/flutterpub/using-firebase-analytics-in-flutter-2da5be205e4)
