// Oláh Tamás-Lajos
// otim1750
// 523 / 2

import java.util.ArrayList;

public class Forest implements Plant {
    private ArrayList<Plant> elems = new ArrayList<Plant>();

    public void add(Plant x) {
        this.elems.add(x);
    }

    public void remove(Plant x) {
        this.elems.remove(x);
    }

    public Plant getChild(int i) {
        return this.elems.get(i);
    }

    @Override
    public float getOxygenAmountPerYear() {
        float sum = 0;
        for (Plant x : this.elems) {
            sum += x.getOxygenAmountPerYear();
        }

        return sum;
    }

    @Override
    public int getLifeTime() {
        int max = 0;
        for (Plant x : this.elems) {
            if (x.getLifeTime()>max) max = x.getLifeTime();
        }

        return max;
    }
}
