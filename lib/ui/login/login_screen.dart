import 'package:cashier_app_mobile/bloc/auth_bloc/auth_bloc.dart';
import 'package:cashier_app_mobile/bloc/user_bloc/user_bloc.dart';
import 'package:cashier_app_mobile/shared_widgets/buttons.dart';
import 'package:cashier_app_mobile/shared_widgets/custon_snack_bar.dart';
import 'package:cashier_app_mobile/shared_widgets/login_textfield.dart';
import 'package:cashier_app_mobile/theme/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashier_app_mobile/helper/constant.dart';
import 'package:cashier_app_mobile/helper/locator.dart';
import 'package:cashier_app_mobile/helper/navigator_service.dart';
import 'package:cashier_app_mobile/helper/utils.dart';
import 'package:cashier_app_mobile/model/user.dart';
import 'package:cashier_app_mobile/helper/app_scale.dart';
// import 'package:yaml/yaml.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthLogin()),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: const Scaffold(
        backgroundColor: cashierWhite,
        body: LoginBody(),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> with TickerProviderStateMixin {
  bool _ishidePass = true;
  String tipeAgen = "";
  User model = User();
  final FocusNode _username = FocusNode();
  final FocusNode _pass = FocusNode();
  // final FocusNode _capcha = FocusNode();

  // String valueCapcha;
  String versionName = "v1.0.0";
  final formKey = GlobalKey<FormState>();
  late AnimationController controller;
  late Animation<double> animation;
  late UserBloc bloc;
  late AuthBloc authBloc;

  // randomInt() {
  //   var rng = new Random();
  //   var next = rng.nextDouble() * 100000;

  //   while (next < 100000) {
  //     next *= 10;
  //   }
  //   valueCapcha = next.toInt().toString();
  //   print(valueCapcha);
  // }

  @override
  void initState() {
    // randomInt();
    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<UserBloc>();
    // authBloc = context.read<AuthBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedIn) {
              locator<NavigatorService>().navigateReplaceTo(Constant.MENU_DASHBOARD);
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(failSnackBar(state.errMsg));
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is LoginComplete) {
              locator<NavigatorService>().navigateReplaceTo(Constant.MENU_DASHBOARD);
            }
            if (state is UserError) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(failSnackBar(state.error));
            }
          },
        ),
      ],
      child: SingleChildScrollView(
        child: SizedBox(
          height: context.deviceHeight(),
          width: context.deviceWidth(),
          child: Stack(
            children: [
              SizedBox(
                width: context.deviceWidth(),
                child: Positioned(
                  top: 0,
                  child: Image.asset(
                    "assets/Kopi_1_1.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.8,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       CustomPaint(
              //         size: Size(
              //           MediaQuery.of(context).size.width,
              //           MediaQuery.of(context).size.height * 0.2,
              //         ),
              //         painter: DrawTriangleShape(color: cashierAccent),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.83,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       CustomPaint(
              //         size: Size(
              //           MediaQuery.of(context).size.width,
              //           MediaQuery.of(context).size.height * 0.2,
              //         ),
              //         painter: DrawTriangleShape(color: cashierPrimary),
              //       ),
              //     ],
              //   ),
              // ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: context.deviceWidth(),
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                    color: cashierGray,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/logo_rukobo_2.png",
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.075),
                      Padding(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LoginFormField(
                                    isPassword: false,
                                    hint: "username",
                                    textInputAction: TextInputAction.next,
                                    focusNode: _username,
                                    keyboardHeight: keyboardHeight(context),
                                    onChange: (value) {
                                      model.email = value;
                                    },
                                    onAction: (value) => fieldFocusChange(context, _username, _pass),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Silahkan isi username";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  LoginFormField(
                                    isPassword: _ishidePass,
                                    hint: "kata sandi",
                                    suffixIcon: _ishidePass ? Icons.visibility_off : Icons.visibility,
                                    keyboarType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    focusNode: _pass,
                                    keyboardHeight: keyboardHeight(context),
                                    onIconTap: () {
                                      setState(() {
                                        _ishidePass = !_ishidePass;
                                      });
                                    },
                                    onChange: (value) {
                                      model.password = value;
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Silahkan isi kata sandi anda";
                                      } else if (value.length < 8) {
                                        return "Kata sandi minimal 8 karakter";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserLoading) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    width: context.deviceWidth() * 0.45,
                                    child: ButtonConfirm(
                                      text: "Login",
                                      onTap: () {
                                        // TODO: REPLACE BLOC
                                        locator<NavigatorService>().navigateReplaceTo(Constant.MENU_DASHBOARD);
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                locator<NavigatorService>().navigateReplaceTo(Constant.MENU_REGISTER);
                              },
                              child: const Text(
                                "Signup Here",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: cashierButtonBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.deviceHeight() * 0.05,
                      ),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: FutureBuilder(
                      //     future: rootBundle.loadString("pubspec.yaml"),
                      //     builder: (context, snapshot) {
                      //       String version = "Unknown";
                      //       String versionSurfix = "";
                      //       String buildDate = "";
                      //       if (snapshot.hasData) {
                      //         var yaml = loadYaml(snapshot.data as String);
                      //         version = yaml["version"].split("+")[0];
                      //         versionSurfix = yaml["versionNameSuffix"];
                      //         buildDate = yaml["buildDate"].toString();
                      //       }
                      //       if (versionSurfix != "prod") {
                      //         version = version + " (${versionSurfix.toUpperCase()}) \n" + buildDate;
                      //       } else {
                      //         version = version + " (${versionSurfix.toUpperCase()})";
                      //       }
                      //       return Container(
                      //         margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.08)),
                      //         padding: const EdgeInsets.only(right: 12),
                      //         // height: 20,
                      //         child: Text(
                      //           'Version: $version',
                      //           textAlign: TextAlign.right,
                      //           style: TextStyle(
                      //             fontSize: context.scaleFont(14),
                      //             fontWeight: FontWeight.w500,
                      //             color: cashierMenuBg,
                      //             overflow: TextOverflow.clip,
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  Color? color;

  DrawTriangleShape({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(0, size.width);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.width);
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..color = color ?? cashierLightBlue
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
