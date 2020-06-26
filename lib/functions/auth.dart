import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_firebase_auth/easy_firebase_auth.dart';
import 'package:provider/provider.dart';

class MyParentPage extends StatelessWidget {
  MyParentPage({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // You can set your custom strings
    // you can add the privacy of your app with markdown with the necessary links
    AuthStrings authStrings = AuthStrings.english(
        /* Insert privacy policy here.
        privacyMarkdown:
         "Al continuar aceptas la [política de privacidad](https://myPrivacyUrl.com) "
            "y las [condiciones de servicio](https://myTermsUrl.com).");*/
    );

    return AuthManagerWidget(
      onLogin: (){
        print('onLogin()');
      },
      onLogout: (){
        print('onLogout()');
      },
      splashScreen: _MySplashScreen(),

      //introductionScreen: MyIntroductionScreen(),
      loginScreen: _MyLoginScreen(authStrings: authStrings),

      mainScreen: Builder(
        builder: (BuildContext context) {
          AuthState authState = Provider.of(context);

          return Scaffold(
            backgroundColor: Colors.blue,
            body: Center(
              child: RaisedButton(
                onPressed: () {
                  authState.signOut();
                },
                child: Text('Sign out'),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _MySplashScreen() {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: double.infinity - 50),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/nourishlogo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )],
            )],
        )
      )
    );
  }

  Widget _MyLoginScreen({AuthStrings authStrings}) {
    return LoginScreen(
      logInAnonymous: false,
      logInWithEmail: true,
      logInWithGoogle: false,
      logInWithApple: false,
      authStrings: authStrings,
      expandedWidget: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: double.infinity - 50),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nourishlogo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),

      emailLoginBuilder: (BuildContext context){
        return EmailLoginScreen(
          authStrings: authStrings,
          appBar: AppBar(
            title: Text("Login to Nourish Nutrition"),
          ),
          mainColor: Colors.green,
        );
      }
    );
  }
}


/*class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email & password.

  // Register with email & password.
  Future signInEmailPass(String email, String pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
}*/