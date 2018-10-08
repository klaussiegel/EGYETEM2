import java.io.*;

// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class Main {
    public static void main(String[] args) {
        System.out.println("\n");

        int n = 10;

        try {
            if (args.length>0) n = Integer.parseInt(args[0]);
        } catch (Exception e) {
            System.out.println("\n\nArgument is NaN!\n\n");
            return;
        }

        Integer[][] a = new Integer[n][];
        int counter = 1;

        for (int i=0; i<a.length; ++i) {
            a[i] = new Integer[i+1];
            for (int j=0; j<a[i].length; ++j) {
                a[i][j] = counter++;
            }
        }

        System.out.println("n = "+n+"\n");

        for (int i=0; i<a.length; ++i) {
            for (int j=0; j<a[i].length; ++j) {
                System.out.print(""+a[i][j]+" ");
            }
            System.out.println();
        }
    }
}