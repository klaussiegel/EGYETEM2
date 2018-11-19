// Oláh Tamás-Lajos
// otim1750
// 523 / 2

import java.util.HashSet;
import java.util.Iterator;

public class Field implements Plant {
    private HashSet<Plant> elems = new HashSet<Plant>();

    public void add(Plant x) {
        this.elems.add(x);
    }

    public void remove(Plant x) {
        this.elems.remove(x);
    }

    @Override
    public float getOxygenAmountPerYear() {
        Iterator<Plant> it = this.elems.iterator();
        float sum = 0;

        while (it.hasNext()) {
            Plant x = it.next();
            sum += x.getOxygenAmountPerYear();
        }

        return sum;
    }

    @Override
    public int getLifeTime() {
        Iterator<Plant> it = this.elems.iterator();
        int max = 0;

        while (it.hasNext()) {
            Plant x = it.next();

            if (x.getLifeTime()>max) max = x.getLifeTime();
        }

        return max;
    }
}
