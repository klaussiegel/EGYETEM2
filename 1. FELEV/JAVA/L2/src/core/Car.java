// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package core;

public class Car extends Vehicle {
    private float performance;

    public Car(String a, int b, float c) {
        super(a,b);
        this.performance = c;
    }

    public float getPerformance() {
        return this.performance;
    }

    public void setPerformance(float x) {
        this.performance = x;
    }

    public String toString() {
        String out = this.getAge() + " : " + this.getType() + " : " + this.performance;
        return out;
    }
}
