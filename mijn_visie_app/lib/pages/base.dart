import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mijn_visie_app/controllers/base_page_controller.dart';
import 'package:mijn_visie_app/controllers/my_questions_controller.dart';
import 'package:mijn_visie_app/pages/dashboard.dart';
import 'package:mijn_visie_app/pages/drawer.dart';
import 'package:mijn_visie_app/pages/my_questions.dart';

class BasePage extends StatelessWidget {
  BasePage({Key? key}) : super(key: key) {
    MyQuestionsController.to.getQuestions();
  }


  @override
  Widget build(BuildContext context) {
    const Widget drawer = MyDrawer();
    return GetBuilder<BasePageController>(
        builder:(controller) => IndexedStack(
          index: controller.tabIndex,
          children: const [
            DashboardPage(drawer),
            MyQuestionsPage(drawer),
            // PronostiekPage(drawer),
            // ResultPage(drawer),
            // RulesPage(drawer),
            // AdminPage(drawer),
          ]
        )
      );
  }
}