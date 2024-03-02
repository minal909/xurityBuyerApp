import 'package:dio/dio.dart';
import 'package:xuriti/models/post.dart';

class RemoteServices {
  Future<List<Post>?> getPosts() async {
    List<Post> allPost = [];
    var client = Dio();

    var uri = "https://jsonplaceholder.typicode.com/posts";
   // print(uri);
    var response = await client.get(uri);
  //  print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> json = response.data;
      // json is <List<Map<String, dynamic>>>
      // loop json it returns Map<String, dynamic>

      json.forEach((data) {
      //  print(data);
        // inside loop convert Map<String, dynamic> to postModel
        // add each postModel to allPost
        Post post = Post.fromJson(data);
        allPost.add(post);
      });

      // after loop return the allPost
      return allPost;
    }
    return null;
  }

// post(String url,Map<String, dynamic>data, String? token){
//   var client = Dio();
//   if(token == null){
//     var
//   }
// }

}
