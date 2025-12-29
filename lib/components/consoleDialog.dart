import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/app_log_riverpod.dart';

void showLogDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LogDialog();
    },
  );
}

class LogDialog extends StatefulWidget {
  const LogDialog({super.key});

  @override
  LogDialogState createState() => LogDialogState();
}

class LogDialogState extends State<LogDialog> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("控制台输出"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Consumer(builder: (context, ref, child) {
          var logolist = ref.watch(appLogRiverpod);
          if (logolist.isEmpty) {
            return const Text("没有日志输出");
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (scrollController.hasClients) {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            }
          });
          return ListView.builder(
            controller: scrollController,
            itemCount: logolist.length,
            itemBuilder: (context, index) {
              return Text(logolist[index]);
            },
          );
        }),
      ),
    );
  }
}
