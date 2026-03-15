class Board {

  static const int size = 9;

  List<List<int>> grid =
      List.generate(size, (_) => List.filled(size, 0));

  bool placeStone(int x, int y, int player) {
    if (grid[y][x] != 0) return false;

    grid[y][x] = player;
    return true;
  }

  void reset() {
    grid = List.generate(size, (_) => List.filled(size, 0));
  }
}