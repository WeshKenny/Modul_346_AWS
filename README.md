# Modul_346_AWS
Modul 346 von Gibb 

<h2>Dokumentation Modul 346</h2>  

<h3> EC2 Instanz erstellen mit AWS (GUI) </h3>

Wenn wir uns eingeloggt haben, geben wir in der Suchleiste oben „EC2“ ein und wählen den ersten Service aus.
 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/3c68e1da-39ba-42d3-8e4c-ee1f4b6d7525)

Dort im Menü angekommen, klicken wir in der bitte des Bildschirms auf „Instance Starten“.
 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/facc54e7-537b-440f-81c1-b34e0cb08c29)

Im Feld „Name“, kann man seinem eigenen Namen auswählen. Danach kann man weiter unten die Distribution der Instanz auswählen und auch wie gross sie sein soll. Dort haben wir folgende Einstellungen ausgewählt:
 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/26d86714-6f9a-481e-99ae-41b8ea4d1227)

 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/1572a925-87cd-4dd9-922e-0c0e4fbb1808)

Nun haben wir das OS und den Typ der Instanz gewählt. Nun wollen wir beim Nächsten Schritt noch ein SSH Key hinzufügen. Wir haben vorhin schon einen für das Projekt erstellt und haben den dann dort einfach ausgewählt. Es sind .ppk Schlüsselpaare, damit ich mich via Putty drauf verbinden kann.
 
![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/07920b21-7afb-440b-9a6c-7afe09bcc2df)


Nun müssen wir noch das VPC, also das Netzwerk, in dem die Instanz ist, auswählen. Dies haben wir auch schon erstellt und so also nur noch ausgewählt.
 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/5064e976-990b-4330-ab07-e721e02c1097)

Danach haben wir alles angegeben und können nun die Instanz starten.
 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/51a5fc04-2354-4ac3-b2cb-2e89308d2132)

Nun müssen wir noch kurz warten, da die Instanz noch am Hochfahren ist. Sobald sie bereit ist steht dort „Läuft“ so kann man sich dann auch mit dem SSH drauf verbinden.  
![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/15252d90-227e-4ec8-877d-8dbb354a1c67)

Wenn man sich Via SSH verbinden will, braucht man die Public IP Adresse von der Instanz.


<h3>Instanz erstellen via Terraform</h3> 

Das Skript befindet sich hier:

[Hier Kilcken umdas Skript zu sehen!](Dateien/Modul_346.tf)


Datenbank Erstellen und verbinden
Zuerst geben wir oben in der Suchleiste «RDS» ein. Dann wählen wir den ersten Service aus. Nun wählen wir jetzt «Create Database» und wählen «Easy create» aus.
 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/46219a46-4da2-417d-89a7-f70ecfeba06d)

In den Konfigurationen wählen wir «MySQL» aus und wählen für den Typen der Datenbank «Free tier» aus.
 ![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/3facb641-5aae-44b3-b3ad-0fe6496ab6b9)

Nun als nächstes können wir auch noch den «Identifier» für die Datenbank angeben. So wie auch den Benutzer für die Datenbank und das Passwort. 
Danach kann man direkt eine Verbindung zu einer EC2 Instanz aufbauen. Wenn man bereits eine EC2 Instanz hat, kann man sie direkt auswählen.
![image](https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/eb5c61f0-6fd1-4742-9138-65dc83c5e395)

Nun können wir die Datenbank erstellen. Dies kann auch ein Weilchen dauern.
Diese Informationen sind für uns wichtig:
 
Nun geben wir folgendes in die Kommandozeile ein von der EC2 Instanz:

**mysql -h database-1.cjuioqs2k05y.us-east-1.rds.amazonaws.com -P 3306 -u vmadmin -p**

mit -u geben wir den Benutzer an.

Wenn man alle diese Schritte gemacht haben, dann haben wir 2 Linux Instanzen aufgesetzt eine davon wurde mit Terraform erstellt, welche apache installiert hat. Dort haben wir auch eine Webseite, auf die man sich verbinden kann. Die andere Instanz ist mit einer MySQL Datenbank verbunden. Die Datenbank besitzt bereits Tabellen welche jedoch noch keinen Inhalt haben. Ein VPC (Netzwerk) haben wir auch 2, wir sollten im einen VPC auch noch ein Subnetz haben. Wir haben Sicherheits gruppen erstellt, die den Port 80 so wie den Port 22 offen haben, damit wir uns mit HTTP und SSH drauf verbinden können.

**<h2>Workshop 3 & 4</h2>**

Ich und Natnael waren mit unseren Projekten schon von Anfang an etwas langsam unterwegs. Da Ich bereits eine HTML Seite Erstellt habe, kamen wir auf die Idee, diese über aws zu hosten. Da es so aber etwas zu einfach gewesen wäre, haben wir noch einige andere Kritereien befolgen, damit wir auch eine Herausforderung hatten. Unsere Kriterien zur Webseite waren:

- Von einem S3 Buckt aus hosten
- Eigene Domäne für Webseite
- SSL Zertifikat so das unsere Webseite als Sicher angezeigt wird.
- Webseite soll öffentlich zugänglich sein.

Wir haben uns dann ein Wenig darüber informiert, wie wir das machen können und was wir für Services von AWS benötigen. Hier sind die benötigten `Services fürs Projekt`:

- S3 (Speicher, der das html speichert)
- Cloudfront (Sicheres Publizieren der Webseite)
- Certificate Manager (für das SSL Zertifikat)
- Route 53 (Traffic von der Domäne zur Cloudfront zu Routen)

<h2>Anleitung fürs hosten einer Statischen Webseite mit Cloudfront:</h2> 

<h3>1. Regestrieren einer Domäne</h3>

Wir haben uns für das Projekt eine Domäne von [Hostpoint](https://www.hostpoint.ch/en/) geholt, damit wir der Webseite selbst eine Domäne geben können.

<h3>2. Hosted zone erstellen</h3>

Wir brauchen eine "Hosted zone", in der wir DNS Records erstellen und die dann zu einer einzelnen Domäne gehören.

1. In der Suchleiste suchen nach `Route 53`.
2. Dort klicken wir auf `Create hosted zone`.
3. Dort geben wir dann unsere Root Domäne an. bei uns: `elfenau3006.ch`
4. Dann klicken wir auf `Create hosted zone`.

<h3>3. Ein öffentliches Zertifikat anfordern</h3>

Um eine Cloudfront distribution zu erstellen ist ein öffentliches Zertifikat notwendig. Damit wir ein Zertifikat anfordern können, müssen wir folgendes tun

1. In der Suchleiste suchen wir nach `Certificate Manager`.
2. Dort wählen wir `Request a certificate` aus.
3. Wir klicken `next`
4. Beim "Fully qualified domain name " geben wir unsere Domäne ein, die wir von Hostpoint gekauft haben, also: `elfenau3006.ch`.
   Wir fügen noch einen Zertifikatsnamen hinzu und zwar unsere Domäne, jedoch noch mit einem `*` vordran. Also: `*.elfenau3006.ch`.
   Damit fügen wir auch alle Subdomains noch hinzu.
5. Danach klicken wir auf `Anfrage`.
6. Danach können wir unsere Domains sehen, die den Status `Pending`haben. Wir klicken in dem Menü auf "Create records in Route 53" und klicken "Create records".
   Es sollte nicht zulange gehen, bis unser Zertifikat auf `Issued`.
   
<h3>4. Hostpoint Nameserver ändern</h3>

Damit alles dann aufgelöst wird, müssen wir noch der Domain den Nameserver von AWS zuweisen.

1. Bei [Hostpoint](https://www.hostpoint.ch/en) melden wir uns an und gehen auf unsere Domain und klicken auf "edit"S
2. Nun müssen wir die Daten von der Route 53 Zone dort bei Hostpoint angeben:
   
   <img width="374" alt="image" src="https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/799eaa4f-c553-44a0-a897-ed196d42d818">
   
   Diese `Value/Route traffic to` setzen wir so ein:

   <img width="374" alt="image" src="https://github.com/WeshKenny/Modul_346_AWS/assets/115809872/958da29b-8d2d-4a64-98bd-ed39f502b8cb">

4. Dann klicken wir auf "Check Name Servers"
   dies kann bis zu 24 Stunden dauern.
5. Wenn es dann den Nameserver angenommen hat, dann ist auf das Zertifikat bereit zur Nutzung.
   
<h3>5. Erstellen eines S3 Buckets fürs Hosten der subdomain</h3>

1. In der Suchleiste suchen wir nach `S3`.
2. Auf `Create bucket` klicken
3. "Bucket name" setzen wir auf `www.elfenau3006.ch`
4. Auf "Create bucket" klicken.

<h3>6. Erstellen eines S3 Buckets fürs hosten der root Domain</h3>

1. In der Suchleiste suchen wir nach `S3`.
2. Auf `Create bucket` klicken
3. "Bucket name" setzen wir auf `elfenau3006.ch`
4. Auf "Create bucket" klicken.

<h3>7. Html files auf Subdomain Bucket hochladen</h3>

1. In der Suchleiste suchen wir nach `S3`.
2. Auf den bucket `www.elfenau3006.ch` klicken
3. Klicken auf `Upload`.
4. Die Dateien auswählen und auf "Add files" klicken.

<h3>8. Root Domain Bucket umleitung einstellen</h3>

Unser Ziel ist es der wenn man die Root Domain eingibt: `elfenau3006.ch`, das man weitergeleitet wird auf `www.elfenau3006.ch`.

1. In der Suchleiste suchen wir nach `S3`.
2. Wähle den bucket aus mit der root domain. Bei uns war es: `elfenau3006.ch`
3. Bei `Static website hosting` "edit" auswählen.
4. auf "Enable setzen".
5. Dort dann die Subdomain angeben. Bei uns: `www.elfenau3006.ch`.
6. HTTPS als Protokol auswählen.
7. Einstellungen Speichern.
8. Den Endpoint merken.
   
<h3>9. Cloudfront Distribution für Subdomain erstellen</h3>

Damit das öffnen der Webseite schneller geht können wir eine Cloudfront erstellen.

1. In der Suchleiste nach Cloudfront suchen.
2. "Create Distribution" auswählen.
3. Unter "Origin wählen wir bei "Origin domain" unsere Subdomain.
4. **Origin access** --> **Legacy access identities**
5. Wir erstellen eine neue OAI und wählen sie aus.
6. Bucket police auf "Yes, update the bucket policy"
7. `Redirect HTTP to HTTPS` auswählen.
8. "Web Application Firewall (WAF) ausschalten
9. Wir wählen "Add Item" unt geben dort dann unsere Subdomain ein: `www.elfenau3006.ch`
10. Wir wählen dann als nächstes unser SSL Certifikat aus
11. Bei `Default root object` wählen wir unsere HTML seite aus, damit wenn man unsere Seite aufruft, dass dann nunsere HTML seite angezeigt wird.
12. Danach auf `Create Distribution` klicken.

<h3>10.  Cloudfront Distribution für root domain erstellen</h3>

Das gleiche machen wir jetzt noch mit der root domain. Wenn man dann dort zugreift wird man auf den anderen Bucket witergelietet.

1. In der Suchleiste nach Cloudfront suchen.
2. "Create Distribution" auswählen.
3. Unter "Origin wählen wir bei "Origin domain" unsere root domain.
4. **Origin access** --> **Legacy access identities**
5. Wir erstellen eine neue OAI und wählen sie aus.
6. Bucket police auf "Yes, update the bucket policy"
7. `Redirect HTTP to HTTPS` auswählen.
8. "Web Application Firewall (WAF) ausschalten
9. Wir wählen "Add Item" unt geben dort dann unsere Subdomain ein: `elfenau3006.ch`
10. Wir wählen dann als nächstes unser SSL Certifikat aus
12. Danach auf `Create Distribution` klicken.

<h3>11. DNS Traffic von Domain zu CLoudfront routen.</h3>



