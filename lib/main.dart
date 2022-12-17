import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_mvvm/model/store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter mask mvvm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Store> storeList = [];
  bool isLoading = true;

  Future fetch() async {
    setState(() {
      isLoading = true;
    });
    var uri = Uri.https('gist.githubusercontent.com',
        '/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');

    var response = await http.get(uri);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));

    final jsonStores = jsonResult['stores'];

    setState(() {
      storeList.clear();
      jsonStores.forEach((jsonStore) {
        storeList.add(Store.fromJson(jsonStore));
      });
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마스크 재고 있는 곳: ${storeList.where(
                (element) =>
                    element.remainStat == 'plenty' ||
                    element.remainStat == 'some' ||
                    element.remainStat == 'few',
              ).length}곳',
        ),
        actions: [
          IconButton(
            onPressed: () {
              fetch();
            },
            icon: Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: isLoading
          ? loadingWidget()
          : ListView(
              children: storeList
                  .where((element) =>
                      element.remainStat == 'plenty' ||
                      element.remainStat == 'some' ||
                      element.remainStat == 'few')
                  .map((e) {
                return ListTile(
                  title: Text(
                    e.name ?? '',
                  ),
                  subtitle: Text(
                    e.addr ?? '',
                  ),
                  trailing: buildRemainStatWidget(e),
                );
              }).toList(),
            ),
    );
  }

  Widget buildRemainStatWidget(Store store) {
    String remainStat = '판매 중지';
    String description = '';
    Color color = Colors.black;
    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        description = '30개 ~ 100개';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        description = '2개 ~ 30개';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '소진 임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
        break;
    }
    return Column(
      children: [
        Text(
          remainStat,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          description,
          style: TextStyle(
            color: color,
          ),
        )
      ],
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
