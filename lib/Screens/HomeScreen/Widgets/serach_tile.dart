
import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onTap;
  const SearchTile({super.key, required this.userData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 39,
            backgroundColor: Colors.black,
            child: CircleAvatar(radius: 35, child: Icon(Icons.person)),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userData["Name"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
