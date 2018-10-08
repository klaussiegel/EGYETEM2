import java.io.*;

// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class Main {
    public static char Convert(char x) {
        return (Character.isUpperCase(x)) ? Character.toLowerCase(x) : Character.toUpperCase(x);
    }

    public static void main(String[] args) {
        System.out.println();

        for (String a : args) {
            String aa = new String();
            for (char x : a.toCharArray()) {
                aa+=Convert(x);
            }
            System.out.println(aa);
        }
    }
}