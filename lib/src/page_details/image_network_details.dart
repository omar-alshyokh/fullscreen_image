import 'package:custom_full_image_screen/src/utils/app_config.dart';
import 'package:flutter/material.dart';

class ImageNetworkDetails extends StatefulWidget {
  final String image;
  final String? tag;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? appBarBackgroundColorDetails;
  final Color? backgroundColorDetails;
  final Color? iconBackButtonColor;
  final bool hideBackButtonDetails;
  final bool hideAppBarDetails;
  final bool withHero;

  const ImageNetworkDetails({
    Key? key,
    required this.image,
    this.tag,
    required this.height,
    required this.width,
    required this.fit,
    required this.backgroundColorDetails,
    required this.appBarBackgroundColorDetails,
    required this.hideBackButtonDetails,
    required this.hideAppBarDetails,
    required this.iconBackButtonColor,
    required this.withHero,
  })   : assert(!withHero && (tag != null)),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageNetworkDetailsState();
  }
}

class _ImageNetworkDetailsState extends State<ImageNetworkDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColorDetails ?? Colors.transparent,
      appBar: !widget.hideAppBarDetails
          ? AppBar(
              backgroundColor:
                  widget.appBarBackgroundColorDetails ?? Colors.transparent,
              iconTheme: IconThemeData(
                  color: widget.iconBackButtonColor ?? Colors.white),
              automaticallyImplyLeading: !widget.hideBackButtonDetails,
            )
          : null,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          color: widget.backgroundColorDetails ?? Colors.black.withOpacity(0.9),
          padding: const EdgeInsets.all(8.0),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: widget.withHero && appConfig.notNullOrEmpty(widget.tag!)
                ? Hero(tag: widget.tag!, child: _buildImage())
                : _buildImage(),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Image.network(
      widget.image ,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
