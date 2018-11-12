// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class AlmondSoup implements Soup {
    @Override
    public void associateMainDish(MainDish x) {
        System.out.println("A(z) Almond Soup leveshez a(z) "+x+" foetelt tarsitottam.");
    }

    @Override
    public String toString() {
        return "Almond Soup";
    }
}
