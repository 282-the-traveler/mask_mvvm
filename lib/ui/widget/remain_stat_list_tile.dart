import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/store.dart';

class RemainStatListTile extends StatelessWidget {
  final Store store;
  RemainStatListTile({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        store.name ?? '',
      ),
      subtitle: Text(
        store.addr ?? '',
      ),
      trailing: buildRemainStatWidget(
        store,
      ),
      onTap: () {
        _launchUrl(store.lat!, store.lng!);
      },
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

  Future<void> _launchUrl(double lat, double lng) async {
    final Uri _url = Uri.parse('https://google.com/maps/search/?api=1&query=$lat,$lng');
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
