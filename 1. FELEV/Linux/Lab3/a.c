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
# include <string.h>
# include <sys/ipc.h>
# include <sys/shm.h>
# include <sys/types.h>
# include "comm.h"

void error() {
	printf("\n\nERROR!\n\n");
	exit(1);
}

int main() {
	int shmid, num_shmid, sync_shmid;
	int *num_shm;
	message *shm;
	int *sync_shm;
	int game[3][3];
	int my_num;

	zero(game);

	// INIT SYNC
	sync_shmid = shmget(sync_key,sizeof(int),IPC_CREAT | 0666);
	
	sync_shm = shmat(sync_shmid,NULL,0); 

	// if (*sync_shm!=0 && *sync_shm!=1) *sync_shm = 1;


	// CHECKING FOR NUMBER OF PROCESSES
	num_shmid = shmget(num_key,sizeof(int),IPC_CREAT | 0666);

	if (num_shmid<0) error();

	num_shm = shmat(num_shmid,NULL,0);

	if (num_shm == (int*) -1) error();

	if (num_shm == (int*) 2) error(); // Too many processes

	if (num_shm == (int*) 1) {
		*num_shm = 2;
		my_num = -1;
	} else {
		*num_shm = 1;
		my_num = 1;
		*sync_shm = 1;
	}

	// GETTING COMM MEMORY

	shmid = shmget(key,MSG_SIZE,IPC_CREAT | 0666);

	if (shmid < 0) error();

	shm = shmat(shmid,NULL,0);

	if (shm == (message*) -1) error();
	
	// MEMORY MANIPULATION

	int vege = 0;
	
	while (vege!=1) {
		printf("\n\nSYNC_SHM: %d",*sync_shm);
		while (*sync_shm==0) { pause(); }
		printf("\n\nI'm here!\n\n");

		// SIGNAL MEMORY LOCK
		*sync_shm = 0;

		// READ MOVE
		message got = *shm;
		if (valid(got)==1) {
			// PROCESS MOVE
			if (change(game,got)==1) {
				win(got.c);
			}
		}

		// PRINT CURRENT STAT

		print_curr(game);

		// DETERMINE NEXT MOVE
		int move;
		help();
		scanf("\n\nMAKE A MOVE: %d",&move);
		indd id = arr_to_mat(move);
		message resp;
		resp.poz = id;
		resp.c = tochar(my_num);

		// WRITE MOVE TO SHM
		*shm = resp;

		// UNLOCK MEMORY
		*sync_shm = 1;
	}
	return 0;
}
