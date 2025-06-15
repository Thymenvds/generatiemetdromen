import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const Widget drawer = MyDrawer();
    return Text("Base");
    // return GetBuilder<BasePageController>(
    //     builder:(controller) => IndexedStack(
    //       index: controller.tabIndex,
    //       children: const [
    //         // DashboardPage(drawer),
    //         // PronostiekPage(drawer),
    //         // ResultPage(drawer),
    //         // RulesPage(drawer),
    //         // AdminPage(drawer),
    //       ]
    //     )
    //   );
  }
}