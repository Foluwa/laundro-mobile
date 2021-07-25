import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/form_validator.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: Column(
        children: [
          const Center(
            child: Text('SignUp'),
          )
        ],
      ),
    );
  }

  Widget formInput({label, controller, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          // validator: label == 'Email Address'
          //     ? FormValidate.validateEmail
          //     : FormValidate.validatePassword,
          obscureText: obscureText
              ? (obscureText ? _passwordVisible : !_passwordVisible)
              : false,
          controller: controller,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              suffixIcon: obscureText
                  ? IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Constants.primaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )
                  : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              // enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.grey[400])),
              // border: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.grey[400])),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
        ),
      ],
    );
  }
}
