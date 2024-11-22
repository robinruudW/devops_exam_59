Pgr301-devops-kandidatnr59
Lenke til github repo: https://github.com/robinruudW/devops_exam_59

1.	Leveranse 1. API URL TO Test: https://r70y2triyl.execute-api.eu-west-1.amazonaws.com/Prod/generate-image .

1.	leveranse 2. lenke til vellykket github actions workflow: https://github.com/robinruudW/devops_exam_59/actions/runs/11854807046 

2.	leveranse 1. vellykket push til main med terraform apply:
	https://github.com/robinruudW/devops_exam_59/actions/runs/11929833864 
	leveranse 2. velykket push til branch med terraform plan:
	https://github.com/robinruudW/devops_exam_59/actions/runs/11930277877 
	leveranse 3. min sqs url i aws:
	https://sqs.eu-west-1.amazonaws.com/244530008913/image_processing_queue_59 
3.	leveranse 1. jeg har valgt å tagge container imagesene mine med latest og en sha code. Latest for å se hvilken container som er den siste som har blitt publishet. Da er det enkelt å holde styr på hvilken container som er den siste. Jeg har også en sha tag som viser til hvilken commit dette var i forhold til containeren. Det gjør det enklere å ta en rollback og holde styr på debugging.
Leveranse 2.  Image name er: robinruudw/java-sqs-client:latest  og sqs urlen er den samme som over men tar den med på nytt:  https://sqs.eu-west-1.amazonaws.com/244530008913/image_processing_queue_59 

4.	oppdatert main.tf og variables.tf i oppgave 2 for å legge til cloud watch. Default valuen i variables.tf er min mail. Men du kan endre den til din om du vil teste. Har tatt 4 minutter før alarmen går på ApproximateAgeOfOldestMessage du kan endre den til 2 minutter om du vil teste enklere. 

5.	1. 

de finnes flere fordeler og ulemper med en serverless arkitektur vs microtjeneste arkitektur i forhold til ci/cd. noen fordeler med serverless arkitektur er att deployment blir enklere siden man kan bare fokusere på å deploye funksjoner istedenfor å fokusere på infrastrukturen til et prosjekt. For eksempel kan man deploye en enkel lambda funksjon istedenfor en hel service. Det finnes gode verktøy man kan bruke som aws sam og terraform som hjelper å forenkle ci/cd pipelines. Man kan også enkelt teste de individuelle funksjonene. Problemer i forhold til serverless arkitektur kan være om man har mange små lambda funksjoner kan det fort bli komplisert i ci/cd pipelinen. Det er mer kompleksitet i å tracke deployments og versjons kontroll med tanke på alle funksjonene som må holdes styr på. Microtjenester er det enklere å sette opp en pipeline for hver enkelt service, men mer jobb med underliggende infrastruktur. 

2.	Overvåking:
Serverless applikasjoner har innebygde overvåkings verktøy som AWS cloudwatch som gjør det enkelt å følge med på feil i enkelt funksjoner. Siden loggene er funksjons spesifikke kan man enkelt finne feil i en funksjon, men kan gjøre det mer komplisert å finne feil om flere funksjoner er avhengig av hverandre. Istedenfor å bruke verktøy som Grafana i microtjenester struktur går man over til cloudwatch i serverless applikasjoner. Logger og moniterings verktøy i microtjenester gir en oversikt over hele servicene istedenfor enkelt funksjoner. 

3.	noen fordeler med Faas i fohold til scalability og kostnader er blant annet at den har automatisk scaling. Den benytter seg av «pay per use» modellen som forsikrer seg om at man bare betaler for execution time. Dette bidrar til å minske kostnader for ikke brukte ressurser. Dette er smart om man ikke er sikker på hvor mye trafikk en applikasjon kommer til å ha. Noen ulemper med Faas er at det fort kan blir dyrt hvis man har mye trafikk. Og synkrone forespørsler kan ha noen latancy problemer i starten. Microtjenester er litt motsatt. Om man har lite trafikk kan det være dyrt å ha ikke brukte resurser som må runne. man må manuelt konfigurerer scalingen. Men samtidig har man mer kontroll over resource allocation. Man kan scale spesifikke servicer i forhold til hvor mye trafikk de får. Det kan være bedre å bruke mikrotjenester om man vet at applikasjonen kommer til å ha mye trafikk. 

4.	om devops teamet bruker Faas, kan de enklere fokusere på applikasjons logikk, overvåking og kostnads optimalisering. De slipper å tenke like mye på å infrastruktur administrasjon siden cloud provideren tar seg av det. Faas har også innebygde reliablity features, som gjør at det blir mindre jobb å håndtere feil. Teamet må ha stor forståelse for event-driver arkitektur for å enkelt debugge og forstå dataflowen. Og man låser seg til en provider om man bruker aws blir det vanskeligere å bytte til azure cloud for eksempel. Om devops teamet bruker mikrotjenester har de full kontroll over deres egne services, infrastruktur og scaling strategier. Man er ikke låst til en cloud provider. Ulemper med mikrotjenester er at devops teamet har fullt ansvar for hele livssyklusen til en service og all underliggende infrastruktur. Det blir mer arbeid for å håndtere og planlegge reliability, scalability og kostnads optimalisering. 

