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

<h3>Anleitung fürs hosten einer Statischen Webseite mit Cloudfront:</h3> 

<h4>1. Regestrieren einer Domäne</h4>

Wir haben uns für das Projekt eine Domäne von [!Hostpoint](https://www.hostpoint.ch/en/) geholt, damit wir der Webseite selbst eine Domäne geben können.

<h4>2. Ein öffentliches Zertifikat anfordern</h4>



<h4>3. </h4>

<h4>4. </h4>

<h4>5. </h4>

<h4>6. </h4>

<h4>7. </h4>

<h4>8.</h4>

<h4>9. </h4>

<h4>10. </h4>
