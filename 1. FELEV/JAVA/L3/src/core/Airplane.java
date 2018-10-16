// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package core;

public class Airplane implements Vehicle {
    private String type;
    private int age;
    private float length;

    public Airplane(String type, int age, float length) {
        this.type = type;
        this.age = age;
        this.length = length;
    }

    @Override
    public String toString() {
        return this.type+" - "+this.age+" - "+this.length;
    }

    @Override
    public void numberOfWheels() {
        System.out.println("The airplane has at least 10 wheels...");
    }
}
