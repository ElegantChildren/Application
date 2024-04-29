import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUrl = Uri.parse(('https://catch-culture.netlify.app'));

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(homeUrl)
    ..setUserAgent('userAgent');

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context)?.addScopedWillPopCallback(() async {
      var canGoBack = await controller.canGoBack();
      if (canGoBack) {
        controller.goBack();
        return false; // Return false to prevent default back navigation
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('앱 종료'),
            content: Text('앱이 종료됩니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false to cancel the pop
                },
                child: Text('아니오'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('예'),
              ),
            ],
          ),
        );
        return true; // Return true to allow the back navigation
      }
    });

    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller),
      ),
    );

  }
}