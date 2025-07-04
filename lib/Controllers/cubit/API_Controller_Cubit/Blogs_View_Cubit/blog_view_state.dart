part of 'blog_view_cubit.dart';

sealed class BlogsViewState extends Equatable {
  const BlogsViewState();
  @override
  List<Object> get props => [];
}

final class BlogsViewInitial extends BlogsViewState {
  const BlogsViewInitial() : super();
}

final class BlogsViewLoaded extends BlogsViewState {
  final List<BlogsModel> blogs;
  final bool hasMore;
  const BlogsViewLoaded(this.blogs, this.hasMore);
  @override
  List<Object> get props => [blogs, hasMore];
}

final class BlogsViewError extends BlogsViewState {
  final String errorMessage;
  const BlogsViewError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
