// Oláh Tamás-Lajos
// otim1750
// 523 / 2

/*
	1. Írjunk egy C programot, mely X-0 játékot játszik egy másikkal.
	A két folyamat közötti információcsere egy osztott memória területen keresztül történik.
	A programnak ellenőriznie kell, hogy csak két példányban fut-e.
*/

# include <wait.h>
# include <stdio.h>
# include <error.h>
# include <fcntl.h>
# include <stdlib.h>
# include <unistd.h>
# include <string.h>
# include <signal.h>
# include <sys/ipc.h>
# include <sys/shm.h>
# include <sys/types.h>
# include <sys/mman.h>
# include "comm.h"

void print_error(char* buf) {
	printf("\n\n%s!\n\n",buf);
	exit(1);
}

message* shm;
int end = 0;
instance* inst_shm;
int inst_shmid;
int shmid;
int game[3][3];


void playit(int xyz) {
	message in = shm[0];

	// READ MESSAGE
	change(game,in);

	if (checkwin(game,1)!=1 && checkwin(game,-1)!=1) {
		// NOT A WIN
		message out;
		help();
		printf("\n\nPlease enter desired move!\n");
		int position;
		scanf("\npoz = %d",&position);
		out.poz = arr_to_mat(position);
		out.c = 'X';

		// SEND MESSAGE
		*shm = out;
		change(game,out);

		if (checkwin(game,1)==1) {
			win('X');
			kill(inst_shm->pid2,SIGTERM);
			exit(0);
		}

		kill(inst_shm->pid2,SIGPWR);

	} else {
		// WIN
		if (checkwin(game,1)==1) win('X');
		else win('0');

		kill(inst_shm->pid2,SIGTERM);

		exit(0);
	}

	return;
}



int main() { // 1 / X
	// CREATE SHM
		// int shmid = shmget(1234,sizeof(int),IPC_CREAT|0666);
		// int* shm;
		// shm = (int*) shmat(shmid,0,0);

	// SHM FOR INSTANCE COUNT

	// inst_shmid = shmget(num_key,sizeof(instance),IPC_CREAT|0666);

	// if (inst_shmid == -1) {
	// 	print_error("INST_SHMID ERROR");
	// }

	// inst_shm = (instance*) shmat(inst_shmid,0,0);
	int i_shm = open_inst_shm();
	inst_shm = (instance*)create_shared_memory(sizeof(instance),i_shm);


	// if (inst_shm == (instance*) -1) {
	// 	print_error("INSTANCE ERROR");
	// }

	inst_shm->inst = 1;
	inst_shm->pid2 = 0;


	if (inst_shm->inst==2) print_error("Too many instances");


	// SHM FOR COMMUNICATION
	// shmid = shmget(key,sizeof(message),IPC_CREAT|0666);

	// if (shmid == -1) {
	// 	print_error("INST_SHMID ERROR");
	// }

	// shm = (message*) shmat(shmid,0,0);
	int main_shm = open_main_shm();
	shm = (message*)create_shared_memory(sizeof(message),main_shm);

	// if (shm == (message*) -1) {
	// 	print_error("ATTACH ERROR");
	// }



	// CREATE GAME TABLE
	zero(game);

	print_curr(game);

	signal(SIGPWR,&playit);

		// SIGNAL OTHER

			// INITIAL MOVE
			message out;
			help();
			printf("\n\nPlease enter desired move!\n");
			int position;
			scanf("%d",&position);
			printf("\n\nPOSITION: %d\n\n",position);
			out.poz = arr_to_mat(position);
			out.c = 'X';

			// pr_msg(out);

			// SEND MESSAGE
			*shm = out;
			change(game,out);

			print_curr(game);

			printf("\n\nPID: %d\n\n",getpid());

			// while (inst_shm->pid2==0) {pause();}

			// pr_inst(*inst_shm);

			kill(inst_shm->pid2,SIGPWR);

		while (1==1) {pause();}

	return 0;
}
