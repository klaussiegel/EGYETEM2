// Oláh Tamás-Lajos
// otim1750
// 523 / 2

/*
 	1. Írjunk egy C programot, mely X-0 játékot játszik egy másikkal.
 	A két folyamat közötti információcsere egy osztott memória területen keresztül történik.
	A programnak ellenőriznie kell, hogy csak két példányban fut-e.
*/

# include <stdio.h>
# include <stdlib.h>
# include <unistd.h>
# include <sys/types.h>
# include <sys/ipc.h>
# include <sys/shm.h>
# include "comm.h"

void error() {
	printf("\n\nERROR!\n\n");
	exit(1);
}

void usage() {
	// ...
}


int main() {
	// int shmid;
	// int* shm;
	// int game[3][3];
// 
	// zero(game);

	help();
	// printf("\n\nTHE KEY IS: %d\n\n",key);

	// shmid = shmget(key,MSG_SIZE,IPC_CREAT | 0666);
// 
	// if (shmid < 0) error();
// 
	// shm = shmat(shmid,NULL,0);
// 
	// if (shm == (int*) -1) error();
	
	// MEMORY MANIPULATION

	

	// WHILE-TERMINATION

	return 0;
}
