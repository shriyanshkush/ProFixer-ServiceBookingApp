import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/payment_model.dart';

class PaymentCard extends StatelessWidget {
  final int index;
  final Payment payment;
  final String userId;
  final String technicianId;
  final String bookingId;

  const PaymentCard({
    Key? key,
    required this.index,
    required this.payment,
    required this.technicianId,
    required this.userId,
    required this.bookingId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(payment.timeStamp);
    String formattedDate = DateFormat.yMMMMd().format(dateTime.toLocal());

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.blue
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Payment: #${index + 1}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Center(
                  child: Text(
                    "Booking ID: $bookingId",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 12),
                // Payment ID and Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _showFullPaymentId(context),
                        child: Text(
                          "Payment ID: ${payment.paymentId}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          payment.status == "succeeded"
                              ? Icons.check_circle
                              : Icons.error,
                          color: payment.status == "succeeded"
                              ? Colors.green
                              : Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text(
                          payment.status.toUpperCase(),
                          style: TextStyle(
                            color: payment.status == "succeeded"
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Payment Amount and Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Amount: ₹${payment.amount}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text(
                      "Date: $formattedDate",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                // Add a Divider
                Divider(color: Colors.grey[400]),
                SizedBox(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFullPaymentId(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Full Payment ID"),
          content: Text(payment.paymentId),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
