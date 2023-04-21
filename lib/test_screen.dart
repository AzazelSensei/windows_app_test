import 'package:flutter/material.dart';
import 'package:windows_app_test/extensions/double_extension.dart';
import 'package:windows_app_test/theme/app_color_theme.dart';
import 'package:windows_app_test/theme/app_text_theme.dart';
import 'package:windows_app_test/widgets/custom_alert_dialog.dart';
import 'package:windows_app_test/widgets/primary_button.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const CustomContainer(),
          ExpandedCard(
            radius: 15.radius,
            title: "Açılır Kapanır Zımbırtı",
            color: AppColorTheme.color_E6F9FF,
            children: [
              PrimaryButton(
                onPressed: () => showAlertDialog(
                  context,
                  icon: const Icon(Icons.abc),
                  content: "content",
                  // cancelActionText: "Düzenle",
                  defaultActionText: "Tamam",
                  // onPressed: () {},
                ),
                // text: "Ozinin Buttonu",
                icon: const Icon(Icons.abc_outlined),
                style: context.textTheme.medium,
              ),
              const SizedBox(
                height: 24,
              ),
              PrimaryButton(
                onPressed: () => showAlertDialog(
                  context,
                  icon: const Icon(Icons.abc),
                  content: "content",
                  // cancelActionText: "Düzenle",
                  defaultActionText: "Tamam",
                  // onPressed: () {},
                ),
                // text: "Ozinin Buttonu",
                icon: const Icon(Icons.abc_outlined),
                style: context.textTheme.medium,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          PrimaryButton(
            onPressed: () => showAlertDialog(
              context,
              icon: const Icon(Icons.abc),
              content: "content",
              // cancelActionText: "Düzenle",
              defaultActionText: "Tamam",
              // onPressed: () {},
            ),
            // text: "Ozinin Buttonu",
            icon: const Icon(Icons.abc_outlined),
            style: context.textTheme.medium,
          ),
        ],
      )),
    );
  }
}

class ExpandedCard extends StatelessWidget {
  final BorderRadius radius;
  final Color color;
  final String title;
  final List<Widget> children;

  const ExpandedCard({
    super.key,
    required this.radius,
    required this.color,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        unselectedWidgetColor: Colors.black,
      ),
      child: ExpansionTile(
        collapsedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide.none,
        ),
        collapsedBackgroundColor: color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide.none,
        ),
        tilePadding: const EdgeInsets.all(24),
        childrenPadding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        backgroundColor: color,
        expandedAlignment: Alignment.center,
        iconColor: Colors.black,
        title: Text(
          title,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: context.textTheme.medium,
        ),
        children: children,
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Başlık',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Alt başlık',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Text(
              'İçerik metni burada olacak. Bu metin içerik hakkında detaylı bilgi vermek için kullanılacaktır.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Buton 1'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Buton 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
