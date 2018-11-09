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

class Ship {
    public:
        int type;
        bool vert_hor;
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
        }

        ~Ship() {
            delete [] this->start;
        }

        bool fatal() {
            for (int i=0; i<this->type; i++) {
                if (this->start[i].state == STD) return false;
            }

            return true;
        }

        bool thisShipCoord(index x) {
            for (int i=0; i<this->type; i++) {
                if (this->start[i].i==x.i && this->start[i].j==x.j) return true;
            }

            return false;
        }

        int attack(index i) { // HIT / MISS / FATAL
            for (int i=0; i<this->type; i++) {
                if (this->start[i].i==i.i && start[i].j==i.j) {
                    this->start[i].state = HIT;

                    return (this->fatal()) ? FATAL : HIT;
                }
            }

            return MISS;
        }
};

class GameBoard {
    private:
        bool** a;
        int size;
        deque<Ship> ships;

    public:
        GameBoard() {
            this->size = 12;
            this->a = new bool*[this->size];

            for (int i=0; i<this->size; i++) {
                this->a[i] = new bool[this->size];

                for (int j=0; j<this->size; j++) {
                    a[i][j] = URES;
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

        int attack(index x) {
            if (this->a[x.i][x.j]) {
                this->a[x.i][x.j] = true;
                for (deque<Ship>::iterator i = this->ships.begin(); i!=this->ships.end(); i++) {
                    int resp = i->attack(x);
                    if (resp == FATAL) {
                        this->ships.erase(i);
                        return FATAL;
                    } else return HIT;
                }
            }
        }
};

typedef struct {
    int player_num;
    int GamerID;
    index Target;
    int Prev;
} SHM;

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

        this->shm_ptr->GamerID = 0;
        this->shm_ptr->player_num = 1;
        this->shm_ptr->Prev = STD;
        this->shm_ptr->Target.i = 0;
        this->shm_ptr->Target.j = 0;
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

class Torpedo {
    private:
        GameBoard a;
        SHM shm;

    public:
    void readFromSHM(SharedMemory shm, pid_t pid) {
        this->shm = shm.getContent();
        this->shm.GamerID = pid;

        if ()
    }

    void writeToSHM(SharedMemory shm) {
        shm.setContent(this->shm);
    }

    // GAME LOGIC
};