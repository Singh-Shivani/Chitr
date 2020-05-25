import 'package:flutter/material.dart';
//import 'imageView.dart';

class WallpapersGrid extends StatelessWidget {
  final List data;
  WallpapersGrid({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(38, 46, 80, 1),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 12.0,
            crossAxisSpacing: 12.0,
            physics: ScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 0.57,
            children: List.generate(data.length, (index) {
              return GridTile(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (BuildContext context) =>
//                              ImageView(data: data, index: index),
//                        ),
//                      );
                    },
                    child: Hero(
                      tag: data[index],
                      child: Container(
                        child: Image.network(
                          data[index]['urls']['regular'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
