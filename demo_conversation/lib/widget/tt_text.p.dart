import 'package:flutter/material.dart';

class TText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final bool softWrap;
  final TextOverflow overflow;
  final int maxLines;
  final String semanticsLabel;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior textHeightBehavior;

  final InlineSpan textSpan;

  const TText(
    this.data, {
    Key key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  })  : assert(
          data != null,
          'A non-null String must be provided to a TText widget.',
        ),
        textSpan = null,
        super(key: key);

  const TText.rich(
    this.textSpan, {
    Key key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
  })  : assert(
          textSpan != null,
          'A non-null TextSpan must be provided to a TText.rich widget.',
        ),
        data = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (textSpan != null) {
      return Text.rich(
        textSpan,
        locale: locale,
        maxLines: maxLines,
        overflow: overflow,
        semanticsLabel: semanticsLabel,
        softWrap: softWrap,
        strutStyle: strutStyle,
        style: style,
        textAlign: textAlign,
        textDirection: textDirection,
        textHeightBehavior: textHeightBehavior,
        textScaleFactor: 1.0,
        textWidthBasis: textWidthBasis,
      );
    }
    return Text(
      data,
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      strutStyle: strutStyle,
      style: style,
      textAlign: textAlign,
      textDirection: textDirection,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: 1.0,
      textWidthBasis: textWidthBasis,
    );
  }
}
