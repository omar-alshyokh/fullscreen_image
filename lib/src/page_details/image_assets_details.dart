import 'package:flutter/material.dart';
import 'package:custom_full_image_screen/src/utils/app_config.dart';

class ImageAssetsDetails extends StatefulWidget {
  final String image;
  final String tag;
  final double width;
  final double height;
  final BoxFit fit;
  final Color appBarBackgroundColorDetails;
  final Color backgroundColorDetails;
  final Color iconBackButtonColor;
  final bool hideBackButtonDetails;
  final bool hideAppBarDetails;
  final bool withHero;


  const ImageAssetsDetails(
      {Key key,
        @required this.image,
        this.tag,
        this.height,
        this.width,
        this.fit,
        this.backgroundColorDetails,
        this.appBarBackgroundColorDetails,
        this.hideBackButtonDetails ,
        this.hideAppBarDetails ,
        this.iconBackButtonColor,
        this.withHero

      })
      : assert(image != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageAssetsDetailsState();
  }
}

class _ImageAssetsDetailsState extends State<ImageAssetsDetails>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
      appBar: !widget.hideAppBarDetails ?
      AppBar(
        backgroundColor: widget.appBarBackgroundColorDetails ?? Colors.transparent,
        iconTheme: IconThemeData(
          color: widget.iconBackButtonColor ?? Colors.white
        ),
        automaticallyImplyLeading: !widget.hideBackButtonDetails,
      ) : null,
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
            child: widget.withHero && appConfig.notNullOrEmpty(widget.tag)?
            Hero(
              tag: widget.tag,
              child: _buildImage()
            ):_buildImage(),
          ),
        ),
      ),
    );
  }

  Widget _buildImage (){
    return Image.asset(
      widget.image ?? '',
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
