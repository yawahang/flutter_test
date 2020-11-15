import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel extends Equatable  {
	@JsonKey(name: 'albumId')
	final int albumId;
	@JsonKey(name: 'id')
	final int id;
	@JsonKey(name: 'title')
	final String title;
	@JsonKey(name: 'url')
	final String url;
	@JsonKey(name: 'thumbnailUrl')
	final String thumbnailUrl;

	AlbumModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

	factory AlbumModel.fromJson(Map<String, dynamic> json) => _$AlbumModelFromJson(json);

	Map<String, dynamic> toJson() => _$AlbumModelToJson(this);

	@override
	List<Object> get props => [
		this.albumId,
		this.id,
		this.title,
		this.url,
		this.thumbnailUrl
	];
}
