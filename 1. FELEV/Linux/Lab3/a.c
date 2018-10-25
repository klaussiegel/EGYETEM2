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
# include <sys/random.h>



#define TABLE_SIZE_1D 9
#define TABLE_SIZE_2D 3




typedef struct { int i; int j; } index;

index arr_to_mat (int x) { index out; out.i = x/3; out.j = x%3; return out; }

int mat_to_arr (index x) { return x.i*3+x.j; } 

void error() {
	printf("\n\nERROR!\n\n");
	exit(1);
}

void usage() {
	// ...
}


int main() {
	int shmid;
	key_t key;
	int* shm;
	getrandom(&key,sizeof(int),0);
	FILE* f = fopen("key.priv","w");
	fprintf(f,"%d",key);
	// printf("\n\nRandom number = %d\n\n",key);

	shmid = shmget(key,sizeof(int)*TABLE_SIZE_1D,IPC_CREAT | 0666);	

	if (shmid < 0) error();

	shm = shmat(shmid,NULL,0);

	if (shm == (int*) -1) error();
	
	// MEMORY MANIPULATION

	// WHILE-TERMINATION

	fclose(f);
	system("rm ./key.priv");
	return 0;
}
