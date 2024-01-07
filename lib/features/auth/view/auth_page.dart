import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../generated/l10n.dart';

final _formKey = GlobalKey<FormBuilderState>();
const String emailFieldName = 'email';
const String passwordFieldName = 'password';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final requiredValidator = FormBuilderValidators.required();

    return Scaffold(
      body: FormBuilder(
        key: _formKey,
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
                  decoration: InputDecoration(labelText: S.of(context).email),
                  validator: FormBuilderValidators.compose([
                    requiredValidator,
                    FormBuilderValidators.email(),
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: FormBuilderTextField(
                  name: passwordFieldName,
                  decoration:
                      InputDecoration(labelText: S.of(context).password),
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
                  // Validate and save the form values
                  _formKey.currentState?.saveAndValidate();
                  debugPrint(_formKey.currentState?.value.toString());

                  // On another side, can access all field values without saving form with instantValues
                  _formKey.currentState?.validate();
                  debugPrint(_formKey.currentState?.instantValue.toString());
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
    );
  }
}
