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


	PROGRAM MAP:
	
		PARENT
		|
		| fork() --- CHILD 1 --> BLOCK SIGINT(2) --> SIGTERM(15) --> UNBLOCK SIGINT(2) --> SIGINT(2) --> DIE.
		|
		| fork() --- CHILD 2 --> BLOCK SIGINT(2) --> SIGTERM(15) --> print(PID) --> DIE.
		|
		| --- SIGTERM(15) --> print(PID) --> WAIT --> DIE.
		DOOM

*/

#include <iostream> // IO library
#include <unistd.h> // UNIX library
#include <error.h> //UNIX  error-handling library
#include <wait.h> // UNIX - For process syncing
#include <stdlib.h> // C Standard Library
#include <stdio.h> // C standard IO library
#include <signal.h> // UNIX signal library



using namespace std;





// Thanos at work...
void snap(int) {
	cout << "\n\t(CHILD 1) EXITING...\n";
	exit(0);
}





// The chain-breaker
void sigterm_handler_unlock(int) {
	// CHILD 1
	// CREATING SIGSET
	sigset_t new_mask;

	if ((sigemptyset(&new_mask)==-1) /* Initializing an empty sigset */ || (sigaddset(&new_mask,SIGINT)==-1) /* Adding SIGINT to the set */) {
		cout << "\nSIGNAL MASK INIT ERROR!\n";
		exit(1);
	}

	// UNBLOCKING SIGINT(2)
	if (sigprocmask(SIG_UNBLOCK,&new_mask,NULL) == -1) {
		cout << "\nSIGNAL UNBLOCKING ERROR!\n";
		exit(1);
	}

	// Overriding the standard action for SIGINT(2) - dirty fix, but hey, it works... ¯\_(ツ)_/¯
	signal(SIGINT,&snap);

	cout << "\n\n\t(CHILD 1) SIGINT UNBLOCKED!\n";

	// Waiting for signal
	while(true) {
		pause();
	}
}




// Print 'n Wait 'n Print 'n DIE
void sigterm_handler_print(int) {
	// PARENT
	cout << "\n\n(PARENT) PID: " << getpid() << "\n(PARENT) WAITING FOR CHILDREN TO EXIT...\n";

	// Waiting for children - preventing the zombie apocalypse....
	while(wait(NULL)>0) {}

	cout << "\n\n\n(PARENT) EXITING\n\n";

	// Mass extinction impending....
	exit(0);
}





// The useless one in the squad...
void sigterm_handler_print_exit(int) {
	// CHILD 2
	cout << "\n\n\t(CHILD 2) PID: " << getpid() << "\n\t(CHILD 2) EXITING\n\n";
	exit(0);
}






int main() {

	cout << "\n\n";

	// FORK ALL THE PROCESSES!
	pid_t pid1,pid2;



	

	// CHILD 1
		if ((pid1=fork()) == -1) {
			cout << "\nFORK ERROR!\n";
			exit(1);
		}

		if (pid1==0) {
			// CHILD 1
			cout << "\n\n\t(CHILD 1) STARTED (got 15 = unblock 2 & wait for 2; got 2 = die): " << getpid() << "\n\n";

			// SIGNAL SET
			sigset_t new_mask;

			// Init signal set and add SIGINT(2) to it
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
			signal(SIGTERM,&sigterm_handler_unlock);

			// Waiting for signal
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
			cout << "\n\n\t(CHILD 2) WAITING (15 - print & die): " << getpid() << "\n\n";

			// SIGNAL SET
			sigset_t new_mask;

			// Init signal set and add SIGINT(2) to it
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
			signal(SIGTERM,&sigterm_handler_print_exit);

			// Wait for signal
			while (true) {
				pause();
			}
		}






	// PARENT
		cout << "\n\n\t(PARENT) WAITING (15 - print & wait & die): " << getpid() << "\n\n";
		
		// SIGNAL SET
		sigset_t new_mask;

		// Init signal set and add SIGINT(2) to it
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
		signal(SIGTERM,&sigterm_handler_print);

		// Waiting for signal
		while (true) {
			pause();
		}

	return 0;
}
