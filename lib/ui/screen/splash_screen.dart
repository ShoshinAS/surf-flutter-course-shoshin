import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screen/res/assets.dart';
import 'package:places/ui/screen/res/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<bool> isInitialized = Future.delayed(
    const Duration(seconds: 2),
    () => true,
  );

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            customColors.gradient1!,
            customColors.gradient2!,
          ],
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.appIcon,
        ),
      ),
    );
  }

  Future<void> _navigateToNext() async {
    if (await isInitialized) {
      debugPrint('Переход на следующий экран');
    }
  }
}
