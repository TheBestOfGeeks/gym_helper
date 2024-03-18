import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../app/common/widgets/loading_overlay.dart';
import '../../../app/common/widgets/toast.dart';
import '../../../app/settings/injection_container.dart';
import '../../../app/settings/navigation/app_router.dart';

import '../../../generated/l10n.dart';
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
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final requiredValidator =
        FormBuilderValidators.required(errorText: S.of(context).requiredField);

    return BlocProvider(
      create: (context) => di.get<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (errorMessage, authStatus) =>
                showToast(context: context, errorMessage: errorMessage),
            autenticaticated: (authStatus) =>
                context.router.push(const NavigationRoute()),
            unAutenticaticated: (authStatus) => context.router
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
              body: FormBuilder(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(flex: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: FormBuilderTextField(
                          name: emailFieldName,
                          enableInteractiveSelection: true,
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: InputDecoration(
                            labelText: S.of(context).email,
                          ),
                          validator: FormBuilderValidators.compose([
                            requiredValidator,
                            FormBuilderValidators.email(
                              errorText: S.of(context).invalidEmail,
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: FormBuilderTextField(
                          name: passwordFieldName,
                          decoration: InputDecoration(
                            labelText: S.of(context).password,
                          ),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            requiredValidator,
                          ]),
                        ),
                      ),
                      const SizedBox(height: 24),
                      MaterialButton(
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () {
                          final formState = formKey.currentState;
                          if (formState != null &&
                              formState.saveAndValidate()) {
                            final String email =
                                formState.value[emailFieldName];
                            final String password =
                                formState.value[passwordFieldName];

                            context.read<AuthBloc>().add(AuthEvent.signIn(
                                  email: email,
                                  password: password,
                                ));
                          }
                        },
                        child: const Text(
                          'Login',
                        ),
                      ),
                      const Spacer(flex: 10),
                    ],
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
