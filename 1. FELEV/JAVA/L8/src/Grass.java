// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class Grass implements Plant {
    @Override
    public float getOxygenAmountPerYear() {
        return 30800;
    }

    @Override
    public int getLifeTime() {
        return 1;
    }
}
