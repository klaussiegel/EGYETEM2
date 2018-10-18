// Oláh Tamás-Lajos
// otim1750
// 523 / 2

/*
	1. Írjunk programot, mely létrehoz két gyerekfolyamatot,
	melyekben a SIGINT jelzés blokálva van.

	A SIGTERM jelzésre az egyik gyerekfolyamat deblokálja a SIGINT jelzést,
	így ha korábban vagy ezután ilyen jelzés érkezett/érkezik,
	akkor az befejeződik (az alapértelmezett jelzéskezelőt használva),
	a szülőfolyamat és a második gyerekfolyamat pedig ugyanazon (SIGTERM) jelzés hatására
	kiír egy üzenetet, melyben szerepel az illető folyamat azonosítója.

	A második gyerekfolyamat rögtön be is fejeződik,
	a szülő viszont kivárja a két gyerekfolyamat befejezését,
	és csak azután áll le.
*/

/*
	TODO:

	- 2 children
	- CHILD 1
		- SIGTERM / 15 -> unblock SIGINT / 2
		- SIGINT / 2 -> DIE

	- CHILD 2
		- SIGTERM / 15 -> msg + PID -> DIE

	- PARENT
		- SIGTERM / 15 -> msg + PID -> WAIT -> DIE



	PARENT
	|
	| fork() --- CHILD 1 --> BLOCK SIGINT(2) --> SIGTERM(15) --> UNBLOCK SIGINT(2) --> DIE.
	|
	| fork() --- CHILD 2 --> BLOCK SIGINT(2) --> SIGTERM(15) --> print(PID) --> DIE.
	|
	| SIGTERM(15) --> print(PID) --> WAIT --> DIE.
	END

*/

#include <iostream>
#include <unistd.h>
#include <error.h>
#include <wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

using namespace std;

void sigterm_handler_unlock(int sig) {
	// CHILD 1
	sigset_t new_mask;

	if ((sigemptyset(&new_mask)==-1) || (sigaddset(&new_mask,SIGINT)==-1)) {
		cout << "\nSIGNAL MASK INIT ERROR!\n";
		exit(1);
	}

	// UNBLOCKING SIGINT(2)
	if (sigprocmask(SIG_UNBLOCK,&new_mask,NULL) == -1) {
		cout << "\nSIGNAL UNBLOCKING ERROR!\n";
		exit(1);
	}

	cout << "\n\t(CHILD 1) SIGINT UNBLOCKED!\nEXITING...\n";
	exit(0);
}

void sigterm_handler_print(int sig) {
	// PARENT
	cout << "\n\n(PARENT) PID: " << getpid() << "\n";
	while(wait(NULL)>0) {}
	exit(0);
}

void sigterm_handler_print_exit(int sig) {
	// CHILD 2
	cout << "\n\n\t(CHILD 2) PID: " << getpid() << "\n(CHILD 2) EXITING\n\n";
	exit(0);
}

int main() {
	cout << "\n\n";
	pid_t pid1,pid2;
	struct sigaction newAction1, newAction2, newAction3, oldAction;
	newAction1.sa_handler = sigterm_handler_unlock;
	newAction2.sa_handler = sigterm_handler_print;
	newAction3.sa_handler = sigterm_handler_print_exit;

	// CHILD 1
		// FORK
		if ((pid1=fork()) == -1) {
			cout << "\nFORK ERROR!\n";
			exit(1);
		}

		if (pid1==0) {
			// CHILD 1
			cout << "\n\n\t(CHILD 1) STARTED (UNBLOCK SIGINT - got SIGTERM = unblock SIGINT & die): " << getpid() << "\n";

			// SIGNAL MASK
			sigset_t new_mask;

			if ((sigemptyset(&new_mask)==-1) || (sigaddset(&new_mask,SIGINT)==-1)) {
				cout << "\nSIGNAL MASK INIT ERROR!\n";
				exit(1);
			}

			// BLOCKING SIGINT(2)
			if (sigprocmask(SIG_BLOCK,&new_mask,NULL) == -1) {
				cout << "\nSIGNAL BLOCKING ERROR!\n";
				exit(1);
			}

			// OVERRIDING SIGTERM(15) ACTION
			if (sigaction(SIGTERM, &newAction1, &oldAction) < 0) {
				cout << "\nSIGACTION ERROR!\n";
				exit(1);
			}

			while (true) {
				pause();
			}
		}


	// CHILD 2
		if ((pid2=fork()) == -1) {
			cout << "\nFORK ERROR!\n";
			exit(1);
		}

		if (pid2==0) {
			// CHILD 2
			cout << "\n\n\t(CHILD 2) WAITING (SIGTERM - print & die): " << getpid() << "\n";

			// OVERRIDING SIGTERM(15) ACTION
			if (sigaction(SIGTERM, &newAction3, &oldAction) < 0) {
				cout << "\nSIGACTION ERROR!\n";
				exit(1);
			}

			sigaction(SIGTERM, &newAction3, &oldAction);

			while (true) {
				pause();
			}
		}


	cout << "\n\n\t(PARENT) WAITING (SIGTERM - print & wait & die): " << getpid() << "\n";

	// PARENT
		// OVERRIDING SIGTERM(15) ACTION
		if (sigaction(SIGTERM, &newAction2, &oldAction) < 0) {
			cout << "\nSIGACTION ERROR!\n";
			exit(1);
		}

		sigaction(SIGTERM, &newAction2, &oldAction);

		while (true) {
			pause();
		}

		cout << "\n\nDONE\n\n";

	return 0;
}