import 'package:auto_route/auto_route.dart';
import '../../../../main.dart';
import '../bloc/sign_up_cubit.dart';
import '../../../../core/common/buttons/custom_button.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../../core/common/uistate/common_ui_state.dart';
import '../../../../core/routes/routes.gr.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../config/colors.dart';
import '../../../../config/strings.dart';
import '../../../../core/widgets/loading_bar.dart';
import '../../../../extensions.dart';
import '../bloc/login_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit _loginCubit;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loginCubit = BlocProvider.of<LoginCubit>(context);
    return GestureDetector(
      onTap: () => context.removeFocus(),
      child: SafeArea(
        child: BlocConsumer<LoginCubit, CommonUIState>(
          listener: (_, state) {
            state.maybeWhen(
              orElse: () {},
              success: (message) {
                if (message == SuccessState.LOGIN_SUCCESS) {
                  context.router.root.pushAndPopUntil(
                    FeedScreenRoute(),
                    predicate: (route) => false,
                  );
                  context.showSnackBar(message: "Login Successfully");
                }
              },
              error: (e) {
                if (e!.isNotEmpty) {
                  context.showOkAlertDialog(desc: e, title: "Alert");
                }
              },
            );
          },
          builder: (c, state) => state.when(
            initial: buildHome,
            success: (s) => buildHome(),
            loading: () => LoadingBar(),
            error: (e) => buildHome(),
          ),
        ),
      ),
    );
  }

  Widget buildHome() {
    return Scaffold(
        backgroundColor: isDark ? AppColors.appBlackColor : Colors.white,
        body: SingleChildScrollView(
          child: Container(
            constraints:
                BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: KeyboardActions(
              config: KeyboardActionsConfig(
                keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
                actions: [
                  KeyboardActionsItem(
                    focusNode: _loginCubit.emailValidators.focusNode,
                  ),
                  KeyboardActionsItem(
                    displayDoneButton: true,
                    toolbarButtons: [
                      (node) {
                        return GestureDetector(
                          onTap: () => node.unfocus(),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.close),
                          ),
                        );
                      }
                    ],
                    focusNode: _loginCubit.passwordValidator.focusNode,
                  ),
                ],
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: [
                  buildTopView().toExpanded(flex: 3),
                  buildMiddleView(context).toExpanded(flex: 3),
                  buildBottomView().toExpanded(flex: 1),
                ]
                    .toColumn(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center)
                    .toContainer(alignment: Alignment.center)
                    .toHorizontalPadding(24.0),
              ),
            ),
          ),
        )
        // .toFadeAnimation(animationController).toSlideAnimation(animationController),
        );
  }

  Widget buildTopView() {
    return [
      AppIcons.appLogo.toContainer(alignment: Alignment.center).toExpanded(),
      [
        Strings.emailAddress.toTextField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            onChange: (s) => setState(() {}),
            errorText: !_emailController.text.isValidEmail &&
                    _emailController.text.isNotEmpty
                ? 'Please Enter a valid email address'
                : null),

        10.toSizedBox,
        Strings.password.toTextField(
          controller: _passwordController,
          onChange: (s) => setState(() {}),
          errorText: _passwordController.text.length <= 6 &&
                  _passwordController.text.isNotEmpty
              ? 'Please enter more than 6 characters'
              : null,
          onSubmit: (value) {
            _loginCubit.loginUser(
                _emailController.text, _passwordController.text);
          },
          isPassword: true,
          isPasswordVisible: _loginCubit.isPasswordVisible,
          onVisibilityTap: () => _loginCubit.changePasswordVisibility(),
        ),
        Strings.forgotPassword
            .toCaption(fontWeight: FontWeight.w500)
            .toContainer(alignment: Alignment.centerRight)
            .toVerticalPadding(12.0)
            .onTapWidget(() {
          context.router.root.push(ResetPasswordScreenRoute());
        }),
        // "The email and password you entered does not match. Please double-check and try again".toCaption(color: Colors.red,fontWeight: FontWeight.w500).toVisibilityStreamBuilder(loginCubit.errorTextStream.stream)
      ].toColumn()
    ]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center)
        .toContainer(alignment: Alignment.bottomCenter);
  }

  Widget buildMiddleView(BuildContext context) {
    bool _formValid = _emailController.text.isValidEmail &&
        _passwordController.text.length > 6;
    return [
      25.toSizedBox,
      Strings.byClickingAgree
          .toButton(fontSize: 12.0, color: AppColors.greyText),
      [
        Strings.termsOfUse
            .toButton(fontSize: 12.0, color: AppColors.colorPrimary)
            .onTapWidget(() {
          context.removeFocus();
          context.router.root.push(WebViewScreenRoute(
              url: Strings.termsUrl, name: Strings.termsOfUse));
        }),
        " and ".toButton(fontSize: 12.0, color: AppColors.greyText),
        Strings.privacy
            .toButton(fontSize: 12.0, color: AppColors.colorPrimary)
            .onTapWidget(() {
          context.removeFocus();
          context.router.root.push(
            WebViewScreenRoute(
              url: Strings.privacyUrl,
              name: Strings.privacy,
            ),
          );
        })
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
      35.toSizedBox,
      CustomButton(
        color: _formValid
            ? AppColors.colorPrimary
            : AppColors.colorPrimary.withOpacity(.5),
        text: LocaleKeys.login.tr(),
        fullWidth: true,
        onTap: () async {
          if (_formValid)
            _loginCubit.loginUser(
                _emailController.text, _passwordController.text);
          FocusManager.instance.primaryFocus!.unfocus();
        },
      ),
      35.toSizedBox,
      [
        // Images.facebook
        //     .toSvg()
        //     .toFlatButton(() {}, color: AppColors.fbBlue)
        //     .toSizedBox(height: 40, width: 55),
        // 10.toSizedBox,
        // Images.google
        //     .toSvg()
        //     .toFlatButton(
        //       () {},
        //     )
        //     .toSizedBox(height: 40, width: 55)
        //     .toContainer(
        //         decoration: BoxDecoration(
        //       border: Border.all(width: 1, color: Colors.grey.withOpacity(.1)),
        //       shape: BoxShape.rectangle,
        //     )),
        10.toSizedBox,
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
    ]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center)
        .toContainer(alignment: Alignment.topCenter);
  }

  Widget buildBottomView() {
    return [
      Strings.dontHaveAnAccount.toCaption(
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : Colors.black54),
      Strings.signUpCaps
          .toButton(color: AppColors.colorPrimary)
          .toUnderLine()
          .toFlatButton(() => context.router.root.replace(SignUpScreenRoute())),
    ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        )
        .toContainer(
          alignment: Alignment.center,
        );
  }
}
