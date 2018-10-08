// Oláh Tamás-Lajos
// otim1750
// 513 / 2

/*
	1. Írjunk C/C++ programot, mely paraméterként megadott állományneveket
	keres a felhasználó keresési útvonalában ($PATH) megadott katalógusokban.

	A parancssor minden egyes paraméterére megvizsgálja a keresési útvonalban
	szereplő összes katalógust, és ha van benne az adott paraméterrel megegyező
	nevű állomány, információt kér róla az alább megadott shell parancsok egyikének segítségével.

	A program kezelje az esetleges hibákat.

	Megjegyzések:
	Minden megadott paraméter esetén, a keresési útvonalban szereplő minden katalógusra az

	1,4,9) ls -l <katalógusnév>/<paraméter>

	parancsot kell végrehajtani.

	A parancs végrehajtására ne a popen vagy system függvényeket használjuk,
	hanem az exec függvénycsalád egyikét. (ti. a popen és system is ezeket használja),
	a sorszámnak megfelelően (a feladat többi része közös):

	1-3) execl
*/

#include <iostream> // Input & Output
#include <unistd.h> // Linux / UNIX tools
#include <cstdlib> // C standard library
#include <sstream> // String stream library
#include <cstdio> // C Standard library
#include <string> // C++ String library
#include <wait.h> // For wait
#include <deque> // Double-ended queue

using namespace std;

int main(int argc, char* argv[]) {
	// Argument number validation

	if (argc<=1) {
		cout << "\n\nNot enogh arguments!\n\t USAGE: " << argv[0] << " [file] [file] ...\n\n";
		exit(1);
	}

	// Splicing the PATH by the ":" delimiter into a deque (double-ended queue)

	string path = getenv("PATH"); // Getting the PATH variable into a string object
	stringstream s_path(path); // Converting string object "path" (containig the PATH) into a string stream
	string buffer; // Creating a temporary string buffer
	deque<string> list; // This will contain the PATH, spliced by the ":" delimiter

	while (getline(s_path,buffer,':')) { // Reading the PATH variable by the ":" delimiter
		list.push_back(buffer); // Pushing the individual segments into a deque
	}

	cout << "\n\n";

	// PRINT PATH

	// for (string a : list) {
	// 	cout<<a<<"\n";
	// }

	for (int i=1; i<argc; ++i) { // Iterating through the arguments
		// cout << "\n\n";
		pid_t pid1;

		if ((pid1 = fork())==-1) {
			cout << "\n\nFORK FAIL!\n\n";
			exit(1);
		}

		if (pid1==0) {
			// CHILD PROCESS

			// Converting argument to a STRING object
			string act(argv[i]);

			bool ok = false; // Monitoring if there was a valid item

			int db = 0; // counting the number of valid items

			// CONCAT argument to PATH
			for (string a : list) {
				// cout<< "\n\n\t" << act << "\n";
				pid_t pid2;

				if ((pid2 = fork())==-1) {
					cout << "\n\nFORK FAIL!\n\n";
					exit(1);
				}

				if (pid2==0) {
					// CHILD PROCESS

					// Constructing EXECUTABLE path
					// $PATH + "/" + argument

					string ex = a + "/" + act;
					const char* cex = ex.c_str(); // Converting STRING object to C-style string to use with EXECL

					// Print the executable path
					// cout << "\n\t" << ex << "\n\n";

					// Redirecting STDERR to /dev/null

					FILE* f = fopen("/dev/null","w");
					dup2(fileno(f),STDERR_FILENO);
					fclose(f);

					// EXECUTING

					if ( execl("/bin/ls","ls","-l",cex,NULL) == -1) {
						cout << "\n\n\t\tEXECUTION ERROR!\n\n";
						exit(1);
					}

					exit(0);
				}

				// Inspecting exit status
				int wstatus;
				waitpid(pid2,&wstatus,0);

				if (WEXITSTATUS(wstatus)==0) {
					// Valid item
					ok=true;
					db++;
					cout << "\n";
				}

				while (wait(NULL)>0); // waiting for children - we do not want zombies / orphans...
			}

			// FANCY - REQUIRES ADDITIONAL WAITING
			// if (!ok) cout << "\n\tThere is no file with name \"" << act << "\" in PATH!\n\n\n\n\n\n";
			// else cout << "\n\t" << db << " file(s) found in PATH with name \"" << act << "\".\n\n\n\n\n\n";

			// UGLY, BUT WORKS
			if (!ok) cout << "\t\tThere is no file with name \"" << act << "\" in PATH!\n";
			else cout << "\t" << db << " file(s) found in PATH with name \"" << act << "\".\n";

			exit(0);
		}
			// FOR FANCIER OUTPUT
			// wait(NULL);
	}

	while (wait(NULL)>0); // waiting for children - we do not want zombies / orphans...

	cout << "\n\nDONE - EXITING...\n\n";

	return 0;
}
