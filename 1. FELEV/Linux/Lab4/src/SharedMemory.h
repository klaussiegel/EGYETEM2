#ifndef __SharedMemory_h__
#define __SharedMemory_h__

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

class SharedMemory {
    private:
        int shm_id;
        SHM* shm_ptr;

    public:
    SharedMemory(int x) {
        this->shm_id = shm_open("/Torpedo",O_CREAT|O_RDWR,0666);
        ftruncate(this->shm_id,sizeof(SHM));
        int protection = PROT_READ | PROT_WRITE;
        int visibility = MAP_SHARED;
        this->shm_ptr = (SHM*)mmap(NULL,sizeof(SHM),protection, visibility, this->shm_id,0);

        this->shm_ptr->PlayerID = 0;
        this->shm_ptr->player_num = 1;
        this->shm_ptr->Prev = STD;
        this->shm_ptr->Target.i = 0;
        this->shm_ptr->Target.j = 0;
        this->shm_ptr->players[0] = getpid();
    }

    SharedMemory() {
        this->shm_id = shm_open("/Torpedo",O_CREAT|O_RDWR,0666);
        ftruncate(this->shm_id,sizeof(SHM));
        int protection = PROT_READ | PROT_WRITE;
        int visibility = MAP_SHARED;
        this->shm_ptr = (SHM*)mmap(NULL,sizeof(SHM),protection, visibility, this->shm_id,0);

        if (this->shm_ptr->player_num>=2) {
            cout << "\n\nToo many players!\n\n";
            exit(1);
        } else this->shm_ptr->player_num++;

        this->shm_ptr->players[1] = getpid();
    }

    ~SharedMemory() {
    }

    SHM getContent() {
        return *this->shm_ptr;
    }

    void setContent(SHM ct) {
        *this->shm_ptr = ct;
    }

    void printSHM() {
        cout << "\n\nSHM {\n    " << "player_num : " << this->shm_ptr->player_num;
        cout << ",\n    GamerID : " << this->shm_ptr->PlayerID << ",\n    ";
        cout << "Target : Index {\n        " << "i : " << this->shm_ptr->Target.i << ",\n        ";
        cout << "j : " << this->shm_ptr->Target.j << "\n    },\n    ";
        cout << "prev: ";

        if (this->shm_ptr->Prev==HIT) cout << "HIT";
        else {
            if (this->shm_ptr->Prev==FATAL) cout << "FATAL";
            else cout << "NO HIT";
        }

        cout << "\n}\n\n";
    }
};

#endif