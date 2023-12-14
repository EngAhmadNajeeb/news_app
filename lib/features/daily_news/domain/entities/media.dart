import 'package:equatable/equatable.dart';

class MediaEntity extends Equatable {
  final int mId;
  final String mUrl;
  final int mHeight;
  final int mWidth;
  final String mType;
  const MediaEntity({
    this.mId = 0,
    this.mUrl = '',
    this.mHeight = 0,
    this.mWidth = 0,
    this.mType = '',
  });

  @override
  List<Object?> get props {
    return [
      mUrl,
      mHeight,
      mWidth,
      mType,
    ];
  }
}
