import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String name, code, amount;
  final IconData icon;
  final bool isInverted;
  final int order;

  final _blackColor = const Color(0xFF1F2123);

  const CurrencyCard(
      {super.key,
      required this.name,
      required this.code,
      required this.amount,
      required this.icon,
      required this.isInverted,
      required this.order});

  @override
  Widget build(BuildContext context) {
    double offsetY = 0;
    if (order == 2) {
      offsetY = -20;
    } else if (order == 3) {
      offsetY = -40;
    }

    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Container(
        // clipBehavior: 컨테이너 밖으로 나가는 것을 어떻게 처리할지 정함
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : _blackColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        amount,
                        style: TextStyle(
                          color: isInverted ? _blackColor : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(code,
                          style: TextStyle(
                            color: isInverted
                                ? _blackColor
                                : Colors.white.withOpacity(0.8),
                            fontSize: 20,
                          ))
                    ],
                  ),
                ],
              ),
              Transform.scale(
                // child를 얼마나 키울 건지
                scale: 2.2,
                child: Transform.translate(
                  // child를 얼마나 이동할건지
                  offset: const Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white,
                    size: 88,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
