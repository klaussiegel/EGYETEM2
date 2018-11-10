#include <iostream>
# include <stdio.h>
# include <fcntl.h>
# include <stdlib.h>
# include <unistd.h>
# include <sys/types.h>
# include <sys/ipc.h>
# include <sys/shm.h>
# include <sys/mman.h>
# include <sys/stat.h>
# include "src/comm.h"
# include "src/Player.h"

using namespace std;

void input(Player& a) {
    a.a.zero();
    bool v_t;
    index start;
    // CARRIER
    cout << "Please enter where you wanna place your carrier ship (5):\n\t";
    cout << "Vertical (0) or horizontal (1) orientation? ";
    cin >> v_t;
    cout << "\n\tStarting position (TOP POSITION or LEFT-MOST POSITION)\n\t\ti: ";
    cin >> start.i; cout << "\n\t\tj: "; cin >> start.j;
    Ship x1(CARRIER,start,v_t);
    a.a.addShip(x1);

    // BATTLESHIP
    cout << "Please enter where you wanna place your battleship (4):\n\t";
    cout << "Vertical (0) or horizontal (1) orientation? ";
    cin >> v_t;
    cout << "\n\tStarting position (TOP POSITION or LEFT-MOST POSITION)\n\t\ti: ";
    cin >> start.i; cout << "\n\t\tj: "; cin >> start.j;
    Ship x2(BATTLESHIP,start,v_t);
    a.a.addShip(x2);

    // CRUISER
    cout << "Please enter where you wanna place your cruiser (3):\n\t";
    cout << "Vertical (0) or horizontal (1) orientation? ";
    cin >> v_t;
    cout << "\n\tStarting position (TOP POSITION or LEFT-MOST POSITION)\n\t\ti: ";
    cin >> start.i; cout << "\n\t\tj: "; cin >> start.j;
    Ship x3(CRUISER,start,v_t);
    a.a.addShip(x3);

    // SUBMARINE
    cout << "Please enter where you wanna place your submarine (3):\n\t";
    cout << "Vertical (0) or horizontal (1) orientation? ";
    cin >> v_t;
    cout << "\n\tStarting position (TOP POSITION or LEFT-MOST POSITION)\n\t\ti: ";
    cin >> start.i; cout << "\n\t\tj: "; cin >> start.j;
    Ship x3(CRUISER,start,v_t);
    a.a.addShip(x3);

    // DESTROYER
    cout << "Please enter where you wanna place your destroyer (3):\n\t";
    cout << "Vertical (0) or horizontal (1) orientation? ";
    cin >> v_t;
    cout << "\n\tStarting position (TOP POSITION or LEFT-MOST POSITION)\n\t\ti: ";
    cin >> start.i; cout << "\n\t\tj: "; cin >> start.j;
    Ship x3(CRUISER,start,v_t);
    a.a.addShip(x3);
}

index move(Player a) {
    system("clear");
    a.a.printB();

    index x;

    cout << "Make a move!\n\ti: ";
    cin >> x.i;
    cout << "\n\tj: ";
    cin >> x.j;

    return x;
}

int main() {
    system("clear");
    // GET SEMAPHORE
    sem_t* sem = open_sem();

    SharedMemory shm(0);

    // INIT & SETUP
    Player a;
    bool resp;

    do {
        system("clear");
        input(a);

        cout << "\n\n\nTHIS IS YOUR SETUP:";
        a.a.printB();

        cout << "Is this okay? (0/1) ";
        cin >> resp;
    } while (!resp);

    deque<index> init_moves;

    for (int i=1; i<=7; i++) {
        init_moves.push_back(move(a));
        while ()
    }

    for (index x : init_moves) {
        a.setTarget(x);
        a.writeToSHM(shm);
    }

    while (true) {
        // INITIAL 7 MOVES


    }

    return 0;
}