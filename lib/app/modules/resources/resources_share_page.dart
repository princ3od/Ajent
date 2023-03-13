import 'package:ajent/app/data/models/resource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/themes/widget_theme.dart';
import '../../data/models/ajent_user.dart';
import '../../data/models/message.dart';
import '../../data/services/user_service.dart';
import '../../global_widgets/shareable_user_item.dart';

class ResourceSharePage extends StatefulWidget {
  ResourceSharePage({Key key, @required this.resource}) : super(key: key);

  final Resource resource;

  @override
  State<ResourceSharePage> createState() => _ResourceSharePageState();
}

class _ResourceSharePageState extends State<ResourceSharePage> {
  final TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Share resources',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.copy),
                title: Text('Copy link'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.resource.url));
                  Get.snackbar(
                    'Copied',
                    'Link has been copied to clipboard',
                    snackPosition: SnackPosition.TOP,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  controller: txtSearch,
                  decoration: searchTextfieldDecoration.copyWith(
                    hintText: 'Search for people',
                    prefixIcon: Icon(Icons.search),
                  ),
                  style: GoogleFonts.nunitoSans(fontSize: 14),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {});
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: UserService.instance
                      .searchUser(keyword: txtSearch.text.trim().toLowerCase()),
                  builder: (context, snapshot) {
                    if (txtSearch.text.isEmpty) {
                      return Container();
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: ListTileShimmer(),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length +
                          ((snapshot.connectionState == ConnectionState.waiting)
                              ? 2
                              : 0),
                      itemBuilder: (context, index) {
                        if ((snapshot.connectionState ==
                                ConnectionState.waiting) &&
                            index > snapshot.data.docs.length - 1)
                          return ProfileShimmer();

                        AjentUser user = AjentUser.fromJson(
                            snapshot.data.docs[index].id,
                            snapshot.data.docs[index].data());
                        return Listener(
                          onPointerDown: (e) =>
                              FocusManager.instance.primaryFocus.unfocus(),
                          child: ShareableUserItem(
                            user: user,
                            attachmentId: widget.resource.id,
                            type: MessageType.resource,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
