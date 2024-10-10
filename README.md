# exception_handler

A Flutter package that automatically detects and reports app exceptions via email, enhancing error tracking and debugging processes.

## Usage

In the principal file, replace the `main` method

```dart
void main() {
    runApp(MyApp())
};
```

for

```dart
void main() {
    WidgetsFlutterBinding.ensureInitialized();
    ExceptionCatcher(
      globalKey: GlobalKey<ScaffoldState>(),
      rootWidget: YouMainWidgetApp(
        globalKey: GlobalKey<ScaffoldState>(),
      ),
      username: 'SMTP USER',
      password: 'SMTP PASSWORD',
      subject: 'Subject - Exception Notifier',
      environment: 'Production',
      recipients: ['john.doe@email.com'],
      onIsActiveExceptionHandler: () async {
        return false;
      },
      onUserInfo: () async {
        return user;
      },
    );
}
```

`YouMainWidgetApp` is the base widget that you are using;

For take screenshot of the app and attach it, is necessary create a instance GlobalKey<ScaffoldState>() and use it instance in a RepaintBoundary

```dart
class YouMainWidgetApp extends StatelessWidget {
  const YouMainWidgetApp({
    super.key,
    required this.globalKey,
  });

  final GlobalKey<ScaffoldState> globalKey;

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      ...
      builder: (context, mainWidget) {
        return RepaintBoundary(
          key: globalKey,
          child: mainWidget,
        );
      },
    );
  }
}
```

## License

This package is licensed under the MIT License - see the [LICENSE.md](https://github.com/gvillegasc/exception_catcher/blob/master/LICENSE) file for details
