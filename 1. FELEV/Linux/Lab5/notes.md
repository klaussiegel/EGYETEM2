# ÜZENETSOROK

A **POSIX** szabvány szerint az üzenetsorok struktúrája az **`<mqueue.h>`** header állományban található.
**Típusa :** **`mqd_t`**

## Üzenetsor struktúrája (`mq_attr`)

Minden üzenetsorhoz van rendelve **egy struktúra** ami tartalmazza a következő adatokat:

```c
    long mq_flags;
    // Az illető üzenetsor beállításait tartalmazza.
    // Beállítása a mq_setattr() fg-el lehetséges

    long mq_maxmsg;
    // Az üzenetsorban tárolható üzenetek maximális száma.
    // Ennek a mezőnek a beállítása a létrehozás során történik

    long mq_msgsize
    // Az üzenetek mérete

    long mq_curmsgs
    // Megadja az üzenetsorban található üzenetek számát

    long mq_sendwait
    // Megadja azon folyamatok számát
        //amelyek üzenetküldésre várakoznak.
    // Amennyiben az értéke nem 0, azt jelenti,
        //hogy az üzenetsor tele van

    long mq_recvwait
    //Megadja azon folyamatok számát
        //amelyek üzenet érkezésére várakoznak.
    // Amennyiben ez a szám nem 0, az üzenetsor üres
```

### Flagek:
**`MQ_NONBLOCK`** - `mq_receive()` és `mq_send()` **sosem fognak blokkolni**

## Műveletek üzenetsorokkal

### LÉTREHOZÁS
Az `mq_open()` rendszerfüggvény **megnyit vagy létrehoz egy üzenetsort**.

```c
#include <mqueue.h>

mqd_t mq_open( const char *name, int oflag, [mode_t mode], [mq_attr *attr] );
```

**Megnyitja** a `name` által jelölt üzenetsort a flagek szerint majd **visszatéríti az üzenetsor descriptorát**

#### Paraméterek:
**`name`**: **Az üzenetsor neve**( **`/...`** ).

**`oflag`**: Valamelyik az alábbiak közül:
- **O_RDONLY** (receive-only)
- **O_WRONLY** (send-only)
- **O_RDWR**  (send-receive)

**`mode`** : **A jogosultságok beállítása**
pl. : `0666` (**Megj.:** **végrehajtási jogosultság nincs figyelembe véve**).

**`attr`** : **Ez egy pointer az `mq_attr` struktúrára amely tartalmazza az üzenetsor tulajdonságait**. **`NULL` pointer** esetén **az alapértelmezett beállításokat veszi alapul**:

```c
struct mq_attr {
    mq_maxmsg = 1024;
    //ennyi üzenetet tartalmazhat

    mq_msgsize = 4096;
    // egy üzenet mérete

    mq_flags = 0;
    // Posix implementációba nem szükséges megadni
}
```

#### További flagek (`mode`):

**`O_CREAT`** : Akkor adjuk meg **ha új üzenetsort szeretnénk létrehozni**. Amennyiben meg van ez adva, akkor **az utolsó két paraméter is    számit**.
**Csak akkor ad hibát ha a name által jelölt üzenetsor létre volt hozva és minden folyamat unlink-elte** **(`mq_unlink()`) de nem zárták (`mq_close()`) be**.

**`O_EXCL`** : Hogyha az **`O_CREAT`**-al együtt megadjuk akkor l**étező üzenetsor esetén hibát ad**. **Semmi értelme magába megadni**

**`O_NONBLOCK`** : **Nem blokkoló mód**. Alapértelmezetten **akkor blokkol hogyha az üzenetsor tele van vagy üres**.

### Példa:
```c
char*  name  = argv[1];
//flagek beállítása:
int    flags = O_RDWR | O_CREAT;

//jogok beállítása:
mode_t mode  = 0666;

//struktura létrehozása és beállítása:
struct mq_attr attr;
attr.mq_maxmsg  = 10;
attr.mq_msgsize = sizeof(msg);

//Üzenetsor létrehozása:
mqd_t qid = mq_open ( name, flags, mode, &attr );
```

Eredmény:
**Ha sikerült**, **visszaküldi az üzenetsor deszkriptorát** **különben** **`-1`** és az **`errno`** **megfelelően be lesz állítva**.

### Bezárás (`mq_close()`)

A `mq_close()` rendszerfüggvény **bezár egy létező üzenetsort**

```c
#include <mqueue.h>

Int mq_close ( mqd_t mqdes );
```

Példa:
```c
mq_close(qid);                            //üzenetsor bezárása
```

Eredmény:
**`0`** **ha sikeresen bezárta különben `-1` és az `errno` megfelelően be lesz állítva**


### ÜZENET KÜLDÉSE  (`mq_send()`)

A **`mq_send()`**  rendszerfüggvény **betesz egy üzenetet egy létező üzenetsorba**.

```c
#include <mqueue.h>

int mq_send( mqd_t mqdes,
             const char *msg_ptr,
             size_t msg_len,
             unsigned int msg_prio );
```

**Az `mq_send()` beteszi a `msg_len` méretű `msq_ptr` által mutatott üzenetet `msg_prio` prioritással az `mqdes` deszkriptorú üzenetsorba**

**Az üzenetek rendezve vannak a prioritásuk szerint** (0-tól `MQ_PRIO_MAX`-ig).
**Ezen belül pedig FIFO sorrendbe.**

Ha az üzenetsor **megtelt** és az `O_NONBLOCK` **nem volt megadva**, az `mq_send()` **blokkolja a folyamatot egész addig amíg nem lesz hely**.

Példa:
```c
Msg msg = {rand() % 100, rand() % 100, rand() % 100, 0};

int prio = rand() % MQ_PRIO_MAX;

//üzenet küldése
if (mq_send(qid, (char*) &msg, sizeof(Msg), prio) == -1)
    perror("Failed to send msg");
```

Eredmeny:

**`0`** **ha sikeresen bezárta különben `-1` és az `errno` megfelelően be lesz állítva**

### ÜZENET FOGADÁSA  (`mq_receive()`)

Az **`mq_receive()`** rendszerfüggvény **kiolvas egy üzenetet egy létező üzenetsorból**.

```c
#include <mqueue.h>

int mq_receive( mqd_t mqdes,
                char *msg_ptr,
                size_t msg_len,
                unsigned int *msg_prio );
```

**Az `mq_receive()` kiolvas egy `msg_len` méretű üzenetet az `mqdes` deszkriptorú üzenetsorból az `msg_ptr` által mutatott helyre.**
**A `msg_prio` arra az egészre (`int`) mutat amelybe a prioritást fogjuk megkapni**

**`mq_receive()`** abban az esetben **blokkol** ha:
- **nincs üzenet**
- **`O_NONBLOCK` nem volt bealítva az `mq_open()` hívásakor.**

---

Ha nem érdekel az üzenet prioritása akkor az msg_prio NULL.



Példa:

                Msg msgr = {0,0,0,0};

        if (mq_receive(qid, (char*) &msgr, sizeof(msgr), 0) != -1)  //válasz fogadása

        {

              printf("szum = %d\n", msgr.szum);

        }

        else

        {

                    perror("mq_receive");

                    return(1);

        }

Eredmény:

            Kiolvasott üzenet mérete ha sikerult.

            -1 ha nem sikerült.

Lecsatlakozás az üzenetsorról  (mq_unlink ())

Az mq_unlink() rendszerfüggvény lecsatlakozik az üzenetsorról

Szintaxis:

#include <mqueue.h>

int mq_unlink( const char *name );

Megjegyzés:
            mq_close()-al ellentétben nem törli az üzenetsort, csak lecsatlakozik róla.

Példa:

mq_unlink(argv[1]);                       //üzenetsor torlése

Eredmény:
            0: sikeres
            -1: sikertelen és errno-t beállítja

Üzenetsor tulajdonságainak lekérdezése  (mq_getattr())

Az mq_getattr() rendszerfüggvény lekérdézi az üzenetsor tulajdonságait.

Szintaxis:

#include <mqueue.h>

int mq_getattr( mqd_t mqdes,

                struct mq_attr *mqstat );

Lekéri az mqdes deszkriptorú üzenetsor tulajdonságait és elmenti az mqstat pointer által mutatott struktúrába.

Példa:

struct mq_attr temp;

if (mq_getattr( qid, &temp) == -1 )       //Üzenetsor tulajdonságainak lekérdezése

      perror("getattr:");

else

printf("maxmsg = %d\n", temp.mq_maxmsg);

Eredmény:
            0: sikeres
            -1: sikertelen és errno-t beállítja

Üzenetsor tulajdonságainak beállítása (mq_setattr())

Az mq_setattr() rendszerfüggvény beállítja az üzenetsor tulajdonságait.

Szintaxis:
                        #include <mqueue.h>

int mq_setattr( mqd_t mqdes,

                const struct mq_attr *mqstat,

                struct mq_attr *omqstat );

Beállítja az mqdes tulajdonságait az mqstat pointer által mutatott struktúra szerint.
Amennyiben az omqstat nem NULL, az omqstat által mutatott struktúra megkapja a régi beállítások.
Az mq_maxmsg és mq_msgsize mezők figyelmen kívül maradnak.

Példa:

struct mq_attr newattr;

      //adatok beálitása

if (mq_setattr(qid,&newattr,NULL) == -1)

      perror("setattr:")

Eredmény:
            0: sikeres
            -1: sikertelen és errno-t beállítja