public class PlayerScript {

    private int life;
    private int points;

    public PlayerScript() : this(3, 0) { }

    public PlayerScript(int life, int points) {
        this.life = life;
        this.points = points;
    }

    public int GetLife() {
        return this.life;
    }

    public int GetPoints() {
        return this.points;
    }

}
