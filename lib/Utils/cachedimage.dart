import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';

class CachedImageLoader extends StatelessWidget {
  final String url;
  CachedImageLoader({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${url}',
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: TColor.primaryColor1,
        ),
      ),
      errorWidget: (context, url, Error) =>
          Image.asset("assets/img/workout1.png"),
    );
  }
}
