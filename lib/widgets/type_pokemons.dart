import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokemon/models/pokemon_type.dart';

class TypePokemons extends StatefulWidget {
  final PokemonType type;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const TypePokemons(
      this.type, {
        required this.onChanged,
        this.initialValue = false,
        Key? key,
      }) : super(key: key);

  @override
  _PokemonTypeChipState createState() => _PokemonTypeChipState();
}

class _PokemonTypeChipState extends State<TypePokemons> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      onSelected: (value) {
        widget.onChanged(value);
        setState(() => _isSelected = value);
      },
      selected: _isSelected,
      label: Text(widget.type.name),
      avatar: CachedNetworkImage(imageUrl: widget.type.imageUrl),
    );
  }
}
