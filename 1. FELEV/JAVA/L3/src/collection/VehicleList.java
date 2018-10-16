// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package collection;

import core.Vehicle;

public class VehicleList {
    private int current;
    private Vehicle[] vehicles;

    public class VehicleForwardIterator implements VehicleIterator {
        private int index;

        public VehicleForwardIterator() throws Exception {
            if (VehicleList.this.current == 0) throw new Exception("Empty list!");
            this.index = 0;
        }

        @Override
        public boolean hasMoreElements() {
            return (this.index<VehicleList.this.current);
        }

        @Override
        public Vehicle nextElement() {
            return (this.hasMoreElements()) ? VehicleList.this.vehicles[this.index++] : null;
        }
    }

    public class VehicleBackwardIterator implements VehicleIterator {
        private int index;

        public VehicleBackwardIterator() throws Exception {
            if ((this.index = VehicleList.this.current-1) < 0) throw new Exception("Empty List");
        }

        @Override
        public boolean hasMoreElements() {
            return (this.index>=0);
        }

        @Override
        public Vehicle nextElement() {
            return (this.hasMoreElements()) ? VehicleList.this.vehicles[this.index--] : null;
        }
    }

    public VehicleList(int size) {
        this.vehicles = new Vehicle[size];
        this.current = 0;
    }

    public void addVehicle(Vehicle a) throws Exception {
        if (this.current==this.vehicles.length) throw new Exception("List full!");
        else {
            this.vehicles[current] = a;
            this.current++;
        }
    }

    public VehicleIterator getForwardIterator() throws Exception {
        return new VehicleForwardIterator();
    }

    public VehicleIterator getBackwardIterator() throws Exception {
        return new VehicleBackwardIterator();
    }
}
