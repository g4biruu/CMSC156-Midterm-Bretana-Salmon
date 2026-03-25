class Board {
  static const int size = 9;

  List<List<int>> grid =
      List.generate(size, (_) => List.filled(size, 0));

  // Place a stone and capture opponent stones with no liberties
  bool placeStone(int x, int y, int player) {
    if (grid[y][x] != 0) return false;

    grid[y][x] = player;
    
    // Check and capture opponent stones around this move
    int opponent = player == 1 ? 2 : 1;
    for (var direction in [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
      int nx = x + direction[0];
      int ny = y + direction[1];
      if (isValid(nx, ny) && grid[ny][nx] == opponent) {
        captureIfNoLiberties(nx, ny);
      }
    }

    return true;
  }

  // Check if a position has any empty adjacent spaces (liberties)
  bool hasLiberties(int x, int y) {
    if (!isValid(x, y)) return false;
    int color = grid[y][x];
    if (color <= 0) return false; // Only check actual stones

    Set<String> visited = {};
    return countLiberties(x, y, visited) > 0;
  }

  // Count liberties for a stone group
  int countLiberties(int x, int y, Set<String> visited) {
    String key = '$x,$y';
    if (visited.contains(key)) return 0;
    if (!isValid(x, y)) return 0;

    int color = grid[y][x];
    // Treat both empty (0) and captured stones (negative) as liberties
    if (color == 0 || color < 0) {
      if (isBorder(x, y)) {
        return 0; // Border doesn't count as liberty
      }
      return 1; // Empty space or captured stone is a liberty
    }

    visited.add(key);
    int liberties = 0;

    // Check all directions
    for (var dir in [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
      int nx = x + dir[0];
      int ny = y + dir[1];
      if (isValid(nx, ny)) {
        int neighborColor = grid[ny][nx];
        if (neighborColor == 0 || neighborColor < 0) {
          // Empty or captured space
          if (!isBorder(nx, ny)) {
            liberties++;
          }
        } else if (neighborColor == color) {
          // Same color stone
          liberties += countLiberties(nx, ny, visited);
        }
      }
    }

    return liberties;
  }

  // Capture a stone group if it has no liberties
  void captureIfNoLiberties(int x, int y) {
    if (!hasLiberties(x, y)) {
      removeGroup(x, y);
    }
  }

  // Remove entire group of stones (mark as captured with negative values)
  void removeGroup(int x, int y) {
    if (!isValid(x, y)) return;
    int color = grid[y][x];
    if (color == 0) return;

    // Mark stone as captured (use negative values: -1 for black, -2 for white)
    grid[y][x] = -color;

    // Mark connected stones of same color as captured
    for (var dir in [[-1, 0], [1, 0], [0, -1], [0, 1]]) {
      int nx = x + dir[0];
      int ny = y + dir[1];
      if (isValid(nx, ny) && grid[ny][nx] == color) {
        removeGroup(nx, ny);
      }
    }
  }

  // Check if position is within board bounds
  bool isValid(int x, int y) {
    return x >= 0 && x < size && y >= 0 && y < size;
  }

  // Check if position is on the border (edge) of the board
  bool isBorder(int x, int y) {
    return x == 0 || x == size - 1 || y == 0 || y == size - 1;
  }

  // Count captured stones
  int countCaptures(int player) {
    int count = 0;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (grid[i][j] == player) count++;
      }
    }
    return count;
  }

  void reset() {
    grid = List.generate(size, (_) => List.filled(size, 0));
  }
}