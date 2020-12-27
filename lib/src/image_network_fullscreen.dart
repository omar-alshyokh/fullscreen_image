import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'page_details/image_network_details.dart';
import 'utils/app_config.dart';

class ImageNetworkFullscreen extends StatefulWidget {
  final String imageUrl;
  final double imageHeight;
  final double imageWidth;
  final double imageDetailsWidth;
  final double imageDetailsHeight;
  final BoxFit imageFit;
  final BoxFit imageDetailsFit;
  final double imageBorderRadius;
  final Color appBarBackgroundColorDetails;
  final Color backgroundColorDetails;
  final Color iconBackButtonColor;
  final bool hideBackButtonDetails;
  final bool hideAppBarDetails;
  final bool withHeroAnimation;

  const ImageNetworkFullscreen({
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
    this.hideAppBarDetails = false,
    this.withHeroAnimation = false,
  })  : assert(imageUrl != null),
        super(key: key);

  @override
  _ImageNetworkFullscreenState createState() => _ImageNetworkFullscreenState();
}

class _ImageNetworkFullscreenState extends State<ImageNetworkFullscreen>
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
              tag: '${widget.imageUrl + imgTag}',
              withHero: widget.withHeroAnimation);
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
          child: Image.network(
            widget.imageUrl ?? '',
            width: widget.imageWidth,
            height: widget.imageHeight,
            fit: widget.imageFit ?? BoxFit.cover,
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
  }) async {
    final page = ImageNetworkDetails(
      image: image,
      tag: tag,
      withHero: withHero,
      height: height,
      width: width,
      fit: fit,
      appBarBackgroundColorDetails: appBarBackgroundColorDetails,
      backgroundColorDetails: backgroundColorDetails,
      hideBackButtonDetails: hideBackButtonDetails,
      iconBackButtonColor: iconBackButtonColor,
      hideAppBarDetails: hideAppBarDetails,
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
