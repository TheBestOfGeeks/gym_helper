import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gym_helper/app/common/helpers.dart';

enum Decoration { standart }

class FieldManager {
  final BuildContext _context;
  final String _fieldName;
  final String _labeltext;
  final Decoration _decoration;
  final AutovalidateMode _autovalidateMode;
  final TextInputType _keyboarType;
  final List<String? Function(String?)>? _validators;
  final bool _isRequired;
  final bool _obscureText;
  final String _requiredErrorText;
  final Function(String?)? _onChanged;

  FieldManager({
    required BuildContext context,
    required String fieldName,
    required String labeltext,
    Decoration decoration = Decoration.standart,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    TextInputType keyboarType = TextInputType.text,
    bool hideInputText = false,
    List<String? Function(String?)>? validators,
    bool isRequired = false,
    Function(String?)? onChanged,
    String? requiredErrorText,
  })  : _isRequired = isRequired,
        _validators = validators,
        _keyboarType = keyboarType,
        _autovalidateMode = autovalidateMode,
        _decoration = decoration,
        _labeltext = labeltext,
        _fieldName = fieldName,
        _onChanged = onChanged,
        _requiredErrorText = requiredErrorText ?? context.l10n.requiredField,
        _context = context,
        _obscureText = hideInputText;

  FormBuilderTextField buildField() {
    return FormBuilderTextField(
      name: _fieldName,
      autovalidateMode: _autovalidateMode,
      keyboardType: _keyboarType,
      obscureText: _obscureText,
      onTapOutside: (PointerDownEvent event) =>
          FocusScope.of(_context).unfocus(),
      onChanged: _onChanged,
      decoration: switch (_decoration) {
        Decoration.standart => standartDecoration(),
      },
      validator: FormBuilderValidators.compose(
        <FormFieldValidator<String>>[
          _isRequired
              ? FormBuilderValidators.required(errorText: _requiredErrorText)
              : (String? val) => null,
          ...?_validators,
        ],
      ),
    );
  }

  InputDecoration standartDecoration() {
    return InputDecoration(
      isDense: true,
      labelText: _labeltext,
      filled: true,
      fillColor: Colors.blueGrey[50]!.withOpacity(0.6),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        gapPadding: 2,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      errorBorder: const OutlineInputBorder(
        gapPadding: 2,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }
}
