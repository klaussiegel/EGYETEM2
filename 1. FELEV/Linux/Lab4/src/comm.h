#ifndef __comm_h__
#define __comm_h__

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
#include <signal.h>
#include <string>
#include <deque>
#include "SharedMemory.h"
#include "Ship.h"
#include "GameBoard.h"
#include "auxiliary.h"

using namespace std;

void winner(pid_t enemy) {
    cout << "\n\n\n\033[1;33mWINNER, WINNER, CHICKEN DINNER!\033[0m\n\n\n";
    kill(enemy,SIGUSR1);
    exit(0);
}

void loser(pid_t enemy) {
    cout << "\n\n\n\033[1;31mYOU LOSE!\033[0m\n\n\n";
    kill(enemy,SIGUSR2);
    exit(0);
}

sem_t* open_semA() {
    sem_t* temp = sem_open("/Torpedo_semA",O_CREAT,0777,0);
    return temp;
}

sem_t* open_semB() {
    sem_t* temp = sem_open("/Torpedo_semB",O_CREAT,0777,0);
    return temp;
}

void pWinS(int x) {
    cout << "\n\n\n\033[1;33mWINNER, WINNER, CHICKEN DINNER!\033[0m\n\n\n";
    exit(0);
}

void pLoseS(int x) {
    cout << "\n\n\n\033[1;31mYOU LOSE!\033[0m\n\n\n";
    exit(0);
}

void pWin() {
    cout << "\n\n\n\033[1;33mWINNER, WINNER, CHICKEN DINNER!\033[0m\n\n\n";
}

void pLose() {
    cout << "\n\n\n\033[1;31mYOU LOSE!\033[0m\n\n\n";
}

#endif