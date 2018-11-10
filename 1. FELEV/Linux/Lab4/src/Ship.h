#ifndef __Ship_h__
#define __Ship_h__

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
#include "auxiliary.h"

using namespace std;

class Ship {
    public:
        int type;
        bool vert_hor;
        int hp;
        ext_index* start;

        Ship(int type, index strt, bool v_h) {
            ext_index start;
            start.i = strt.i;
            start.j = strt.j;
            start.state = STD;
            switch (type) {
                case DESTROYER: {
                    this->type = DESTROYER;
                    if (v_h==VERTICAL) {
                        this->vert_hor = VERTICAL;
                        if (start.i>=0 && start.i<=10 && start.j>=0 && start.j<=11) {
                            this->start = new ext_index[2];
                            this->start[0] = start;
                            this->start[1].i = start.i+1;
                            this->start[1].j = start.j;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    } else {
                        this->vert_hor = HORIZONTAL;
                        if (start.i>=0 && start.i<=11 && start.j>=0 && start.j<=10) {
                            this->start = new ext_index[2];
                            this->start[0] = start;
                            this->start[1].i = start.i;
                            this->start[1].j = start.j+1;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    }
                } break;

                case CRUISER: {
                    this->type = CRUISER;
                    if (v_h==VERTICAL) {
                        this->vert_hor = VERTICAL;
                        if (start.i>=0 && start.i<=9 && start.j>=0 && start.j<=11) {
                            this->start = new ext_index[3];
                            this->start[0] = start;
                            this->start[1].i = start.i+1;
                            this->start[1].j = start.j;
                            this->start[2].i = start.i+2;
                            this->start[2].j = start.j;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    } else {
                        this->vert_hor = HORIZONTAL;
                        if (start.i>=0 && start.i<=11 && start.j>=0 && start.j<=9) {
                            this->start = new ext_index[2];
                            this->start[0] = start;
                            this->start[1].i = start.i;
                            this->start[1].j = start.j+1;
                            this->start[2].i = start.i;
                            this->start[2].j = start.j+2;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    }
                } break;

                case BATTLESHIP: {
                    this->type = BATTLESHIP;
                    if (v_h==VERTICAL) {
                        this->vert_hor = VERTICAL;
                        if (start.i>=0 && start.i<=8 && start.j>=0 && start.j<=11) {
                            this->start = new ext_index[4];
                            this->start[0] = start;
                            this->start[1].i = start.i+1;
                            this->start[1].j = start.j;
                            this->start[2].i = start.i+2;
                            this->start[2].j = start.j;
                            this->start[3].i = start.i+3;
                            this->start[3].j = start.j;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    } else {
                        this->vert_hor = HORIZONTAL;
                        if (start.i>=0 && start.i<=11 && start.j>=0 && start.j<=8) {
                            this->start = new ext_index[4];
                            this->start[0] = start;
                            this->start[1].i = start.i;
                            this->start[1].j = start.j+1;
                            this->start[2].i = start.i;
                            this->start[2].j = start.j+2;
                            this->start[3].i = start.i;
                            this->start[3].j = start.j+3;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    }

                } break;

                case CARRIER: {
                    this->type = CARRIER;
                    if (v_h==VERTICAL) {
                        this->vert_hor = VERTICAL;
                        if (start.i>=0 && start.i<=7 && start.j>=0 && start.j<=11) {
                            this->start = new ext_index[5];
                            this->start[0] = start;
                            this->start[1].i = start.i+1;
                            this->start[1].j = start.j;
                            this->start[2].i = start.i+2;
                            this->start[2].j = start.j;
                            this->start[3].i = start.i+3;
                            this->start[3].j = start.j;
                            this->start[4].i = start.i+4;
                            this->start[4].j = start.j;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    } else {
                        this->vert_hor = HORIZONTAL;
                        if (start.i>=0 && start.i<=11 && start.j>=0 && start.j<=7) {
                            this->start = new ext_index[5];
                            this->start[0] = start;
                            this->start[1].i = start.i;
                            this->start[1].j = start.j+1;
                            this->start[2].i = start.i;
                            this->start[2].j = start.j+2;
                            this->start[3].i = start.i;
                            this->start[3].j = start.j+3;
                            this->start[4].i = start.i;
                            this->start[4].j = start.j+4;
                        } else {
                            throw "OUT OF BOUNDS!";
                        }
                    }
                } break;
            }

            this->hp = this->type;
        }

        ~Ship() {
            delete [] this->start;
        }

        deque<index> getPoz() {
            deque<index> ret;
            for (int i=0; i<this->type; i++) {
                index k;
                k.i = this->start[i].i;
                k.j = this->start[i].j;

                ret.push_back(k);
            }

            return ret;
        }

        bool fatal() {
            return (this->hp==0);
        }

        bool thisShipCoord(index x) {
            for (int i=0; i<this->type; i++) {
                if (this->start[i].i==x.i && this->start[i].j==x.j) return true;
            }

            return false;
        }

        int attack(index i) { // HIT / MISS / FATAL
            for (int ind=0; ind<this->type; ind++) {
                if (this->start[ind].i==i.i && start[ind].j==i.j) {
                    this->start[ind].state = HIT;
                    this->hp--;

                    return (this->fatal()) ? FATAL : HIT;
                }
            }

            return MISS;
        }
};

#endif