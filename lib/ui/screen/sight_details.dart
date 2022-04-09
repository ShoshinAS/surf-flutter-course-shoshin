import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/strings.dart';

// Виджет отображает детальную информацию об интересном месте
// для отображения на отдельном экране
class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SightImage(),
          SightDescription(sight: sight),
          const RouteButton(),
          const Divider(),
          const BottomPanel(),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

// Виджет отображает краткую информацию об интересном месте
class SightDescription extends StatelessWidget {

  final Sight sight;

  const SightDescription({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SightName(sight: sight),
        Padding(
          padding: const EdgeInsets.only(
            top: 2,
            left: 16,
          ),
          child: Row(
            children: [
              SightType(sight: sight),
              const SightOpeningHours(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Text(
            sight.details,
            style: const TextStyle(
              color: Color(0xFF3B3E5B),
              fontSize: 14,
              fontFamily: 'Roboto',
              height: 18 / 14,
            ),
            maxLines: 4,
          ),
        ),
      ],
    );
  }
}

// Виджет отображает информацию о времени открытия интересного места
class SightOpeningHours extends StatelessWidget {
  const SightOpeningHours({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: 16,
      ),
      child: Text(
        MockStrings.openingHours,
        style: TextStyle(
          color: Color(0xFF7C7E92),
          fontSize: 14,
          fontFamily: 'Roboto',
          height: 18 / 14,
        ),
      ),
    );
  }
}

// Виджет отображает информацию о типе интересного места
class SightType extends StatelessWidget {

  final Sight sight;

  const SightType({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      sight.type,
      style: const TextStyle(
        color: Color(0xFF3B3E5B),
        fontSize: 14,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
        height: 18 / 14,
      ),
    );
  }
}

// Виджет отображает имя интересного места
class SightName extends StatelessWidget {

  final Sight sight;

  const SightName({
    Key? key,
    required this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      child: Text(
        sight.name,
        style: const TextStyle(
          color: Color(0xFF3B3E5B),
          fontSize: 24,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          height: 28.8 / 24,
        ),
      ),
    );
  }
}

// Виджет отображает нижнюю панель
class BottomPanel extends StatelessWidget {
  const BottomPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8,
      ),
      alignment: Alignment.bottomCenter,
      child: Row(
        children: const [
          BottomButton(text: AppStrings.plan, active: false),
          BottomButton(text: AppStrings.toFavourites, active: true),
        ],
      ),
    );
  }
}

// Виджет отображает изображение интересного места
// с кнопкой возврата на предыдущий экран
class SightImage extends StatelessWidget {
  const SightImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            //height: 360,
            color: Colors.red,
          ),
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              height: 32,
              width: 32,
              alignment: Alignment.center,
              child: Container(
                color: Colors.cyanAccent,
                width: 5,
                height: 10,
              ),
            ),
            left: 16,
            top: 36,
          ),
        ],
      ),
    );
  }
}

// Виджет отображает горизонтальную линию-разделитель
class Divider extends StatelessWidget {
  const Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0x7C7E928F),
            width: 0.8,
          ),
        ),
      ),
    );
  }
}

// Виджет отображает кнопку построения маршрута до интересного места
class RouteButton extends StatelessWidget {
  const RouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      alignment: Alignment.center,
      height: 48,
      decoration: const BoxDecoration(
        color: Color(0xFF4CAF50),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            width: 20,
            height: 18,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              AppStrings.route,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                letterSpacing: 0.03,
                height: 18 / 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Виджет отображает кнопки в нижней панели экрана
class BottomButton extends StatelessWidget {
  final String text;
  final bool active;

  Color get _textColor =>
      active ? const Color(0xFF3B3E5B) : const Color(0x7C7E928F);

  const BottomButton({
    required this.text,
    required this.active,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              color: Colors.greenAccent,
              margin: const EdgeInsets.only(
                right: 10,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                color: _textColor,
                fontSize: 14,
                fontFamily: 'Roboto',
                height: 18 / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
