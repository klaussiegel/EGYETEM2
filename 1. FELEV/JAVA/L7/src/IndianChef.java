// Oláh Tamás-Lajos
// otim1750
// 523 / 2

public class IndianChef implements Chef {
    @Override
    public Soup prepareSoup() {
        return new AlmondSoup();
    }

    @Override
    public MainDish prepareMainDish() {
        return new ChickpeaCurry();
    }
}
