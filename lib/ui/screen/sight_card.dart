import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';

// Виджет отображает карточку интересного места в списке
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 204,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 96,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              Positioned(
                child: Text(
                  sight.type,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                top: 16,
                left: 16,
              ),
              Positioned(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 18,
                ),
                top: 19,
                right: 18,
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                height: 92,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Color(0XFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              Positioned(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 36,
                  child: Text(
                    sight.name,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: Color(0XFF3B3E5B),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                  ),
              ),
              Positioned(
                left: 16,
                right: 16,
                top: 58,
                bottom: 16,
                child: Text(
                  sight.details,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: Color(0XFF7C7E92),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
