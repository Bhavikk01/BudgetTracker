import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BalanceDialog extends StatefulWidget {
  final Function(double) balanceToAdd;
  const BalanceDialog({Key? key,required this.balanceToAdd}) : super(key: key);

  @override
  State<BalanceDialog> createState() => _BalanceDialogState();
}

class _BalanceDialogState extends State<BalanceDialog> {

  final TextEditingController balanceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width/1.4,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text("Add your Budget"),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: balanceController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                    hintText: "Budget in \$"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if(balanceController.text.isNotEmpty){
                    widget.balanceToAdd(
                      double.parse(balanceController.text),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add"),

              )
            ],
          ),
        ),
      ),
    );
  }
}
