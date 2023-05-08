import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:gpts/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:gpts/screens/init.dart';

final apiKey_chatGPT = Provider((_) => FlutterConfig.get('apiKey_chatGPT'));

// IOS용 테마
final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  fontFamily: 'NotoSansKR',
  dividerColor: Colors.transparent,
);

// 기본 테마
final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColor: MyTheme.kPrimaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: MyTheme.kAccentColor),
  fontFamily: 'NotoSansKR',
  dividerColor: Colors.transparent,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    ProviderScope(
      child: MaterialApp(
        home: const GPT(),
        theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class GPT extends HookConsumerWidget {
  const GPT({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
        elevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: Size(25, 10),
        //   child: Container(
        //     // decoration: BoxDecoration(
        //     //   color: Colors.blue,
        //     //   borderRadius: BorderRadius.circular(20)
        //     // ),
        //     constraints: BoxConstraints.expand(height: 1),
        //     child: LinearProgressIndicator(
        //       valueColor: AlwaysStoppedAnimation(Colors.white),
        //       // backgroundColor: Colors.deepPurpleAccent,
        //     ),
        //   ),
        // ),
        backgroundColor: Colors.white10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'OMNI.GPT',
              style: TextStyle(
                // fontFamily: 'Pacifico',
                fontSize: 25,
                color: Colors.deepPurple[300],
              ),
            ),
          ]
        )
      ),
      // drawer: Drawer(),
      body: const Init(),
    );
  }
}