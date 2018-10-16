// Oláh Tamás-Lajos
// otim1750
// 523 / 2

import collection.*;
import core.Airplane;
import core.Car;
import core.Vehicle;

public class TestVehicleList {
    public static void main(String args[]) {

        // Creating Car objects
        Car auto1 = new Car("Volvo V40",16);
        Car auto2 = new Car("Volvo V50",10);
        Car auto3 = new Car("1969 Chevy Impala",49);
        Car auto4 = new Car("Tesla Model S",6);

        // Creating Airplane objects
        Airplane rep1 = new Airplane("Airbus A330-200",24,59.0f);
        Airplane rep2 = new Airplane("Boeing 747-8",48,70.6f);
        Airplane rep3 = new Airplane("Lockhead U-2S",61,19.2f);
        Airplane rep4 = new Airplane("Antonov An-225 Mriya",33,84.0f);

        // Creating VehicleList object
        VehicleList lista = new VehicleList(8);

        // Adding Vehicle objects to the list
        try {
            lista.addVehicle(auto1);
            lista.addVehicle(auto2);
            lista.addVehicle(auto3);
            lista.addVehicle(auto4);

            lista.addVehicle(rep1);
            lista.addVehicle(rep2);
            lista.addVehicle(rep3);
            lista.addVehicle(rep4);
        } catch (Exception e) {
            System.out.println(e.toString());
        }


        // Iterating through the list forward

        System.out.println("\n\nFORWARD\n\n");

        try {
            VehicleIterator i = lista.getForwardIterator();

            Vehicle x;

            while ((x=i.nextElement())!=null) {
                System.out.print("\t"+x.toString()+"\n\t");
                x.numberOfWheels();
                System.out.println();
            }

        } catch (Exception e) {
            System.out.println(e.toString());
        }


        // Iterating through the list backwards

        System.out.println("\n\nBACKWARD\n\n");

        try {
            VehicleIterator i = lista.getBackwardIterator();

            Vehicle x;

            while ((x=i.nextElement())!=null) {
                System.out.print("\t"+x.toString()+"\n\t");
                x.numberOfWheels();
                System.out.println();
            }

        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }
}
