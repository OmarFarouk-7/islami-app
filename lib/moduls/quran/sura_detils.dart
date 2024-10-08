import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app/models/provider/my_provider.dart';
import 'package:islami_app/moduls/quran/widget/sura_name_widget.dart';
import 'package:provider/provider.dart';

class SuraDetils extends StatefulWidget {
  static const String routeName = 'sura_details';

  const SuraDetils({super.key});

  @override
  State<SuraDetils> createState() => _SuraDetilsState();
}

class _SuraDetilsState extends State<SuraDetils> {
  String versContent = '';
  List<String> versList = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var theme = Theme.of(context);
    var args = ModalRoute.of(context)!.settings.arguments as SuraData;

    if (versContent.isEmpty) readFile(args.suraNumber);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(provider.themeMode == ThemeMode.light
                ? 'assets/images/background_light.png'
                : 'assets/images/background_dark.png'),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Islami'),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin:
              const EdgeInsets.only(top: 20, bottom: 50, right: 20, left: 20),
          padding: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.light
                  ? const Color(0xffF8F8F8).withOpacity(0.6)
                  : const Color(0xff141A2E),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.canvasColor,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'سورة ${args.suraName}',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.play_circle,
                    size: 27.1,
                    color: provider.themeMode == ThemeMode.light
                        ? Colors.black
                        : theme.canvasColor,
                  ),
                ],
              ),
              Divider(
                color: provider.themeMode == ThemeMode.light
                    ? theme.primaryColor
                    : theme.canvasColor,
                thickness: 2,
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Column(
                      children: [
                        Text(
                          versList[index],
                          textDirection: TextDirection.rtl,
                          style: theme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: const AssetImage(
                              'assets/images/img_number.png',
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                  itemCount: versList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  readFile(int fileIndex) async {
    String text = await rootBundle.loadString('assets/files/$fileIndex.txt');
    setState(() {
      versContent = text;
      versList = versContent.trim().split('\n');
    });
    // print(text);
  }
}
