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

#include <iostream>
#include <unistd.h>
#include <error.h>
#include <wait.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

using namespace std;

void sigterm_handler_unlock(int sig) {
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

	cout << "\n\t\t(CHILD2) SIGINT UNBLOCKED!\n";

	exit(0);
}

void sigterm_handler_print(int sig) {
	cout << "\n\n\t(PARENT) PID: " << getpid() << "\n";
	while(wait(NULL)>0) {}
	exit(0);
}

void sigterm_handler_print_exit(int sig) {
	cout << "\n\n\t(CHILD2) PID: " << getpid() << "\n(CHILD2) EXITING\n\n";
	exit(0);
}

int main() {
	cout << "\n\n";
	pid_t pid1,pid2;
	struct sigaction newAction1, newAction2, newAction3, oldAction;
	newAction1.sa_handler = sigterm_handler_unlock;
	newAction2.sa_handler = sigterm_handler_print;
	newAction3.sa_handler = sigterm_handler_print_exit;

	if ((pid1=fork()) == -1) {
		cout << "\nFORK ERROR!\n";
		exit(1);
	}

	if (pid1==0) {
		// CHILD1

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

		// FORK
		if ((pid2=fork()) == -1) {
			cout << "\nFORK ERROR!\n";
			exit(1);
		}

		if (pid2==0) {
			// CHILD2

			// SIGINT(2) is blocked here, too, because the child process inherited
			// the modified signal mask of the parent process
			// if (sigaction(SIGTERM, &newAction1, &oldAction) < 0) {
			// 	cout << "\nSIGACTION ERROR!\n";
			// 	exit(1);
			// }

			sigaction(SIGTERM, &newAction1, &oldAction);

			while (true) {
				pause();
			}
		} else {
			// PARENT2

			// if (sigaction(SIGTERM, &newAction3, &oldAction) < 0) {
			// 	cout << "\nSIGACTION ERROR!\n";
			// 	exit(1);
			// }
			sigaction(SIGTERM, &newAction3, &oldAction);

			while (true) {
				pause();
			}
		}

		exit(0);
	}

	// PARENT1
	// if (sigaction(SIGTERM, &newAction2, &oldAction) < 0) {
	// 	cout << "\nSIGACTION ERROR!\n";
	// 	exit(1);
	// }

	sigaction(SIGTERM, &newAction2, &oldAction);

	while (true) {
		pause();
	}

	return 0;
}