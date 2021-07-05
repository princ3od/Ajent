import 'package:ajent/app/data/models/notification_model.dart';
import 'package:ajent/core/utils/date_converter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItem extends StatefulWidget {
  final NotificationModel notificationData;
  final Function onDelete;
  final Function onOpen;
  NotificationItem(
      {Key key,
      @required this.notificationData,
      @required this.onDelete,
      @required this.onOpen})
      : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem>
    with TickerProviderStateMixin {
  bool _isExpand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onOpen,
          onLongPress: () {
            setState(() {
              _isExpand = !_isExpand;
            });
          },
          child: ListTile(
            leading: CircleAvatar(
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                  fadeInDuration: Duration(milliseconds: 200),
                  fadeOutDuration: Duration(milliseconds: 180),
                  placeholder: 'assets/images/ajent_logo.png',
                  image: widget.notificationData?.imageUrl ?? "",
                  width: 60,
                  fit: BoxFit.fitWidth,
                ),
              ),
              radius: 25,
            ),
            title: AnimatedSize(
              duration: Duration(milliseconds: 400),
              curve: Curves.fastLinearToSlowEaseIn,
              vsync: this,
              child: Text(
                widget.notificationData?.content ??
                    "Đây là một thông báo thử nghi nghiệm nghiệm nghiệm nghiệmệmn ghiệmệmngh iệmệmn  ghiệmệmng ghiệmệmng ghiệmệmng ghiệmệmng ghiệmệmng ghiệmệmng ghiệmệmng ghiệmệmng ghiệmệmng ghiệmệmng hiệmệm nghiệm",
                maxLines: (_isExpand) ? 10 : 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(
                    fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
            subtitle: Text(
              (_isExpand)
                  ? DateConverter.getTime(
                      widget.notificationData?.postDate ?? 1624536554094)
                  : DateConverter.getTimeInAgo(
                      widget.notificationData?.postDate ?? 1624536554094),
              maxLines: 1,
              style: GoogleFonts.nunitoSans(
                  color: Colors.black54,
                  fontSize: 9,
                  fontWeight: FontWeight.w600),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              iconSize: 20,
              onPressed: widget.onDelete,
            ),
          ),
        ),
      ),
    );
  }
}
