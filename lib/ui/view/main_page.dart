import 'package:flutter/material.dart';
import 'package:mask_mvvm/ui/widget/remain_stat_list_tile.dart';
import 'package:provider/provider.dart';

import '../../model/store.dart';
import '../../viewmodel/store_viewmodel.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeViewModel = Provider.of<StoreViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마스크 재고 있는 곳: ${storeViewModel.storeList.length}곳',
        ),
        actions: [
          IconButton(
            onPressed: () {
              storeViewModel.fetch();
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: storeViewModel.isLoading
          ? loadingWidget()
          : ListView(
              children: storeViewModel.storeList.map((e) {
                return RemainStatListTile(store: e);
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
