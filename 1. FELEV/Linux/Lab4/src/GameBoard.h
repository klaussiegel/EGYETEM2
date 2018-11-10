#ifndef __GameBoard_h__
#define __GameBoard_h__

#include <iostream>
#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <semaphore.h>
#include <string>
#include <deque>
#include "SharedMemory.h"
#include "Ship.h"
#include "auxiliary.h"

using namespace std;

class GameBoard {
    private:
        int** a;
        int size;
        deque<Ship> ships;

    public:
        GameBoard() {
            this->size = 12;
            this->a = new int*[this->size];

            for (int i=0; i<this->size; i++) {
                this->a[i] = new int[this->size];

                for (int j=0; j<this->size; j++) {
                    a[i][j] = EMPTY;
                }
            }
        }

        ~GameBoard() {
            for (int i=0; i<this->size; i++) {
                delete [] this->a[i];
            }

            delete [] this->a;
        }

        void zero() {
            for (int i=0; i<this->size; i++) {
                for (int j=0; j<this->size; j++) {
                    a[i][j] = EMPTY;
                }
            }

            this->ships.clear();
        }

        void addShip(int type, index st, int v_h) {
            try {
                Ship x(type,st,v_h);
                this->ships.push_back(x);

                deque<index> seged = x.getPoz();

                for (index k : seged) {
                    this->a[k.i][k.j] = MY;
                }
            } catch (string e) {
                throw e;
            }
        }

        void addShip(Ship x) {
            this->ships.push_back(x);
        }

        void destroyShip(Ship x) {
            deque<index> k = x.getPoz();

            for (index aa : k) {
                this->a[aa.i][aa.j] = R_HIT;
            }
        }

        int getInd(int i,int j) {
            if (i<0 || i>=this->size || j<0 || j>=this->size) throw "Out of bounds!";

            return this->a[i][j];
        }

        void setInd(int i, int j, int value) {
            if (i<0 || i>=this->size || j<0 || j>=this->size) throw "Out of bounds!";
            this->a[i][j] = value;
        }

        void printB() {
            cout << "\n\n";
            for (int i=0; i<this->size; i++) {
                cout << "\t";
                for (int j=0; j<this->size; j++) {
                    specialPrint(this->a[i][j]);
                }
                cout << "\n";
            }
            cout << "\n\n";
        }

        int attack(index x) {
            if (this->a[x.i][x.j]) {
                this->a[x.i][x.j] = true;
                for (deque<Ship>::iterator i = this->ships.begin(); i!=this->ships.end(); i++) {
                    int resp = i->attack(x);
                    if (resp == FATAL) {
                        this->destroyShip(*i);
                        this->ships.erase(i);
                        if (this->doom()) return LOSE;
                        else return HIT;
                    } else return HIT;
                }
            } else return MISS;
        }

        bool doom() {
            return this->ships.empty();
        }
};

#endif