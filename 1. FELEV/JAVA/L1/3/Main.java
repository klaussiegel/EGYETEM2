import java.io.*;

// Ol??h Tam??s-Lajos
// otim1750
// 523 / 2

public class Main{
    public static void main(String[] args) {
        // ELSO VALTOZAT

        // int sum = 0;

        // for (String a : args) {
        //     try {
        //         int i = Integer.parseInt(a);
        //         sum += i;
        //     } catch (Exception e) {
        //         System.out.println("Invalid number format!");
        //     }
        // }

        // System.out.println("The sum of the arguments: "+sum);

        // MASODIK VALTOZAT

        // int sum = 0;

        // for (String a : args) {
        //     Boolean mehet = true;
        //     double i=0;

        //     try {
        //         i = Double.parseDouble(a);
        //     } catch (Exception e) {
        //         mehet = false;
        //     }

        //     if (mehet) sum+=i;
        // }

        // System.out.println("Sum of the valid numerical arguments: "+sum);


        // HARMADIK VALTOZAT
        int sum_paros = 0;
        int sum_paratlan = 0;

        for (String x : args) {
            int a;
            try {
                a = Integer.parseInt(x);
            } catch (Exception e) {
                System.out.println("Invalid number format!");
                a = 0;
            }

            if (a%2==0) sum_paros+=a;
            else sum_paratlan+=a;
        }

        System.out.println("\nThe sum of the even-indexed arguments: "+sum_paros+"\nThe sum of the odd-indexed arguments: "+sum_paratlan);
    }
}