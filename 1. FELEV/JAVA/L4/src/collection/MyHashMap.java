// Oláh Tamás-Lajos
// otim1750
// 523 / 2

package collection;

import core.Car;

public class MyHashMap {
    private int denominator;
    private Entry[] bucket;

    private int HashFunction(int num) {
        return (num % this.denominator);
    }

    public MyHashMap(int denominator) {
        this.denominator = denominator;
        this.bucket = new Entry[denominator];
    }

    public boolean containsKey(int a) {
        int ind = this.HashFunction(a);
        if (this.bucket[ind]==null) return false;

        Entry curr = this.bucket[ind];
        while (curr.getKey()!=a) {
            curr = curr.getNext();
            if (curr==null) return false;
        }

        return true;
    }

    public void put(int num, Car car) {
        int here = this.HashFunction(num);

        if (bucket[here]==null) {
            bucket[here] = new Entry(num,car);
        } else {
            Entry curr = bucket[here];

            bucket[here] = new Entry(num,car);
            bucket[here].setNext(curr);
        }
    }

    public Car get(int a) {
        int index = this.HashFunction(a);
        Entry curr = this.bucket[index];
        if (curr==null) return null;

        while (curr.getKey()!=a) {
            curr = curr.getNext();
            if (curr==null) return null;
        }

        return curr.getValue();
    }
}
