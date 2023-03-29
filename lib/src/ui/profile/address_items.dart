import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final String areaId;
  final String address;
  final String landMark;
  final String state;
  final String pincode;

  const AddressItem({
    Key key,
    @required this.areaId,
    @required this.address,
    @required this.landMark,
    @required this.state,
    @required this.pincode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String land_mark = landMark;

    if(land_mark!=null){
      if(land_mark!=""){
        if(land_mark!="null"){
          land_mark = landMark;
        }else{
          land_mark = "";
        }
      }else{
        land_mark = "";
      }
    }else{
      land_mark = "";
    }

    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(border: Border.all()),
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${areaId},${address}'),
            Text('${land_mark}'),
            Text('${state},'),
            Text('${pincode}'),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                  ),
                  Container(
                      child: Center(
                    child: Text('Edit'),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
