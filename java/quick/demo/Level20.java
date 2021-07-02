package demo;

public enum Level20 {
  HIGH (3),
  MEDIUM(2),
  LOW(1);

  private final int levelCode;
  Level20(int levelCode) {
    this.levelCode = levelCode;
  }
  public int getLevelCode() {
    return this.levelCode;
  }
}
