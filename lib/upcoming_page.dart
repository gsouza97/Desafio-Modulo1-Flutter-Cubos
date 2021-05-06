import 'package:flutter/material.dart';
import 'package:movies_app/movie_controller.dart';
import 'package:movies_app/widgets/category_widgets.dart';
import 'utils/app_text_styles.dart';

class UpComingPage extends StatefulWidget {
  @override
  _UpComingPageState createState() => _UpComingPageState();
}

class _UpComingPageState extends State<UpComingPage> {
  final controller = MovieController();

  @override
  void initState() {
    super.initState();
    controller.getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
        future: controller.movies,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: CategoryWidget(
                movies: snapshot.data.movies,
                category: 'Lançamentos',
              ),
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text(
                snapshot.error.toString(),
                style: AppTextStyles.body,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      controller.getUpComingMovies();
                    });
                  },
                  child: Text('Tentar Novamente'),
                )
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
