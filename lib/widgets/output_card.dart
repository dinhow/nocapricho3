// import 'package:couple_finance/controllers/authController.dart';
// import 'package:couple_finance/controllers/outputController.dart';
// import 'package:couple_finance/widgets/info_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OutputCard extends GetWidget<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetX<OutputDataController>(
//       init: Get.put<OutputDataController>(OutputDataController()),
//       builder: (OutputDataController infoController) {
//         if (infoController != null && infoController.infoData != null) {
//           return Expanded(
//             child: ListView.builder(
//               itemCount: infoController.infoData.length,
//               itemBuilder: (_, index) {
//                 return Card(
//                   child: InfoTile(
//                       uid: controller.user.uid,
//                       color: Colors.red,
//                       //observacao: 'obs',
//                       info: infoController.infoData[index]),
//                 );
//               },
//             ),
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }
