import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
    required this.onSearch,
    required this.hintText,
  });

  final void Function(String keyword) onSearch;
  final String hintText;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 188, 188, 188),
            blurRadius: 10,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          filled: true,
          hintText: widget.hintText,
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => widget.onSearch(_controller.text),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onSubmitted: widget.onSearch,
      ),
    );
  }
}
