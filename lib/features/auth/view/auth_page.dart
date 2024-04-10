import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gym_helper/app/common/helpers.dart';
import '../../../app/common/widgets/basic_button.dart';
import '../../../app/common/widgets/field_manager.dart';
import '../../../app/common/widgets/loading_overlay.dart';
import '../../../app/common/widgets/toast.dart';
import '../../../app/settings/service_locator.dart';
import '../../../app/settings/navigation/app_router.dart';
import '../auth_bloc/auth_bloc.dart';

const String emailFieldName = 'email';
const String passwordFieldName = 'password';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceLocator.authBloc,
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (errorMessage, authStatus) =>
                showToast(context: context, errorMessage: errorMessage),
            autenticaticated: (authStatus) =>
                context.router.push(const NavigationRoute()),
            unAutenticaticated: () => context.router
                .popUntil((route) => route.settings.name == 'AuthRoute'),
          );
        },
        builder: (context, state) {
          bool isLoading = state.maybeWhen(
            loading: (authStatus) => true,
            orElse: () => false,
          );

          return LoadingOverlay(
            isLoading: isLoading,
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurpleAccent,
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: FormBuilder(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: FieldManager(
                            context: context,
                            fieldName: emailFieldName,
                            labeltext: context.l10n.email,
                            keyboarType: TextInputType.emailAddress,
                            isRequired: true,
                            validators: [
                              FormBuilderValidators.email(
                                errorText: context.l10n.invalidEmail,
                              ),
                            ],
                          ).buildField(),
                        ).animate().slideX(begin: -5, duration: 1201.ms),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: FieldManager(
                            context: context,
                            fieldName: passwordFieldName,
                            labeltext: context.l10n.password,
                            keyboarType: TextInputType.emailAddress,
                            isRequired: true,
                          ).buildField(),
                        ).animate().slideX(begin: 5, duration: 1200.ms),
                        const SizedBox(height: 24),
                        BasicButton(
                          text: context.l10n.login,
                          onTap: () {
                            final formState = formKey.currentState;
                            if (formState != null &&
                                formState.saveAndValidate()) {
                              final String email =
                                  formState.value[emailFieldName];
                              final String password =
                                  formState.value[passwordFieldName];

                              context.read<AuthBloc>().add(
                                    AuthEvent.signIn(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                            }
                          },
                        )
                            .animate()
                            .slide(
                              begin: const Offset(0, 40),
                              duration: 1000.ms,
                            )
                            .then(delay: 100.ms)
                            .shakeX(
                              duration: const Duration(milliseconds: 200),
                            ),
                        const Spacer(flex: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
