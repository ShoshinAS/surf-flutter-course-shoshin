import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 360,
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
          Padding(
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
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 2,
              left: 16,
            ),
            child: Row(
              children: [
                Text(
                  sight.type,
                  style: const TextStyle(
                    color: Color(0xFF3B3E5B),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    height: 18 / 14,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Text(
                    'закрыто до 09:00',
                    style: TextStyle(
                      color: Color(0xFF7C7E92),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      height: 18 / 14,
                    ),
                  ),
                ),
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
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 16,
              right: 16,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                Row(
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
                          'ПОСТРОИТЬ МАРШРУТ',
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
              ],
            ),
          ),
          Container(
              height: 24,
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF7C7E928F),
                    width: 0.8,
                  ),
                ),
              ),
            ),
          Container(
            height: 48,
            padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
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
                        const Text(
                          'Запланировать',
                          style: TextStyle(
                            color: Color(0xFF7C7E928F),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            height: 18 / 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
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
                          const Text(
                            'В Избранное',
                            style: TextStyle(
                              color: Color(0xFF3B3E5B),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              height: 18 / 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
