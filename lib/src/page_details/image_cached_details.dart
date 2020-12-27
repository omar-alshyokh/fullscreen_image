import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen_image/src/utils/app_config.dart';

class ImageCachedDetails extends StatefulWidget {
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
  final Widget placeholder;
  final bool withHero;
  const ImageCachedDetails(
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
        this.placeholder,
        this.withHero,

      })
      : assert(image != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageCachedDetailsState();
  }
}

class _ImageCachedDetailsState extends State<ImageCachedDetails>
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
    return CachedNetworkImage(
      imageUrl: widget.image ?? '',
      width: widget.width,
      height: widget.height,
      fadeOutDuration: Duration(milliseconds: 500),
      fadeInCurve: Curves.easeInOut,
      fadeInDuration: Duration(milliseconds: 500),
      fadeOutCurve: Curves.easeInOut,
      fit: widget.fit,
      placeholder: (context, _) {
        return widget.placeholder ?? Container(
            width: widget.width,
            height: widget.height,
            child: Image.asset(
              'assets/default_image.png',
              fit: widget.fit ,
              width: widget.width,
              height: widget.height,
            ));
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
