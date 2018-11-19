// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class Mushroom implements Plant {
    @Override
    public float getOxygenAmountPerYear() {
        return 40000;
    }

    @Override
    public int getLifeTime() {
        return 1;
    }
}
