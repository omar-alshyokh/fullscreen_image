import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'page_details/image_cached_details.dart';
import 'utils/app_config.dart';

class ImageCachedFullscreen extends StatefulWidget {
  /// image url
  final String imageUrl;

  /// image height
  final double imageHeight;

  /// image width
  final double imageWidth;

  /// image details width
  final double imageDetailsWidth;

  /// image details height
  final double imageDetailsHeight;

  /// image BoxFit
  final BoxFit imageFit;

  /// image details BoxFit
  final BoxFit imageDetailsFit;

  /// image border radius
  final double imageBorderRadius;

  /// appBar details color
  final Color appBarBackgroundColorDetails;

  /// background color details
  final Color backgroundColorDetails;

  /// icon details color
  final Color iconBackButtonColor;

  /// to hide arrow back icon in page details
  final bool hideBackButtonDetails;

  /// to hide arrow appbar in page details
  final bool hideAppBarDetails;

  /// if you need to use hero animation
  final bool withHeroAnimation;

  /// custom error widget
  final Widget errorWidget;

  /// custom placeholder widget
  final Widget placeholder;

  /// custom placeholder inside page details widget
  final Widget placeholderDetails;

  const ImageCachedFullscreen({
    Key key,
    @required this.imageUrl,
    this.imageHeight = 50.0,
    this.imageWidth = 50.0,
    this.imageDetailsHeight = double.infinity,
    this.imageDetailsWidth = double.infinity,
    this.imageDetailsFit = BoxFit.fill,
    this.imageFit = BoxFit.fill,
    this.imageBorderRadius = 0.0,
    this.appBarBackgroundColorDetails = Colors.transparent,
    this.backgroundColorDetails = Colors.black,
    this.iconBackButtonColor = Colors.white,
    this.hideBackButtonDetails = false,
    this.errorWidget,
    this.placeholder,
    this.placeholderDetails,
    this.hideAppBarDetails = false,
    this.withHeroAnimation = false,
  })  : assert(imageUrl != null),
        super(key: key);

  @override
  _ImageCachedFullscreenState createState() => _ImageCachedFullscreenState();
}

class _ImageCachedFullscreenState extends State<ImageCachedFullscreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  static final uuid = Uuid();
  final String imgTag = uuid.v4();

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (appConfig.notNullOrEmpty(widget.imageUrl))
          _goToDetail(
              image: widget.imageUrl,
              width: widget.imageDetailsWidth,
              height: widget.imageDetailsHeight,
              fit: widget.imageDetailsFit,
              appBarBackgroundColorDetails: widget.appBarBackgroundColorDetails,
              backgroundColorDetails: widget.backgroundColorDetails,
              hideBackButtonDetails: widget.hideBackButtonDetails,
              iconBackButtonColor: widget.iconBackButtonColor,
              hideAppBarDetails: widget.hideAppBarDetails,
              placeholderDetails: widget.placeholderDetails,
              withHero: widget.withHeroAnimation,
              tag: '${widget.imageUrl + imgTag}');
      },
      child: widget.withHeroAnimation
          ? Hero(tag: '${widget.imageUrl + imgTag}', child: _buildImage())
          : _buildImage(),
    );
  }

  _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.imageBorderRadius),
      child: Container(
          width: widget.imageWidth,
          height: widget.imageHeight,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl ?? '',
            width: widget.imageWidth,
            height: widget.imageHeight,
            fadeOutDuration: Duration(milliseconds: 500),
            fadeInCurve: Curves.easeInOut,
            fadeInDuration: Duration(milliseconds: 500),
            fadeOutCurve: Curves.easeInOut,
            fit: widget.imageFit ?? BoxFit.cover,
            placeholder: (context, _) {
              return widget.placeholder ??
                  Container(
                      width: widget.imageWidth,
                      height: widget.imageHeight,
                      child: Image.asset(
                        'assets/default_image.png',
                        fit: widget.imageFit ?? BoxFit.fill,
                        width: widget.imageWidth,
                        height: widget.imageHeight,
                      ));
            },
            errorWidget: (context, url, error) =>
                widget.errorWidget ??
                Container(
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  child: Image.asset(
                    'assets/default_image.png',
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                    fit: widget.imageFit ?? BoxFit.fill,
                  ),
                ),
          )),
    );
  }

  void _goToDetail({
    String image,
    String tag,
    double width,
    double height,
    BoxFit fit,
    Color appBarBackgroundColorDetails,
    Color backgroundColorDetails,
    Color iconBackButtonColor,
    bool hideBackButtonDetails,
    bool hideAppBarDetails,
    bool withHero,
    Widget placeholderDetails,
  }) async {
    final page = ImageCachedDetails(
      image: image,
      tag: tag,
      height: height,
      width: width,
      fit: fit,
      withHero: withHero,
      appBarBackgroundColorDetails: appBarBackgroundColorDetails,
      backgroundColorDetails: backgroundColorDetails,
      hideBackButtonDetails: hideBackButtonDetails,
      iconBackButtonColor: iconBackButtonColor,
      hideAppBarDetails: hideAppBarDetails,
      placeholder: placeholderDetails,
    );
    await Navigator.of(context).push(
      PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: page,
          );
        },
        transitionDuration: Duration(milliseconds: 700),
      ),
    );
  }
}
