import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';

final controller = WebViewController()
..setJavaScriptMode(JavaScriptMode.unrestricted)
..setBackgroundColor(const Color(0x00000000))
..setNavigationDelegate(
NavigationDelegate(
onProgress: (int progress) {
// Update loading bar.
},
onPageStarted: (String url) {},
onPageFinished: (String url) {},
onWebResourceError: (WebResourceError error) {},
onNavigationRequest: (NavigationRequest request) {
if (request.url.startsWith('https://www.youtube.com/')) {
return NavigationDecision.prevent;
}
return NavigationDecision.navigate;
},
),
)
..loadRequest(Uri.parse('https://ecosortnextjs.vercel.app'));

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}



class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('Ecosort Web Admin', style: TextStyle(color: Colors.white),),
  centerTitle: true,
      // backgroundColor: const Color.fromRGBO(75,147,233, 1.0),
    ),

body: WebViewWidget(controller: controller),
);
  }
}
