// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class ChineseChef implements Chef {
    @Override
    public Soup prepareSoup() {
        return new KlangBakKutTehSoup();
    }

    @Override
    public MainDish prepareMainDish() {
        return new KungPaoChicken();
    }
}
