// The import of packages and files required for the authentication screen, including flutter/material.dart for Flutter widgets, flutter/services.dart for platform services, local_auth.dart for local authentication functionalities, and the home.dart file, which likely contains the Home screen implementation.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'home.dart';

//Defines a stateful widget AuthScreen that will be used for the authentication screen. It extends StatefulWidget and provides an implementation for creating the state object _AuthScreenState.
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

//Defines the state class _AuthScreenState, which manages the state of the AuthScreen widget. It initializes a LocalAuthentication instance for handling biometric authentication, declares a SupportState variable to track the support status of biometric authentication, and initializes a list of available biometric types.
class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportState = SupportState.unknown;
  List<BiometricType>? availableBiometrics;

  //Overrides the initState() method to perform initialization tasks when the widget is first created. It checks whether the device supports biometric authentication and retrieves available biometric types.
  @override
  void initState() {
    auth.isDeviceSupported().then((bool isSupported) =>
        setState(() => supportState = isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
  }

  //Defines a method checkBiometric() to check if biometric authentication is supported on the device. It uses the canCheckBiometrics method provided by the LocalAuthentication package and handles any platform exceptions that may occur.
  Future<void> checkBiometric() async {
    late bool canCheckBiometric;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
      print("Biometric supported: $canCheckBiometric");
    } on PlatformException catch (e) {
      print(e);
      canCheckBiometric = false;
    }
  }

  //Defines a method getAvailableBiometrics() to retrieve the available biometric types supported by the device. It uses the getAvailableBiometrics method provided by the LocalAuthentication package and updates the state with the retrieved biometric types.
  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometricTypes;
    try {
      biometricTypes = await auth.getAvailableBiometrics();
      print("supported biometrics $biometricTypes");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      // Filter out facial recognition if available
      availableBiometrics = biometricTypes.where((type) => type != BiometricType.face).toList();
    });
  }

  //Defines a method authenticateWithBiometrics() to initiate the biometric authentication process. It prompts the user to authenticate with either fingerprint or Face ID and navigates to the home screen if authentication is successful.

  Future<void> authenticateWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: 'Authenticate with fingerprint',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));

      if (!mounted) {
        return;
      }

      if (authenticated) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
  }
 //Overrides the build() method to construct the UI of the authentication screen. It displays information about the biometric authentication support status, available biometric types, and provides a button to initiate biometric authentication. The UI dynamically adjusts based on the support state and available biometric types.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              supportState == SupportState.supported
                  ? 'Biometric authentication is supported on this device'
                  : supportState == SupportState.unSupported
                  ? 'Biometric authentication is not supported on this device'
                  : 'Checking biometric support...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: supportState == SupportState.supported
                    ? Colors.green
                    : supportState == SupportState.unSupported
                    ? Colors.red
                    : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fingerprint,
                  size: 40,
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: authenticateWithBiometrics,
                  child: const Text("Authenticate with Fingerprint"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

//Defines an enumeration SupportState with three possible states: unknown, supported, and unSupported. This enum is likely used to represent the state of biometric support on the device.
enum SupportState {
  unknown,
  supported,
  unSupported,
}
