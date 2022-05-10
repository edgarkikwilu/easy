import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:flutter/material.dart';

class WalletTransactionCard extends StatelessWidget{
  const WalletTransactionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 100,
        decoration: BoxDecoration(
            color: CustomColors.someGray,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Pending", style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.primary,fontSize: 18)),
                const SizedBox(height: 8),
                Text("Topup", style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.white,fontSize: 18)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tsh 10,000", style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.green,fontSize: 18)),
                const SizedBox(height: 8),
                Text("Jan 1", style: Theme.of(context).textTheme.button!.copyWith(color: CustomColors.white,fontSize: 18)),
              ],
            )
          ],
        )
    );
  }
}