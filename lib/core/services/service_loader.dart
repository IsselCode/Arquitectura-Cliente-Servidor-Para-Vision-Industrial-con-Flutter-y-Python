import 'package:flutter/material.dart';

class ServiceLoader {

  static Future<T?> loader<T>({required Future future, required BuildContext context}) async {
    return Navigator.of(context).push<T>(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black26,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, anim, _) {
          return PopScope(
            canPop: false,
            child: FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done){
                  Navigator.pop(context, snapshot.data);
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
        transitionsBuilder: (context, anim, _, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
            child: child,
          );
        },
      ),
    );
  }

}