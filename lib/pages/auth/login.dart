import 'package:deliveryplus/components/SWbutton.dart';
import 'package:deliveryplus/components/inputText.dart';
import 'package:deliveryplus/helpers/commom/customLoader.dart';
import 'package:deliveryplus/helpers/commom/flushBar.dart';
import 'package:deliveryplus/helpers/commom/route_constants.dart';
import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:deliveryplus/models/authModel.dart';
import 'package:deliveryplus/services/appState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final CustomFlushBar customFlushBar = CustomFlushBar();
  bool obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthModel authModel = AuthModel();
  CustomLoader customLoader = CustomLoader();

  void initState() {
    super.initState();
  }

  submit(context) async {
    Controller c = Get.put(Controller());
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      customLoader.showLoader('Login you in...');
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authModel.email as String,
        password: authModel.password as String,
      );
      customLoader.dismissLoader();
      Navigator.pushNamed(context, HomeRoute);
    } on FirebaseAuthException catch (e) {
      customLoader.dismissLoader();

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        customLoader.showError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        customLoader.showError('Wrong password provided for that user.');
      }
    } catch (e) {
      customLoader.showError(e);
      customLoader.dismissLoader();
    }
  }

  toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    setState(() {});
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: CustomColors.PrimaryColor,
          systemNavigationBarColor: CustomColors.PrimaryColor,
          statusBarBrightness: Brightness.light,

          // systemStatusBarContrastEnforced: true, //status bar brigtness
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 89),
                            const Text('Delivery Plus',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 66),
                            const Text('Login To Your Account.',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 66),
                            Input(
                              hintText: 'Email Address',
                              prefix: const Icon(Icons.email,
                                  color: CustomColors.PrimaryColor),
                              validator: (String? value) {
                                if (value == '') return 'Email cannot be empty';
                              },
                              onSaved: (String? value) {
                                authModel.email = value;
                              },
                            ),
                            const SizedBox(height: 39),
                            Input(
                              hintText: 'Password',
                              obscureText: obscurePassword,
                              // isPassword: true,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    toggleObscurePassword();
                                    rebuildAllChildren(context);
                                  },
                                  child: Icon(
                                      obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: CustomColors.PrimaryColor)),
                              validator: (String? value) {
                                if (value == '')
                                  return 'Password cannot be empty';
                                else if (value!.length < 5)
                                  return 'Password must 6 characters or more';
                              },
                              onSaved: (String? value) {
                                authModel.password = value;
                              },
                              prefix: const Icon(
                                Icons.lock,
                                color: CustomColors.PrimaryColor,
                              ),
                              // suffixIcon: Icon(Icons.visibility_off)
                            ),
                            const SizedBox(height: 10.5),
                            SWbutton(
                              title: 'Login',
                              onPressed: () {
                                submit(context);
                                // Get.to(Tabs());
                                // Get.to(JobDetails());
                              },
                            ),
                            const SizedBox(height: 13),
                            SizedBox(height: 13),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don’t have an account?',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(width: 5),
                                InkWell(
                                    onTap: () =>
                                        // Get.to((CompleteRegistration())),
                                        Navigator.pushNamed(
                                            context, RegisterRoute),
                                    child: Text('Sign Up',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: CustomColors.PrimaryColor,
                                            fontWeight: FontWeight.w700)))
                              ],
                            )
                          ],
                        ))))));
  }
}
