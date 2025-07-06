import 'package:bloc/bloc.dart';
import 'package:ecowin/Models/Blogs%20Models/blogs_model.dart';
import 'package:ecowin/api/Services/Green_Guide_Services/blogs_service.dart';
import 'package:equatable/equatable.dart';
part 'blog_view_state.dart';

class BlogsViewCubit extends Cubit<BlogsViewState> {
  int page = 1;

  BlogsViewCubit() : super(BlogsViewInitial());

  Future<void> fetchBlogs() async {
    try {
      final List<BlogsModel> blogs = await BlogsService().fetchBlogs(page);
      if (blogs.length < 5) {
        if (!isClosed) emit(BlogsViewLoaded(blogs, false));
        return;
      }
      if (!isClosed) emit(BlogsViewLoaded(blogs, true));
    } catch (e) {
      if (!isClosed) emit(BlogsViewError("There was an Error Getting blogs."));
    }
  }

  Future<void> fetchMoreBlogs() async {
    if (state is BlogsViewLoaded) {
      final currentState = state as BlogsViewLoaded;
      if (!currentState.hasMore) return;
      try {
        page++;
        final List<BlogsModel> newblogs = await BlogsService().fetchBlogs(page);
        final allblogs = [
          ...currentState.blogs,
          ...newblogs,
        ];
        final hasMore = newblogs.isNotEmpty;
        if (!isClosed) {
          emit(BlogsViewLoaded(allblogs, hasMore));
        }
      } catch (e) {
        if (!isClosed) {
          emit(BlogsViewLoaded((state as BlogsViewLoaded).blogs, false));
        }
      }
    }
  }
}
