import 'package:flutter/material.dart';
import 'package:ggy_twitter_clone/service_locators.dart';
import 'package:ggy_twitter_clone/src/controllers/auth_controllers.dart';
import 'package:ggy_twitter_clone/src/controllers/navigation/navigation_service.dart';
import 'package:ggy_twitter_clone/src/screens/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  static const String route = "authScreen";

  const AuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCon = TextEditingController(),
      _passCon = TextEditingController(),
      _pass2Con = TextEditingController(),
      _usernameCon = TextEditingController(),
      _handlenameCon = TextEditingController();
  final AuthController _authController = locator<AuthController>();

  String prompts = '';

  @override
  void initState() {
    _authController.addListener(handleLogin);
    super.initState();
  }

  handleLogin() {
    if (_authController.currentUser != null) {
      locator<NavigationService>().pushReplacementNamed(HomeScreen.route);
    }
  }

  @override
  void dispose() {
    _emailCon.dispose();
    _passCon.dispose();
    _pass2Con.dispose();
    _usernameCon.dispose();
    _authController.removeListener(handleLogin);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _authController.flush();
    return AnimatedBuilder(
        animation: _authController,
        builder: (context, Widget? w) {
          ///shows a loading screen while initializing
          if (_authController.working) {
            return const Scaffold(
              body: Center(
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                        color: Colors
                            .lightBlueAccent) //Special Child that Shows a Loading Screen
                    ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.lightBlueAccent,
                title: Text(
                  'GGY_TClone',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontSize: 28)),
                ),
                // backgroundColor: const Color(0xFF303030),
                centerTitle: true,
              ),
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: 2.5 / 4,
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Form(
                                  key: _formKey,
                                  onChanged: () {
                                    _formKey.currentState?.validate();
                                    if (mounted) {
                                      setState(() {});
                                    }
                                  },
                                  child: DefaultTabController(
                                    length: 2,
                                    initialIndex: 0,
                                    child: Column(
                                      children: [
                                        TabBar(indicatorWeight: 5, tabs: [
                                          Tab(
                                            child: Text(
                                              'Log In',
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Tab(
                                            child: Text(
                                              'Register',
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        ]),
                                        Expanded(
                                          child: TabBarView(
                                            children: [
                                              //each child is listed in a tab (so TabBarView Widgets === TabBar && DefaultTabBarController.length)
                                              ///login (1 / 2)
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(_authController.error
                                                                  ?.message !=
                                                              null ||
                                                          _authController
                                                                  .errorS !=
                                                              null
                                                      ? "${_authController.error?.message ?? ''}${_authController.errorS ?? ''}"
                                                      : ''),
                                                  TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText: 'Email'),
                                                    controller: _emailCon,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your email';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: 'Password',
                                                    ),
                                                    controller: _passCon,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your password';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: (_formKey
                                                                .currentState
                                                                ?.validate() ??
                                                            false)
                                                        ? () {
                                                            _authController
                                                                .login(
                                                                    _emailCon
                                                                        .text
                                                                        .trim(),
                                                                    _passCon
                                                                        .text
                                                                        .trim());
                                                          }
                                                        : null,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            fixedSize:
                                                                const Size(
                                                                    240, 50),
                                                            primary: (_formKey
                                                                        .currentState
                                                                        ?.validate() ??
                                                                    false)
                                                                ? Colors
                                                                    .lightBlueAccent
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface),
                                                    child: Text(
                                                      'Log in',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: (_emailCon.text
                                                                    .trim() ==
                                                                ''
                                                            ? false
                                                            : true)
                                                        ? () {
                                                            _authController
                                                                .changeFogotPassword(
                                                                    _emailCon
                                                                        .text
                                                                        .trim());
                                                          }
                                                        : null,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            fixedSize:
                                                                const Size(
                                                                    240, 50),
                                                            primary: (_emailCon
                                                                            .text
                                                                            .trim() ==
                                                                        ''
                                                                    ? false
                                                                    : true)
                                                                ? Colors
                                                                    .redAccent
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface),
                                                    child: Text(
                                                      'Forgot Password?',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              ///register (2 / 2)
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(_authController.error
                                                                  ?.message !=
                                                              null ||
                                                          _authController
                                                                  .errorS !=
                                                              null
                                                      ? "${_authController.error?.message ?? ''}${_authController.errorS ?? ''}"
                                                      : ''),
                                                  TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText: 'Email'),
                                                    controller: _emailCon,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your email';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText: 'Password',
                                                    ),
                                                    controller: _passCon,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your password';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Confirm Password',
                                                    ),
                                                    controller: _pass2Con,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please confirm your password';
                                                      } else if (_passCon
                                                              .text !=
                                                          _pass2Con.text) {
                                                        return 'Passwords do not match!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Enter username',
                                                    ),
                                                    controller: _usernameCon,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter username';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                      hintText:
                                                          'Enter Handle Name',
                                                    ),
                                                    controller: _handlenameCon,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter Handle Name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: (_formKey
                                                                .currentState
                                                                ?.validate() ??
                                                            false)
                                                        ? () {
                                                            _authController.register(
                                                                email: _emailCon
                                                                    .text
                                                                    .trim(),
                                                                password:
                                                                    _passCon
                                                                        .text
                                                                        .trim(),
                                                                username:
                                                                    _usernameCon
                                                                        .text
                                                                        .trim(),
                                                                handle:
                                                                    _handlenameCon
                                                                        .text
                                                                        .trim());
                                                          }
                                                        : null,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            fixedSize:
                                                                const Size(
                                                                    240, 50),
                                                            primary: (_formKey
                                                                        .currentState
                                                                        ?.validate() ??
                                                                    false)
                                                                ? Colors
                                                                    .lightBlueAccent
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onSurface),
                                                    child: Text('Register',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                textStyle:
                                                                    const TextStyle(
                                                          fontSize: 15,
                                                        ))),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
