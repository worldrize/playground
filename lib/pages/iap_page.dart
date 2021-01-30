// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:playground/atoms/purchase_button.dart';
import 'package:playground/atoms/restore_button.dart';
import 'package:playground/domain/iap_state.dart';
import 'package:playground/util/secrets.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// <https://qiita.com/karamage/items/8d1352e5a4f1b079210b>
class Iap extends StateNotifier<IapState> {
  Iap() : super(const IapState()) {
    initPlatformState();
  }

  // 初期化処理
  // 購入情報・Offeringsの取得を行う
  Future initPlatformState() async {
    print('initPlatformState');
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(Secrets.instance.publicSdkKey);

    final purchaseInfo = await Purchases.getPurchaserInfo();
    final offerings = await Purchases.getOfferings();

    print(offerings);

    if (!mounted) {
      return;
    }

    state = IapState(purchaserInfo: purchaseInfo, offerings: offerings);
  }
}

// final iapRepo = IapRepository();
// final counterService = IapService(iapRepo);
final iapProvider = StateNotifierProvider((_) => Iap());

class IapPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(iapProvider.state);
    final iap = useProvider(iapProvider);

    return Scaffold(
      appBar: AppBar(title: Text('課金画面')),
      body: UpsellWidget(offerings: state.offerings),
    );
  }
}

// 課金アイテム表示
class UpsellWidget extends StatelessWidget {
  const UpsellWidget({Key key, @required this.offerings}) : super(key: key);

  final Offerings offerings;

  @override
  Widget build(BuildContext context) {
    final offering = offerings?.current;
    final noAdsPackage = offering?.getPackage('NoAds');

    if (offerings == null || noAdsPackage == null) {
      return const Center(
        child: Text('Loading...'),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 課金アイテムの説明
            Text('アプリ内の広告が非表示になります'),
            const SizedBox(height: 10),

            // 購入ボタン
            PurchaseButton(
              package: noAdsPackage,
              label: '広告を削除',
            ),
            const SizedBox(height: 30),

            // 復元ボタンのガイド
            Text('すでにご購入いただいている場合は、下記の復元ボタンをタップしてください'),
            const SizedBox(height: 10),

            // 復元ボタン
            RestoreButton(),
          ],
        ),
      ),
    );
  }
}
