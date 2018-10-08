// Oláh Tamás-Lajos
// otim1750
// 523 / 2

import collection.CarList;
import core.Car;

public class TestCarList {
    public static void main(String[] args) {
        Car one = new Car("Volvo V40 1.9 TDI",16,116);
        Car two = new Car("Volkswagen Golf GTI",8,212);
        Car three = new Car("1968 Chevy Impala",50,480);
        Car four = new Car("Skoda Rapid 1.6 TDI",3,116);
        Car five = new Car("1978 Dacia 1300",40,54);

        CarList lista = new CarList(5);

            try {
                lista.addCar(one);
                lista.addCar(two);
                lista.addCar(three);
                lista.addCar(four);
                lista.addCar(five);
            } catch (Exception e) {
                e.printStackTrace();
            }

        System.out.println();

        CarList.CarIterator i = lista.getIterator();

        while (i.hasMoreElements()) {
            try {
                Car a = i.nextElement();
                System.out.println(a.toString());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}