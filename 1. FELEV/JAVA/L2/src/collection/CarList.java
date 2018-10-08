// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package collection;
import core.Car;

public class CarList {
    private int current;
    private Car[] cars;

    public class CarIterator {
        private int index;

        public CarIterator() {
            this.index = 0;
        }

        public boolean hasMoreElements() {
            return (this.index<current);
        }

        public Car nextElement() throws Exception {
            if (this.hasMoreElements()) {
                return cars[index++];
            } else throw new Exception();
        }
    }

    public CarList(int size) {
        this.cars = new Car[size];
        this.current = 0;
    }

    public void addCar(Car a) throws Exception {
        if (this.current>=this.cars.length) {
            throw new Exception();
        }

        this.cars[current] = a;
        this.current++;
    }

    public CarIterator getIterator() {
        return new CarIterator();
    }
}
