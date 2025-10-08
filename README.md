
# Docker per Ambiente di sviluppo di Entando #

## Indice ##

- [Introduzione](#introduzione)
  - [Obbiettivi del progetto](#obbiettivi-del-progetto)
  - [Versioni di riferimento](#versioni-di-riferimento)

- [Prerequisiti](#prerequisiti)
  - [Definizione Environment](#definizione-environment)
  - [Definizione Domini](#definizione-domini)
  - [Configurazione Domini](#configurazione-domini)
  - [Porte in uso](#porte-in-uso)
  - [Link finali](#link-finali)

- [Applicativi Docker](#applicativi-docker)
  - [Avvio dei container](#avvio-dei-container)
  - [Stop dei container](#stop-dei-container)
  - [Postgres](#postgres)
  - [MySql](#mysql)
  - [Keycloak](#keycloak)
  - [Redis](#redis)
  - [App Builder](#app-builder)
  - [CDS](#cds)
  - [Nginx](#nginx)
  - [Volumi](#volumi)

- [Entando De App](#entando-de-app)
  - [Creazione Progetto](#creazione-progetto)
  - [Configurazione IntelliJ](#configurazione-intellij)
  - [Avvio su IntelliJ](#avvio-su-intellij)
    - [Configurazione di Run](#configurazione-di-run)
    - [Parametri di Environment](#parametri-di-environment)


## Introduzione ##

### Obbiettivi del progetto ###

Gli obbiettivi di questo progetto sono:  
- fornire un ambiente di sviluppo locale a supporto della entando-de-app `7.3`
- avviare tutti i componenti necessari
- supportare un ambiente di sviluppo multitenant


> [Vai all'indice](#indice)

---


### Versioni di riferimento ###

- Entando: `Entando 7.3`



> [Vai all'indice](#indice)

---

## Prerequisiti  ##

### Definizione Environment ###

Il file di partenza della configurazione è il file [.env](.env).  
In tale file sono presenti i seguenti parametri:  
- `COMPOSE_PROJECT_NAME`: il nome del progetto, che è usato come prefisso dei container. Di default è `portal`.
- `COMPOSE_FILE`: il nome del file con la configurazione del docker-compose

Se si vuole cnfigurare un nuovo ambiente, ad esempio per una particolare versione di entando o un nuovo progetto, 
occorre partire da qui.  
Un caso d'uso classico è quello di una versione particolare di entando, o un progetto.  
Sarà buona norma creare un nuovo file docker-compose, e configurarlo come valore del parametro `COMPOSE_FILE` del file [.env](.env).

Il docker-compose andrà configurato opportunamente nei volumi, in modo da non andare in conflitto con la configurazione degli altri progetti.  


> [Vai all'indice](#indice)

---


### Definizione Domini  ###

Per prima cosa occorre definire una serie dominio di riferimento, es:  
 - **entando**: 
   - `portal.entando.local`
 - **keycloak**:
   - `portal.entando.local` con `context` uguale ad `auth`
   - `auth.entando.local` su dominio distinto
 - **cds** (Content Delidery Service):
   - `portal.entando.local` con `context` uguale a `cds`
   - `cds.entando.local` su dominio distinto 
 - **eventuali tenant**: es:  
   - `t1.entando.local`
   - `t2.entando.local`
   - `t3.entando.local`

Occorre inoltre definire i **context** dei vari applicativi, es:  
 - **entando**: `/entando-de-app`
 - **app builder**: `/app-builder`
 - **keycloak**: `/auth`  
 - **cds**: `/cds`  


> [Vai all'indice](#indice)

---


### Configurazione Domini  ###

Occorre configurare/modificare i domini nei seguenti punti:  
 - [nginx.conf](_nginx/nginx.conf):  
 ```
 server_name portal.entando.local;
 ...
 server_name auth.entando.local;
 ...
 server_name cds.entando.local;
 ...
 server_name t1.entando.local;
 ...
 server_name t2.entando.local;
 ...
 server_name t3.entando.local;
 ```
 - [comando di avvio](#comando-di-avvio):  
 - file `etc/hosts` della macchina, es:  

 ```
127.0.0.1		portal.entando.local auth.entando.local cds.entando.local t1.entando.local t2.entando.local t3.entando.local
 ```


> [Vai all'indice](#indice)

---


### Porte in uso  ###

Questo sistema fa uso delle seguenti porte:  
 - **8080**: porta utilizzata dalla `entando-de-app`, definita in:  
   - [comando di avvio](#comando-di-avvio):  
    `-Djetty.http.port=8080`
   - [nginx.conf](_nginx/nginx.conf):  
    `proxy_pass http://172.17.0.1:8080;`
 - **15432**: porta utilizzata dal container di `postgres`, definita in:  
   - [docker compose](docker-compose-default.yml)
   - [comando di avvio](#comando-di-avvio):  
```
-Dportdb.url=jdbc:postgresql://localhost:15432/entando?currentSchema=port
...
-Dservdb.url=jdbc:postgresql://localhost:15432/entando?currentSchema=serv
```

 - **16379**: porta utilizzata dal container di `redis`, definita in:  
   - [docker compose](docker-compose-default.yml)
   - [comando di avvio](#comando-di-avvio):  
```
-DredisAddress=redis://localhost:16379
```

 - **18080**: porta utilizzata dal container di `cds`, definita in:  
   - [docker compose](docker-compose-default.yml)
   - [comando di avvio](#comando-di-avvio):  
```
-DCDS_PRIVATE_URL=http://localhost:18080/
```

 - **80**: porta utilizzata dal container di `nginx`, definita in:  
   - [docker compose](docker-compose-default.yml)



> [Vai all'indice](#indice)

---


### Link finali ###

- [entando-de-app](http://portal.entando.local/entando-de-app/)
- [admin-console](http://portal.entando.local/entando-de-app/do/main)
- [app-builder](http://portal.entando.local/app-builder/)
- [cds](http://portal.entando.local/cds) oppure [cds](http://cds.entando.local/)
- [keycloak](http://portal.entando.local/auth/) oppure [keycloak](http://auth.entando.local/auth/) 



> [Vai all'indice](#indice)

---


## Applicativi Docker ##


### Avvio dei container ###

I container possono essere avviati col comando:  
```bash
docker-compose up -d --no-deps --build
```

Oppure utilizzando lo script:  
```bash
./docker-create.sh
```

> [Vai all'indice](#indice)

---


### Stop dei container ###

I container possono essere stoppati col comando:  
```bash
docker-compose down --rmi local
```

Oppure utilizzando lo script:  
```bash
./docker-destroy.sh
```

> [Vai all'indice](#indice)

---


### Postgres ###

Il [docker-compose](docker-compose-default.yml) crea una istanza di PostgreSQL contenente un DB `entando` inizializzato coi seguenti schema:  
- port
- serv
- keycloak
- digital_exchange
- t1
- t2
- t3

Ogni schema ha utente e password uguali al nome dello schema.

Il container espone la porta `15432`

Comando di rigenerazione container:

```bash
./docker-service-regen.sh postgresql
```

> [Vai all'indice](#indice)

---


### MySQL ###

Il [docker-compose](docker-compose-default.yml) crea una istanza di MySQL contenente i seguenti DB:
- port
- serv
- keycloak
- digital_exchange
- t1
- t2
- t3

Come credenziali di accesso possono essere utilizzate root/password

Il container espone la porta `13306`

Comando di rigenerazione container:

```bash
./docker-service-regen.sh mysql
```

> [Vai all'indice](#indice)

---


### Keycloak ###

Il database di keycloak è popolato usando i file contenuti nella directory [realm-config](_keycloak/realm-config)  
Questi file generano i realm:
- entando-dev
- entando-t1
- entando-t2
- entando-t3

Ogni realm contiene i client:
- external: avente come password `external`, usato per l'accesso esterno da entando, come superuser
- webapp: usato per l'accesso da app-builder

Ogni realm contiene gli utenti:
- admin: avente password admin
- user: avente password user

Comando di rigenerazione container:

```bash
./docker-service-regen.sh keycloak
```



> [Vai all'indice](#indice)

---


### Redis ###

TODO

Comando di rigenerazione container:

```bash
./docker-service-regen.sh redis
```

> [Vai all'indice](#indice)

---


### App Builder ###

Sorgenti: [release 7.3](https://github.com/entando/app-builder/tree/release/7.3)

Comando di rigenerazione container:

```bash
./docker-service-regen.sh app-builder
```



> [Vai all'indice](#indice)

---


### CDS ###

[Documentazione](https://developer.entando.com/next/tutorials/consume/cds.html#configure-the-entandoapp-to-use-cds)

**** IMPORTANTE! ****  
Avviato Keycloak la prima volta, occorre estrapolare la "Public Key" da ogni REALM, 
e inserirla nel relativo parametro di environment del [docker-compose](docker-compose-default.yml).  
Le chiavi possono essere recuperate nei seguenti link:
- [entando-dev](http://portal.entando.local/auth/admin/master/console/#/realms/entando-dev/keys)
- [entando-t1](http://portal.entando.local/auth/admin/master/console/#/realms/entando-t1/keys)
- [entando-t2](http://portal.entando.local/auth/admin/master/console/#/realms/entando-t2/keys)
- [entando-t3](http://portal.entando.local/auth/admin/master/console/#/realms/entando-t3/keys)

Al termine occorre rigenerare i container della CDS

Comando di rigenerazione container:

```bash
./docker-service-regen.sh cds
./docker-service-regen.sh cds-t1
./docker-service-regen.sh cds-t2
./docker-service-regen.sh cds-t3
```

> [Vai all'indice](#indice)

---


### Nginx ###

TODO

Comando di rigenerazione container:

```bash
./docker-service-regen.sh nginx
```

> [Vai all'indice](#indice)

---


### Volumi ###

I volumi sono dentro la cartella [_volumes](_volumes).  
Se si desidera cambiare i volumi, ad esempio per differenti environment, si può procedere come segue:  
- rinominare, dentro aaa, tutte le occorrente di `_volumes/portal` in `_volumes/custom-project`, dove
  custom-project va personalizzato come si preferisce

Il file system dei volumi può dare problemi per via dei permessi di r/w, 
sia per esplorarne il contenuto, che soprattutto per i container in fase di avvio.  
Può essere utile modificare i permessi in modo che le directory e i file siano visibili e modificabili a tutti.  
Ovviamente questa soluzione espone alla possibilità che un altro utente della macchina possa accedere a questi dati.  
Si sconsiglia di farlo, soprattutto in presenza di dati (es: i database) sensibili.  

Il seguente comando, rende la directory _volumes e tutte le sotto-directory, visibili a tutti:  
```bash
sudo find _volumes/ -type d  -exec chmod 777 {} \;
```
mentre il seguente comando rende i file sotto l'alberatura di _volumes visibili e modificabili da tutti:

```bash
sudo find _volumes/ -type f  -exec chmod 666 {} \;
```

> [Vai all'indice](#indice)

---


## Entando De App ##


#### Creazione Progetto ####

Occorre creare il progetto partendo dai sorgenti di [app-engine](https://github.com/entando/app-engine/tree/release/7.3)

Es:

```bash
git clone -b release/7.3 https://github.com/entando/app-engine/
```


> [Vai all'indice](#indice)

---

#### Configurazione IntelliJ ####

Il progetto richiede `Java 11`.

Una volta clonato il progetto e importato su 'IntelliJ', occorre:  
- aprire `File -> Project Structure`
- nella sezione `Project`:  
    - modificare la voce `SDK` impostando `11`
    - modificare la voce `Language Level` impostando `SDK default`
- assicurarsi che i moduli (sezione `Modules`) facciano tutti uso della SDK `11`


> [Vai all'indice](#indice)

---


#### Avvio su IntelliJ ####

Per configurare l'avvio di Entando occorre:  
- aprire `Edit Configurations`
- aggiungere/modificare una `New Configuration` di `Maven`
- definire un name adatto (es: il nome del progetto)
- selezionare come `Working Directory` la cartella `webapp`
- assicurarsi che la `JRE` in uso sia la `11`
- definire nel campo `Run` come in questo [esempio](.run/parametri-environment.md) opportunamente modificato (in base a quanto definito nel resto del documento)
- in Java Options, abilitare Environment Variables e valorizzare il campo secondo questo [esempio](.run/parametri-avvio.md) opportunamente modificato (in base a quanto definito nel resto del documento)

In alternativa si possono usare e modificare i file di esempio contenuti dentro la cartella [.run](.run) 
ed elencati nel [paragrafo seguente](#configurazione-di-run)


##### Configurazione di Run #####

Dentro la cartella .run sono presenti configurazioni di run di IntelliJ. In particolare:
- [Portale con Multitenancy](.run/portal.run.xml)
- [Portale senza Multitenancy](.run/portal-no-tenants.run.xml)
- [Portale senza App Builder](.run/portal-no-app-builder.run.xml)
- [Portale senza Keycloak](.run/portal-no-keycloak.run.xml)

Sono inoltre presenti le configurazioni anche per MySQL:
- [Portale con Multitenancy](.run/mysql/portal-mysql.run.xml)
- [Portale senza Multitenancy](.run/mysql/portal-mysql-no-tenants.run.xml)
- [Portale senza App Builder](.run/mysql/portal-mysql-no-app-builder.run.xml)
- [Portale senza Keycloak](.run/mysql/portal-mysql-no-keycloak.run.xml)


> [Vai all'indice](#indice)

---
