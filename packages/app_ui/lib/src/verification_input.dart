// import 'package:app_ui/app_ui.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_verification_code/flutter_verification_code.dart';

// class VerificationInput extends StatefulWidget {
//   const VerificationInput({super.key});

//   @override
//   State<VerificationInput> createState() => _VerificationInputState();
// }

// class _VerificationInputState extends State<VerificationInput> {
//   @override
//   Widget build(BuildContext context) {
//     return VerificationCode(
//       underlineWidth: 2,
//       fillColor: context.colors.secondary,
//       fullBorder: true,
//       underlineUnfocusedColor: Colors.grey.shade400,
//       textStyle: TextStyle(fontSize: 20.0, color: context.colors.onSecondary),
//       keyboardType: TextInputType.number,
//       underlineColor: context.colors
//           .primary, // If this is null it will use primaryColor: Colors.red from Theme
//       length: 4,
//       cursorColor: context
//           .colors.onSurface, // If this is null it will default to the ambient
//       // clearAll is NOT required, you can delete it
//       // takes any widget, so you can implement your design
//       clearAll: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           'clear all',
//           style: TextStyle(fontSize: 14.0, color: Colors.blue[700]),
//         ),
//       ),
//       onCompleted: (String value) {
//         setState(() {
//           //  _code = value;
//         });
//       },
//       onEditing: (bool value) {
//         setState(() {
//           // _onEditing = value;
//         });
//         // if (!_onEditing) FocusScope.of(context).unfocus();
//       },
//     );
//   }
// }
