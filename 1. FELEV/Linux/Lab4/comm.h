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

using namespace std;

#define HIT 0
#define NO_HIT 1
#define FATAL -1

class GameBoard {
    private:
        int** a;
        int size;

    public:
        GameBoard() {
            this->size = 12;
            this->a = new int*[this->size];

            for (int i=0; i<this->size; i++) {
                this->a[i] = new int[this->size];

                for (int j=0; j<this->size; j++) {
                    a[i][j] = 0;
                }
            }
        }

        ~GameBoard() {
            for (int i=0; i<this->size; i++) {
                delete [] this->a[i];
            }

            delete [] this->a;
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
                    cout << this->a[i][j] << " ";
                }
                cout << "\n";
            }
            cout << "\n\n";
        }
};

typedef struct {
    int i;
    int j;
} index;

typedef struct {
    int player_num;
    int GamerID;
    index Target;
    int Prev;
} SHM;

class SharedMemory {
    public:
        int shm_id;
        SHM* shm_ptr;

    SharedMemory() {
        this->shm_id = shm_open("/Torpedo",O_CREAT|O_RDWR,0666);
        ftruncate(this->shm_id,sizeof(SHM));
        int protection = PROT_READ | PROT_WRITE;
        int visibility = MAP_SHARED;
        this->shm_ptr = (SHM*)mmap(NULL,sizeof(SHM),protection, visibility, this->shm_id,0);

        this->shm_ptr->GamerID = 0;
        this->shm_ptr->player_num = 0;
        this->shm_ptr->Prev = 0;
        this->shm_ptr->Target.i = 0;
        this->shm_ptr->Target.j = 0;
    }

    ~SharedMemory() {
    }

    void printSHM() {
        cout << "\n\nSHM {\n    " << "player_num : " << this->shm_ptr->player_num;
        cout << ",\n    GamerID : " << this->shm_ptr->GamerID << ",\n    ";
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