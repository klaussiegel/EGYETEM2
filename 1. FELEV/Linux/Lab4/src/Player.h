#ifndef __Player_h__
#define __Player_h__

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
#include "GameBoard.h"
#include "auxiliary.h"
#include "comm.h"

using namespace std;

class Player {
    public:
        GameBoard a;
        SHM shm;
        index Prev;

        void readFromSHM(SharedMemory shared_mem) {
            this->shm = shared_mem.getContent();

            if (this->shm.PlayerID==getpid()) {
                perror("FATAL ERROR!");
                exit(1);
            }

            if (this->shm.Prev!=STD) {
                int prev = this->shm.Prev;

                switch (prev) {
                    case HIT: {
                        this->a.setInd(this->Prev.i,this->Prev.j,S_HIT);

                        int resp = this->a.attack(this->shm.Target);
                        this->shm.Prev = resp;

                        switch (resp) {
                            case HIT: {
                                this->a.setInd(this->shm.Target.i,this->shm.Target.j,R_HIT);
                            } break;

                            case MISS: {
                                this->a.setInd(this->shm.Target.i,this->shm.Target.j,R_MISS);
                            } break;

                            case LOSE: {
                                this->writeToSHM(shared_mem);
                                pLose();
                                // SIGNAL SEMAPHORE
                                exit(0);
                            } break;
                        }
                    } break;

                    case MISS: {
                        this->a.setInd(this->Prev.i,this->Prev.j,S_MISS);
                    } break;

                    case LOSE: {
                        pWin();
                        // SIGNAL SEMAPHORE
                        exit(0);
                    } break;
                }
            }
        }

        SHM getSHM() { return this->shm; }

        void setSHM(SHM shared_mem) { this->shm = shared_mem; }

        void setTarget(index k) {
            this->shm.Target = k;
        }

        void writeToSHM(SharedMemory shared_mem) {
            this->Prev = this->shm.Target;
            shared_mem.setContent(this->shm);
        }

        void print_curr() {
            a.printB();
        }
};

#endif