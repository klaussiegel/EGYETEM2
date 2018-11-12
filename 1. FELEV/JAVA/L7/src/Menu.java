// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class Menu {
    private Soup soup;
    private MainDish mainDish;

    public void createMenu(Chef a) {
        this.soup = a.prepareSoup();
        this.mainDish = a.prepareMainDish();
    }

    public static void main(String args[]) {
        Menu x = new Menu();
        Menu y = new Menu();
        IndianChef ic = new IndianChef();
        ChineseChef cc = new ChineseChef();

        x.createMenu(ic);
        y.createMenu(cc);

        x.soup.associateMainDish(x.mainDish);
        y.soup.associateMainDish(y.mainDish);
    }
}
