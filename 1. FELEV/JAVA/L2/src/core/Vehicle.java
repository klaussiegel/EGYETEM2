// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package core;

public class Vehicle {
    private String type;
    private int age;

    public Vehicle(String a, int b) {
        this.type = a;
        this.age = b;
    }

    public String getType() {
        return this.type;
    }

    public void setType(String x) {
        this.type = x;
    }

    public int getAge() {
        return this.age;
    }

    public void setAge(int x) {
        this.age = x;
    }
}
