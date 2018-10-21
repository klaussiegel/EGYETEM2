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

    public boolean containsKey(int key) {
        return (this.bucket[this.HashFunction(key)]!=null);
    }

    public void put(int num, Car car) {
        int here = this.HashFunction(num);

        if (bucket[here]==null) {
            bucket[here] = new Entry(num,car,null);
        } else {
            Entry curr = bucket[here];

            while (curr.getNext()!=null) {
                curr = curr.getNext();
            }

            curr.setNext(new Entry(num,car,null));
        }
    }

    public Car get(int a) {
        int index = this.HashFunction(a);
        Entry curr = this.bucket[index];

        if (curr==null) return null;

        while (curr.getKey()!=a && curr==null) {
            curr = curr.getNext();
        }

        if (curr==null) return null;
        else return curr.getValue();
    }
}
