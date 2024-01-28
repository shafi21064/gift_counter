import 'package:flutter/material.dart';
import 'package:gifter/utils/app_color.dart';
import 'package:intl/intl.dart';

class InfoCard extends StatelessWidget {
  final VoidCallback cardOnTap, deleteWork ;
  final String title, subTitle, dateAbdTime;
  const InfoCard({
    super.key,
    required this.cardOnTap,
    required this.title,
    required this.subTitle,
    required this.deleteWork,
    required this.dateAbdTime

  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.purple.withOpacity(.6),
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: InkWell(
            onTap: cardOnTap,
            child: RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: "$title\n",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.8),
                    children: [
                      TextSpan(
                          text: subTitle,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight:
                              FontWeight.normal,
                              height: 1.5))
                    ])),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Edited: ${DateFormat.yMEd()
                  .add_jms()
                  .format(DateTime.parse(
                  dateAbdTime))}',
              style: const TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
          ),
          trailing: IconButton(
            onPressed: deleteWork,
            icon: const Icon(Icons.delete, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
