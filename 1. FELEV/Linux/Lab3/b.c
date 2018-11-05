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

void lose(int xyz) {
	printf("\n\nYOU LOSE! BETTER LUCK NEXT TIME!\n\n");
	exit(0);
}

void draw(int xyz) {
	printf("\n\nIT'S A DRAW!\n\n");
	print_curr(game);
	exit(0);
}


void playit(int xyz) {
	message in = shm[0];

	shm->poz.i = 0;
	shm->poz.j = 0;

	// READ MESSAGE
	change(game,in);

	if (checkwin(game,1)!=1 && checkwin(game,-1)!=1) {
		if (dontetlen(game)==1) {
			printf("\n\nIT'S A DRAW!\n\n");
			print_curr(game);
			kill(inst_shm->pid1,SIGUSR1);
			exit(0);
		}

		// NOT A WIN
		message out;
        print_curr(game);
		help();
		printf("\n\nPlease enter desired move!\npoz = ");
		int position;
		scanf("%d",&position);
		printf("\n\nINDL %d\n\n",position);
		out.poz = arr_to_mat(position);
		out.c = '0';

		// SEND MESSAGE
		*shm = out;
		change(game,out);
		print_curr(game);

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

	return;
}



int main() { // -1 / 0
	// CREATE SHM

    int i_shm = open_inst_shm();
	inst_shm = (instance*)create_shared_memory(sizeof(instance),i_shm);

	if (inst_shm->inst == 2) print_error("Too many instances");

    int main_shm = open_main_shm();
	shm = (message*)create_shared_memory(sizeof(message),main_shm);

	// CREATE GAME TABLE
	zero(game);

	print_curr(game);

	signal(SIGPWR,&playit);
	signal(SIGTERM,&lose);
	signal(SIGUSR1,&draw);

    inst_shm->pid2 = getpid();
    inst_shm->inst++;

    while (1==1) {pause();}

	return 0;
}
