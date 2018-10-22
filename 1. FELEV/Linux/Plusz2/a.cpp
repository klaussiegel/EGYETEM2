// Oláh Tamás-Lajos
// otim1750
// 523 / 2

/*
	Írjunk két különálló programot, amelyek a következőképpen működnek:
	
	    Az első folyamat jelzéseket küld 0.5 másodpercenként egy másik folyamatnak egy előre definiált jelzés listából.
	      A címzett folyamatazonosítóját parancssorbeli argumentumként kapja meg 
	      Az első folyamat, ha SIGUSR1 jelet kap (ami nincs benne az eredeti listában) fejezze be a jezések küldözgetését, és lépjen ki egy üzenettel.
	    A második folyamat kezdetben minden jelzés esetén (az általa is előre ismert jelzés listából) egy függvényt hajtson végre, amely kiírja a kapott jelzés 
	    nevét, a küldő folyamat folyamatazonosítóját és a küldő folyamatot futtató felhasználó azonosítóját (userid), ugyanakkor blokkolja az illető jelzés 
	    fogadását a továbbiakban.
	    Amennyiben a listából már az összes jelzést blokkolta, írjon ki egy üzenetet, küldjön vissza egy SIGUSR1 jelzést az első folyamatnak és engedélyezze az 
	    összes jelzés fogadását.
		
		
	Megjegyzések:
		A POSIX standardban definiált jelzéskezelő függvényeket használjuk!

		A küldő folyamat azonosítóját és a felhasználó nevét a sigaction esetében az SA_SIGINFO flag beállítása 
	és a jelzéskezelő függvény megfelelő paraméterezése segítségével, valamint a getpwuid függvénnyel valósíthatjuk meg, 
	amely a <pwd.h>-ban található. 
*/

#include <iostream> // IO library
#include <unistd.h> // UNIX library
#include <error.h> //UNIX  error-handling library
#include <wait.h> // UNIX - For process syncing
#include <stdlib.h> // C Standard Library
#include <stdio.h> // C standard IO library
#include <signal.h> // UNIX signal library
#include <pwd.h>

using namespace std;

int main(int argc, char* argv[]) {

	// kill ( pid , signal )


/*
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
    signal(SIGTERM,&sigterm_handler);

*/

	// GETTING PID
	if (argc!=2) {
		perror("Invalid number of arguments!");
		exit(1);
	}

	pid_t rec = 
	

	return 0;
}
