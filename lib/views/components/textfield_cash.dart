import 'package:cash_calc/utils/app_texts.dart';
import 'package:flutter/material.dart';

@immutable
class TextFieldCash extends StatefulWidget {
  const TextFieldCash(this.txtCtrlr, this.performCalculations,
      [this.currencyIso = '']);

  final TextEditingController txtCtrlr;
  final VoidCallback performCalculations;
  final String currencyIso;

  @override
  _TextFieldCashState createState() => _TextFieldCashState();
}

class _TextFieldCashState extends State<TextFieldCash> {
  bool _autoValidation = false;
  final textFormKey = GlobalKey<FormState>();
  void _countMoneyOnlyIfValidated() {
    if (textFormKey.currentState.validate()) {
      textFormKey.currentState.save();
      widget.performCalculations();
    }
  }

  void _setAutoValidation(bool isAutoValid) {
    setState(() => _autoValidation = isAutoValid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Container(
        width: 280,
        child: Form(
          key: textFormKey,
          child: TextFormField(
            controller: widget.txtCtrlr,
            maxLength: 15,
            autocorrect: false,
            style: Theme.of(context).textTheme.subhead,
            autovalidate: _autoValidation,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (String value) => validateInput(
                value, AppTexts.of(context).errEnteredNumNotValid),
            onChanged: (String value) {
              _setAutoValidation(true);
              _countMoneyOnlyIfValidated();
            },
            onEditingComplete: () {
              _setAutoValidation(false);
              FocusScope.of(context).requestFocus(FocusNode());
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              hintText: AppTexts.of(context).amount,
              labelText: AppTexts.of(context).inputAmount,
              prefixIcon: Icon(Icons.assessment),
              suffixText: widget.currencyIso,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 80),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ),
    );
  }
}

String validateInput(String input, String error) {
  if (input.isEmpty) {
    return null;
  } else if (!RegExp(r'^\d+(\.\d{1,5})?$').hasMatch(input)) {
    return error;
  } else {
    return null;
  }
}
