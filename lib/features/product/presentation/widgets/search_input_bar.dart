import 'package:flutter/material.dart';

class SearchInputBar extends StatefulWidget {
  const SearchInputBar({
    required this.isDark,
    required this.onChangeDarkMode,
    required this.onChangeSearch,
    super.key,
  });

  final bool isDark;
  final void Function() onChangeDarkMode;
  final void Function(String) onChangeSearch;

  @override
  State<SearchInputBar> createState() => _SearchInputBarState();
}

class _SearchInputBarState extends State<SearchInputBar> {
  String _searchVaule = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            widget.onChangeSearch(_searchVaule);
          }
        },
        child: SearchBar(
          padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          onTap: () {},
          onChanged: (value) {
            setState(() {
              _searchVaule = value;
            });
          },
          leading: const Icon(Icons.search),
          trailing: <Widget>[
            Tooltip(
              message: 'Change brightness mode',
              child: IconButton(
                isSelected: widget.isDark,
                onPressed: widget.onChangeDarkMode,
                icon: const Icon(Icons.wb_sunny_outlined),
                selectedIcon: const Icon(Icons.brightness_2_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
