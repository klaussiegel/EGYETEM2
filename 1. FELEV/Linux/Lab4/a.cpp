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
#include "comm.h"

using namespace std;

int main() {
    GameBoard b;
    b.printB();
    SharedMemory x;
    x.printSHM();
    return 0;
}