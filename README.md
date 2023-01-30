# Wilken Contentservice Mock Windows Installer

Installation des Contentservice Mock auf Windows basierten Server und Client Systemen. Nach Installation können bis zu 5 Instanzen des Mocks lokal betrieben werden.

## Installationsvoraussetzungen 
  * Zugriff auf das Internet (Herunterladen der Installation)
  * Lokale Administrationsrechte für die Registrierung des Windows Service 
  * Halbwegs modernes Windows Betriebssystem (> XP auf Client, >= Windows Server 2008 R2)

## Download wds_wcsmock_installer

Die Installer zips sind unter https://github.com/Wilken-Entire-GmbH/wcs_mock_install/releases hinterlegt. 

Das *wcs_mock_installer.zip* ist für das jeweilige Release unter Assets hinterlegt. Download erfolgt direkt durch Anklicken des Links.

Ist das Release bekannt kann der Link direkt im Browser eingegeben werden und der Download erfolgt sofort. 

Beispiel: https://github.com/Wilken-Entire-GmbH/wcs_mock_install/releases/download/v1.3.102/wds_wcsmock_install.zip

## Entpacken der Installation
Zip-Datei in beliebigem Installationsverzeichnis (lokale Platte) entpacken.

Beispiel: c:\wilken\wcsmock 

Bitte Pfade ohne Leerzeichen und Sonderzeichen wählen. 

## Inhalt der Installation 
Nach dem Entpacken sind folgende Verzeichnisse ab Installationsverzeichnis verfügbar: 

Verzeichnis | Beschreibung 
-|-
app\p5dms | Beinhaltet das Binary wds_contentservice_mock.exe
config\p5dms | Beinhaltet die Konfiguration des/der Mock Services
control | Bat Skripte zur Registrierung/Deregistrierung, Starten/Stoppen des/der Mock Service(s)
runtime\p5dms\<mockid> | Ablageort für Logfiles und die WCS Daten. Die Ids (mockid) der 5 möglichen Serviceinstanzen sind definiert als *svc1* bis *svc5*

## Globale Konfiguration
Einmalig muss die IP oder der Rechnername hinterlegt werden. Diese Information wird in der WSDL für den Servicenamen verwendet.

IP oder Rechnername in der Datei config\p5dms\envInitialize.yaml unter SOAP_HOSTNAME eintragen.

Als Defaultwert ist 127.0.0.1 hinterlegt. Dies ermöglicht ausschließlich lokale Zugriffe. 

```yaml
SOAP_HOSTNAME: 127.0.0.1 
```
## Windows Service Verwaltungsfunktionen
Für die Windows Service Installation sind lokale Adminrechte erforderlich. Die Bat-Skripte für Installation/Deinstallation, Starten/Stoppen befinden sich unter \control. 

Folgende Beispiele sind abgebildet für den Mockservice svc1.

### Service installieren 
```bash
wds_install svc1  
```

Der Service ist nun registriert und wird unter Dienste angezeigt.

### Service starten 
```bash 
wds_start svc1 
```
Der Service wird gestartet.

WSDL: http://<SOAP_HOSTNAME>:6910/soap/ContentService?wsdl

Swagger-ui: http://<SOAP_HOSTNAME>:6910 

Port 6910 kann für den Service entsprechend angepasst werden. Siehe weiter unten "Mockservice konfigurieren"

### Service stoppen
```bash 
wds_stop svc1
```

Der Service wird angehalten. 

### Service deinstallieren
```bash 
wds_remove svc1
``` 

Der Service wird vom Rechner entfernt und wird unter Dienste nicht mehr angezeigt.

## Mockservice konfigurieren
Der Mockservice wird bereits vorkonfiguriert ausgeliefert. Diese Konfiguation kann nach den individuellen Bedürfnissen angepasst werden. 

Die Konfigurationen der Mockservices befindet sich unter \config\p5dms\tenants\<mockid>.env 

Hier der ausgelieferte Inhalt von svc1: 

```yaml
# P5/2 DMS WCS3 Mockservice Tenant Configuration

# tenant 
TENANT_CAPTION: SVC1 WCS3 Mock

# http port of service
WDSMOCK_HTTP_PORT: 6910

# extend logging of soap calls
WDSMOCK_SOAP_LOG: true 
WDSMOCK_SOAPCONFIG_LOG: true
```

Die Parameter haben folgende Bedeutung:

Parameter | Beschreibung 
-|-
WDSMOCK_HTTP_PORT | Legt den Port fest über den auf den Service zugegriffen wird.
TENANT_CAPTION | Legt den Titel der Swagger UI im Browser fest. 
WDSMOCK_SOAP_LOG | Erweitertes SOAP Logging Contentservice an/aus.
WDSMOCK_SOAPCONFIG_LOG | Erweitertes SOAP Logging ContentConfiguration Service an/aus.













