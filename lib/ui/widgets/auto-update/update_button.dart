import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:xuriti/ui/widgets/auto-update/upgrade_widget.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UpgradeWidget(
      upgrader: Upgrader(
      
        durationUntilAlertAgain: const Duration(milliseconds: 500),
        showReleaseNotes: false,
        showIgnore: false,
      ),
      builder: (context, upgrader) => CircleAvatar(
        child: IconButton(
          onPressed: () {
            upgrader.checkVersion(context: context);
          },
          icon: const Icon(Icons.upload),
        ),
      ),
    );
  }
}