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
# include <fcntl.h>
# include <error.h>
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
        print_curr(game);
		help();
		printf("\n\nPlease enter desired move!\n");
		int position = 0;
		scanf("\npoz = %d",&position);
		out.poz = arr_to_mat(position);
		out.c = '0';

		// SEND MESSAGE
		*shm = out;
		change(game,out);


		if (checkwin(game,-1)==1) {
			win('0');
			kill(inst_shm->pid1,SIGTERM);
            exit(0);
		}

        kill(inst_shm->pid1,SIGPWR);
	} else {
		// WIN
		if (checkwin(game,-1)==1) win('0');
		else win('X');

		kill(inst_shm->pid1,SIGTERM);

		exit(0);
	}

	pause();
}



int main() { // -1 / 0
	// CREATE SHM
		// int shmid = shmget(1234,sizeof(int),IPC_CREAT|0666);
		// int* shm;
		// shm = (int*) shmat(shmid,0,0);

	// SHM FOR INSTANCE COUNT

	// inst_shmid = shmget(num_key,sizeof(instance),IPC_CREAT|0666);

    // if (inst_shmid == -1) {
	// 	print_error("INST_SHMID ERROR");
	// }

    int i_shm = open_inst_shm();
	inst_shm = (instance*)create_shared_memory(sizeof(instance),i_shm);

	// inst_shm = (instance*) shmat(inst_shmid,0,0);

    // if (inst_shm == (instance*) -1) {
	// 	print_error("INSTANCE ERROR");
	// }

	if (inst_shm->inst == 2) print_error("Too many instances");

	// SHM FOR COMMUNICATION
	// shmid = shmget(key,sizeof(message),0666);

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

    inst_shm->pid2 = getpid();
    inst_shm->inst++;

    // printf("\n\nPID: %d\n\n",getpid());
    // pr_inst(*inst_shm);

    pause();

	return 0;
}
