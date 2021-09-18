import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TimelineDelivery();
  }
}

class _TimelineDelivery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isFirst: true,
            indicatorStyle: const IndicatorStyle(
              width: 20,
              color: Color(0xFF27AA69),
              padding: EdgeInsets.all(6),
            ),
            endChild: const _RightChild(
              asset: 'assets/images/delivery/order_placed.png',
              title: 'Order Placed',
              message: 'We have received your order.',
            ),
            beforeLineStyle: const LineStyle(color: Color(0xFF27AA69))),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF27AA69),
            padding: EdgeInsets.all(6),
          ),
          endChild: const _RightChild(
            asset: 'assets/images/delivery/order_confirmed.png',
            title: 'Order Confirmed',
            message: 'Your order has been confirmed.',
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF2B619C),
            padding: EdgeInsets.all(6),
          ),
          endChild: const _RightChild(
            asset: 'assets/images/delivery/order_processed.png',
            title: 'Order Processed',
            message: 'We are preparing your order.',
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
          afterLineStyle: const LineStyle(
            color: Color(0xFFDADADA),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isLast: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFFDADADA),
            padding: EdgeInsets.all(6),
          ),
          endChild: const _RightChild(
            disabled: true,
            asset: 'assets/images/delivery/ready_to_pickup.png',
            title: 'Ready to Pickup',
            message: 'Your order is ready for pickup.',
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFFDADADA),
          ),
        ),
      ],
    );
  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key? key,
    required this.asset,
    required this.title,
    required this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(asset, height: 50),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFBABABA)
                      : const Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: GoogleFonts.yantramanav(
                  color: disabled
                      ? const Color(0xFFD5D5D5)
                      : const Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
