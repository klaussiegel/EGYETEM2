# include <stdio.h>
# include <stdlib.h>
# include <unistd.h>
# include <sys/types.h>
# include <sys/ipc.h>
# include <sys/shm.h>

#define TABLE_SIZE_1D 9
#define TABLE_SIZE_2D 3
#define MSG_SIZE sizeof(message)

key_t key = 735508382;
key_t num_key = 264257534;
key_t sync_key = 31337;

typedef struct { int i; int j; } indd;

typedef struct { indd poz; char c; } message;

void zero(int game[3][3]) {
	int i,j;
	for (i=0; i<3; i++) {
		for (j=0; j<3; j++) {
			game[i][j] = 0;
		}
	}
}

void win(char c) {
	printf("\n\n\n\n\n\n\nWINNER WINNER CHICKEN DINNER!\n %c WON!\n\n\n",c);
	exit(0);
}

int valid(message x) {
	if (x.poz.i<0 || x.poz.i>2) return 0;
	if (x.poz.j<0 || x.poz.j>2) return 0;
	if (x.c!='X' || x.c!='O' || x.c!='0') return 0;
	return 1;
}

void help() {
	printf("\n\nINDEX HELPER:\n\n");
	printf("\t 0 | 1 | 2\n\t-----------\n\t 3 | 4 | 5\n\t-----------\n\t 6 | 7 | 8\n\n");
}

char tochar(int x) {
	if (x==0) return ' ';
	if (x==1) return 'X';
	if (x==-1) return '0';
}

void print_curr(int game[3][3]) {
	printf("\n\nCURRENT STATS:\n\n");
	printf("\t %c | %c | %c\n\t-----------\n\t %c | %c | %c\n\t-----------\n\t %c | %c | %c\n\n",tochar(game[0][0]),tochar(game[0][1]),tochar(game[0][2]),tochar(game[1][0]),tochar(game[1][1]),tochar(game[1][2]),tochar(game[2][0]),tochar(game[2][1]),tochar(game[2][2]));
}

int checkwin(int game[3][3], int x) {
	// SINGLE
		// FOATLO
		if (game[0][0]==x && game[1][1]==x && game[2][2]==x) return 1;

		// MELLEKATLO
		if (game[2][0]==x && game[1][1]==x && game[0][2]==x) return 1;
		
	// FOR
		int i;
		
		// VERTICAL
		for (i=0; i<=2; i++) {
			if (game[0][i]==x && game[1][i]==x && game[2][i]==x) return 1;
		}

		// HORIZONTAL
		for (i=0; i<=2; i++) {
			if (game[i][0]==x && game[i][1]==x && game[i][2]==x) return 1;
		}

	// NOT A WIN
	return 0;
}

int change(int game[3][3], message x) {
	int i,j;
	i = x.poz.i;
	j = x.poz.j;

	if (i>=3 || j>=3) {
		printf("\n\nHIBA!\n\n");
		return -1;
	}

	if (game[i][j]==0) {
		if (x.c=='X') {
			game[i][j] = 1;
			
			if (checkwin(game,1)==1) return 1;
			else return 0;
			
		} else {
			game[i][j] = -1;
			
			if (checkwin(game,-1)==1) return 1;
			else return 0;
		}
		
	} else {
		printf("\n\nCELL ALREADY OCCUPIED!\n\n");
		return -1;
	}
}

indd arr_to_mat (int x) { indd out; out.i = x/3; out.j = x%3; return out; }

int mat_to_arr (indd x) { return x.i*3+x.j; } 