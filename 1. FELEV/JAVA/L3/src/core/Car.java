// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package core;

public class Car implements Vehicle {
    private String type;
    private int age;

    public Car(String type, int age) {
        this.type = type;
        this.age = age;
    }

    @Override
    public String toString() {
        return this.type+" - "+age;
    }

    @Override
    public void numberOfWheels() {
        System.out.println("The car has 4 wheels.");
    }
}
