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
#include "src/comm.h"

using namespace std;

int main() {
    sem_t* s;
    s = sem_open("/test_sem",O_CREAT,0666,0);
    // sem_wait(s);
    int x;
    sem_getvalue(s,&x);

    cout << "\n\nSem value: " << x << "\n\n";

    sem_close(s);
    sem_unlink("/test_shm");

    return 0;
}