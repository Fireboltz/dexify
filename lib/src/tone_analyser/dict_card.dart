import 'package:flutter/material.dart';

class DictCard extends StatelessWidget {
  final String score;
  final String toneId;
  final String toneName;

  DictCard(this.score, this.toneId, this.toneName);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 200,
      width: double.maxFinite,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 10,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width/3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    score != null ? score : " ",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    toneId != null ? toneId : "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    toneName != null ? toneName : "",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      fontFamily: "Poppins",
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}