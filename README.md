# Sigma Marketing


## Project setup

### API and SQL Server
1. Clone project
2. Navigate to sigma_marketing_api/SigmaMarketing
3. Execute comand "docker compose up --build"
4. API and SQL Server is ready

### Mobile/Desktop
1. Navigate to sigma_marketing_app/sigma_marketing
2. Execute "flutter pub get" and then "flutter run"
3. Or open with Android Studio and trigger pub get through IDE, and run it on emulator
4. For desktop in Android Studio choose desktop in device selection


## Username and passwords  

### Mobile

    ```
    email: influencer@gmail.com
    password: Test1234*           
    ```

### Desktop

    ```
    email: company@gmail.com
    password: Test1234*   
    ```

## Configuration strings flutter
- baseUrl
- paypalDomain
- paypalClientId
- paypalSecret

- firebaseAndroidApiKey
- firebaseAndroidAppId
- firebaseAndroidMessagingSenderId
- firebaseAndroidProjectId
- firebaseAndroidStorageBucket

## Configuration strings .NET API project
     ```
    "AppSettings": {
    "Key": "jkHFoijklHVLpYICFVlkJKHYvLKHJKVCO",
    "Issuer": "https://localhost:5000",
    "PaypalBaseUrl": "https://api.sandbox.paypal.com",
    "PaypalClientId": "ENTER_CLIENT",
    "PaypalClientSecret": "ENTER_SECRET"
      }
    ```

## Configuration strings .NET Email project
     ```
    "AppSettings": {
    "EmailFrom": "ENTER_EMAIL",
    "SmtpHost": "smtp.gmail.com",
    "SmtpPort": 465,
    "SmtpUser": "ENTER_EMAIL",
    "SmtpPass": "ENTER_PASSWORD"
      } 
    ```
