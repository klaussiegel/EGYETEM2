// Oláh Tamás-Lajos
// otim1750
// 523 / 2

/*
 Módosítsuk az első laborfeladatot úgy, hogy az állományneveket beolvassuk
(ne a parancssor argumentumai közül vegyük).
Miután egyet feldolgoztunk, olvassuk a következőt, stb.
Amennyiben egy állomány nem található a PATH környezeti változóban
felsorolt elérési utak egyikében sem, keressünk rá rendszerhívással a find
utasítás segítségével (az alapkatalógusból kiindulva).
Ha megtaláltuk, rögzítsük az elérési útját (ha több helyen is megtalálta a
rendszer, csak az elsőt), majd hajtsuk végre az illető parancsot az execve vagy execle
függvénnyel oly módon, hogy a PATH környezeti változónak az előzőleg
megkeresett elérési utat adjuk át az execve/execle paraméterein keresztül.
Megj.: A módosítást rendszerhívásokkal oldjuk meg (ne shell-script-el) és pipe-ot használjunk, ne segédállományokat.
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

int main() {
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

	// Reading user input
    cout << "\n\nPlease enter the desired search terms below!\nThe last item should be \"END\".\n";
    string act;

	while (true) {
		cout << "\n Input: ";
		cin >> act;

		if (act=="END") return 0;

		// cout << "\n\n";
		pid_t pid1;

		if ((pid1 = fork())==-1) {
			cout << "\n\nFORK FAIL!\n\n";
			exit(1);
		}

		if (pid1==0) {
			// CHILD PROCESS

			// Converting argument to a STRING object

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
			if (!ok) {
				cout << "\t\tThere is no file with name \"" << act << "\" in PATH!\nSearching with find...\n\n";

				pid_t pidd;
				int cso[2];
				char output[4096];

				if (pipe(cso)==-1) {
					cout << "FORK ERROR!\n";
					exit(1);
				}

				if ((pidd=fork())==-1) {
					cout << "FORK ERROR!\n";
					exit(1);
				}

				if (pidd==0) {
					// CHILD
					string act_x = "-name \"" + act + "\"";

					const char* act_cc = act_x.c_str();

					dup2 (cso[1], STDOUT_FILENO);
					close(cso[0]);
					close(cso[1]);

					execl("/usr/bin/find","find","/home",act_cc,"-not","-type d","-print","-quit",NULL);
				} else {
					close(cso[1]);

					// Inspecting exit status
					int wstatus;
					waitpid(pidd,&wstatus,0);

					if (WEXITSTATUS(wstatus)==0) {
						// Valid item
						ok=true;
						db++;
						cout << "\n";
						char ok[4096];

						int nbytes = read(cso[0], output, sizeof(output));
						sprintf(ok,"Output: (%.*s)\n", nbytes, output);
						string O(ok);

						cout << "There is a match: " << O << "\nEXECUTING...\n\n";
						const char* ppp = O.c_str();
						const char* pppa[2];
						pppa[0] = O.c_str();
						pppa[1] = NULL;

						string seged;

						int i = O.length();
						while (O[i]!='/') {
							seged = seged + O[i];
							i--;
						}

						const char* seged_c = seged.c_str();

						execle(ppp,seged_c,(char*)NULL,pppa);
					} else {
						cout << "\n\nNO MATCH!\n\n";
					}
				}
			} else cout << "\t" << db << " file(s) found in PATH with name \"" << act << "\".\n";

			exit(0);
		}

		wait(NULL);
	}

	while (wait(NULL)>0); // waiting for children - we do not want zombies / orphans...

	cout << "\n\nDONE - EXITING...\n\n";

	return 0;
}
