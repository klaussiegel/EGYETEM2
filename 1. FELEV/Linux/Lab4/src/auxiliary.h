#ifndef __auxiliary_H__
#define __auxiliary_H__

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

using namespace std;

#define HIT 0
#define MISS 1
#define FATAL -1
#define STD 2

#define URES false
#define HAJO true

// TABLE GRAPHICS
#define S_MISS 44
#define S_HIT 55
#define R_HIT 12
#define R_MISS 13
#define ENEMY 11
#define MY 1
#define EMPTY 0
#define LOCKED 232

#define LOSE 666
#define WIN 333

#define DESTROYER 2
#define CRUISER 3
#define SUBMARINE 3
#define BATTLESHIP 4
#define CARRIER 5

#define VERTICAL false
#define HORIZONTAL true

typedef struct {
    int i;
    int j;
} index;

typedef struct {
    int i;
    int j;
    int state;
} ext_index;

typedef struct {
    int player_num;
    pid_t players[2];
    int PlayerID;
    index Target;
    int Prev;
} SHM;

// obj - TABLE GRAPHIC OBJECT
void specialPrint(int obj) {
    cout << " ";
    switch (obj) {
        case S_MISS: { // BOLD YELLOW
            cout << " \033[1;33m~\033[0m ";
        } break;

        case S_HIT: { // BOLD MAGENTA
            cout << " \033[1;35mX\033[0m ";
        } break;

        case R_MISS: { // BOLD WHITE
            cout << " \033[1m+\033[0m ";
        } break;

        case R_HIT: { // BOLD RED
            cout << " \033[1;31mx\033[0m ";
        } break;

        case ENEMY: { // MAGENTA
            cout << " \033[35me\033[0m ";
        } break;

        case MY: { // BLUE
            cout << " \033[1;34mm\033[0m ";
        } break;

        case LOCKED: { // YELLOW
            cout << " \033[1;33m0\033[0m ";
        } break;

        case EMPTY: {
            cout << " * ";
        } break;
    }
}

#endif