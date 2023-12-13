import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    required this.movie,
    super.key,
    this.onDismissed,
    this.onTap,
  });

  final Movie movie;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dismissible(
      key: Key('movieListTile_dismissible_${movie.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          movie.overview,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing:
            onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
