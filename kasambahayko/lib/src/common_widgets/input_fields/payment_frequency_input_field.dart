import 'package:flutter/material.dart';

enum PaymentFrequency {
  daily,
  weekly,
  semiMonthly,
  monthly,
  quarterly,
  semiAnnually,
  annually,
}

PaymentFrequency? stringToPaymentFrequency(String? paymentFrequencyString) {
  switch (paymentFrequencyString) {
    case "Daily":
      return PaymentFrequency.daily;
    case "Weekly":
      return PaymentFrequency.weekly;
    case "Semi-Monthly":
      return PaymentFrequency.semiMonthly;
    case "Monthly":
      return PaymentFrequency.monthly;
    case "Quarterly":
      return PaymentFrequency.quarterly;
    case "Semi-Annually":
      return PaymentFrequency.semiAnnually;
    case "Annually":
      return PaymentFrequency.annually;
    default:
      return null;
  }
}

String? paymentFrequencyToString(PaymentFrequency? paymentFrequency) {
  if (paymentFrequency != null) {
    switch (paymentFrequency) {
      case PaymentFrequency.daily:
        return "Daily";
      case PaymentFrequency.weekly:
        return "Weekly";
      case PaymentFrequency.semiMonthly:
        return "Semi-Monthly";
      case PaymentFrequency.monthly:
        return "Monthly";
      case PaymentFrequency.quarterly:
        return "Quarterly";
      case PaymentFrequency.semiAnnually:
        return "Semi-Annually";
      case PaymentFrequency.annually:
        return "Annually";
    }
  }
  return null;
}

class PaymentFrequencyWidget extends StatelessWidget {
  final PaymentFrequency? selectedFrequency;
  final ValueChanged<PaymentFrequency?> onChanged;
  final bool enabled;

  const PaymentFrequencyWidget({
    Key? key,
    required this.selectedFrequency,
    required this.onChanged,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: true,
          controller: TextEditingController(
              text: paymentFrequencyToString(selectedFrequency)),
          onTap: () {
            showPaymentFrequencyPicker(context);
          },
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            label: const Text("Select a Frequency of Payment"),
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            border: const OutlineInputBorder(),
          ),
          enabled: enabled,
        ),
      ],
    );
  }

  void showPaymentFrequencyPicker(BuildContext context) {
    const List<PaymentFrequency> paymentFrequencies = PaymentFrequency.values;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Select a Payment Frequency",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: paymentFrequencies.map((frequency) {
              return ListTile(
                title: Text(
                  paymentFrequencyToString(frequency)!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onChanged(frequency);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
