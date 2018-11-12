// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class KlangBakKutTehSoup implements Soup{

    @Override
    public void associateMainDish(MainDish x) {
        System.out.println("A(z) Klang Bak Kut Teh leveshez a(z) "+x+" foetelt tarsitottam.");
    }

    @Override
    public String toString() {
        return "Klang Bak Kut Teh Soup";
    }
}
