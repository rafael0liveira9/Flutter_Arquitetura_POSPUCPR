import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/movie_model.dart';
import '../../presentation/screens/movie_detail_screen.dart';
import '../../data/services/local_storage_service.dart';

class FavoriteCard extends StatefulWidget {
  final Movie movie;

  const FavoriteCard({Key? key, required this.movie}) : super(key: key);

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  bool isFavorite = false;
  late LocalStorageService localStorageService;

  @override
  void initState() {
    super.initState();
    _initializeLocalStorage();
  }

  Future<void> _initializeLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    localStorageService = LocalStorageService(prefs);
    await _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    List<Movie> favoriteMovies = await localStorageService.getFavoriteMovies();

    setState(() {
      isFavorite = favoriteMovies.any((movie) => movie.id == widget.movie.id);
    });
  }

  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      await localStorageService.removeFavoriteMovie(widget.movie);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${widget.movie.title} foi removido dos favoritos!')),
      );
    } else {
      await localStorageService.addFavoriteMovie(widget.movie);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('${widget.movie.title} foi adicionado aos favoritos!')),
      );
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isFavorite) {
      return Container();
    }

    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 4,
          color: const Color.fromARGB(255, 22, 22, 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(),
                  settings: RouteSettings(arguments: widget.movie),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.movie.posterUrl!,
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 150,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.error),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.movie.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 207, 207, 207)),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                              size: 16,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.movie.rating.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
