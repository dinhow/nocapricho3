// import 'package:nocapricho2/controllers/authController.dart';
// import 'package:nocapricho2/services/database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_masked_text/flutter_masked_text.dart';
// import 'package:get/get.dart';

// class InputNewDataScreen extends GetWidget<AuthController> {
//   final TextEditingController _infoController = TextEditingController();
//   final TextEditingController _valueController =
//       MoneyMaskedTextController(thousandSeparator: '.');

//   final String category;

//   InputNewDataScreen({Key key, this.category}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Checa valor da categoria e altera nomes
//     String tipoOperacao = category == 'entrada'
//         ? 'Nova Entrada'
//         : category == 'saida'
//             ? 'Nova Saída'
//             : category == 'fixa'
//                 ? 'Nova Conta Fixa'
//                 : 'Nova Dívida';

//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: Card(
//             child: Container(
//               padding: EdgeInsets.all(15),
//               height: 400,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(tipoOperacao),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   TextFormField(
//                     controller: _infoController,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(hintText: 'Descrição'),
//                   ),
//                   TextFormField(
//                     controller: _valueController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(hintText: 'Valor'),
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                       onPressed: () {
//                         if (_infoController.text != "") {
//                           Database().addData(
//                               _infoController.text,
//                               category,
//                               double.parse(_valueController.text),
//                               controller.user.uid);
//                           _infoController.clear();
//                           _valueController.clear();
//                           Get.back();
//                           Get.snackbar('Pronto! ',
//                               tipoOperacao + ' adicionada com sucesso!',
//                               snackPosition: SnackPosition.TOP);
//                           FocusScope.of(context).unfocus();
//                         }
//                       },
//                       child: Text(tipoOperacao))
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
