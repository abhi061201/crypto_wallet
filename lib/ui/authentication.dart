import 'package:crypto_wallet/ui/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../net/flutterfire.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  // it will store the email address provided by the user
  TextEditingController _emailField = TextEditingController();

  // store the password provided by the user
  TextEditingController _passwordfield = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //for email writing

            Container(
              width: MediaQuery.of(context).size.width/1.3,
              child: TextFormField(
                style: TextStyle(color: Colors.white38),
                controller: _emailField,
                decoration: InputDecoration(
                  hintText: "Something@email.com",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 28,
            ),
            // for password writing
            Container(
              width: MediaQuery.of(context).size.width/1.3,
              child: TextFormField(
              style: TextStyle(color: Colors.white38),
              controller: _passwordfield,
              decoration: InputDecoration(
                hintText: "password",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
                labelText: "password",
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              // password will not be visible at insertion
              obscureText: true,
            ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 28,
            ),
            //for register button
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldnavigate =
                      await register(_emailField.text, _passwordfield.text);
                  if (shouldnavigate) {
                    //navigate
                    // if login succesful we will directed to homepage,
                    // homepage contaions all coins data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homeview(),
                      ),
                    );
                  }
                },
                child: Text("Register"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 28,
            ),
            //for logion button
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(
                onPressed: () async {
                  bool shouldnavigate =
                      await signIn(_emailField.text, _passwordfield.text);
                  if (shouldnavigate) {
                    // if login succesful we will directed to homepage,
                    // homepage contain all the coin data

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homeview(),
                      ),
                    );
                  }
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
