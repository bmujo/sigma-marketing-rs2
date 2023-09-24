abstract class AppConstants {
  // Default base URL
  //static const defaultBaseUrl = "http://localhost:5000/";

  static const defaultBaseUrl = "https://10.0.2.2:5000/";

  // Suffixes
  static const String suffix = "api/";
  static const String chatSuffix = "chat";
  static const String notificationSuffix = "notifications";

  // URLs
  static const String baseUrl = String.fromEnvironment(
        'baseUrl',
        defaultValue: defaultBaseUrl,
      ) +
      suffix;

  static const String chatUrl = String.fromEnvironment(
        'baseUrl',
        defaultValue: defaultBaseUrl,
      ) +
      chatSuffix;

  static const String notificationUrl = String.fromEnvironment(
        'baseUrl',
        defaultValue: defaultBaseUrl,
      ) +
      notificationSuffix;

  // Paypal
  static const defaultPaypalDomain = "https://api.sandbox.paypal.com";

  //static const defaultPaypalDomainProd = "https://api.paypal.com";

  static const defaultClientId = "";
  static const defaultSecret = "";

  static const String paypalDomain = String.fromEnvironment(
    'paypalDomain',
    defaultValue: defaultPaypalDomain,
  );

  static const String paypalClientId = String.fromEnvironment(
    'paypalClientId',
    defaultValue: defaultClientId,
  );

  static const String paypalSecret = String.fromEnvironment(
    'paypalSecret',
    defaultValue: defaultSecret,
  );

  // Firebase Android
  static const String firebaseDefaultAndroidApiKey = "";
  static const String firebaseDefaultAndroidAppId = "";
  static const String firebaseDefaultAndroidMessagingSenderId = "";
  static const String firebaseDefaultAndroidProjectId = "";
  static const String firebaseDefaultAndroidStorageBucket = "";

  static const String firebaseAndroidApiKey = String.fromEnvironment(
    'firebaseAndroidApiKey',
    defaultValue: firebaseDefaultAndroidApiKey,
  );

  static const String firebaseAndroidAppId = String.fromEnvironment(
    'firebaseAndroidAppId',
    defaultValue: firebaseDefaultAndroidAppId,
  );

  static const String firebaseAndroidMessagingSenderId = String.fromEnvironment(
    'firebaseAndroidMessagingSenderId',
    defaultValue: firebaseDefaultAndroidMessagingSenderId,
  );

  static const String firebaseAndroidProjectId = String.fromEnvironment(
    'firebaseAndroidProjectId',
    defaultValue: firebaseDefaultAndroidProjectId,
  );

  static const String firebaseAndroidStorageBucket = String.fromEnvironment(
    'firebaseAndroidStorageBucket',
    defaultValue: firebaseDefaultAndroidStorageBucket,
  );
}
