// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package core;

public class Car {
    private String type;
    private int age;

    public Car(String type, int age) {
        this.type = type;
        this.age = age;
    }

    public String getType() {
        return type;
    }

    public int getAge() {
        return age;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setAge(int age) {
        this.age = age;
    }

    @Override
    public String toString() {
        return "\nCar {" +
                "\n\ttype: \"" + type + "\"," +
                "\n\tage: " + age + "\n}\n";
    }
}
