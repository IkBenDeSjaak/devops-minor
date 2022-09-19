# Event Driven Architecture

Een architectuur die gebaseerd is op publiceren en delen van events.

## General

### Autonomy over Authority

Sharing data between services is not evil. Autonomous service can deliver more value. Improves availablity

Service A krijgt nieuwe klant met alle klantgegevens. Service A stuurt event CustomerRegistered naar service B en C. Services B en C slaan een stukje van de data op, bijv alleen naam en email.

### Eventual consistency

If no new updates are made to a given data item, eventually all accesses to that item will return the last updated value.

#### CAP theorem

Je kan maar een van de drie letters hebben in gedistribueerde systemen.

- Consistency: All nodes in system see the same data at a certain moment in time.
- Availability: A node will always return a useful response.
- Partition tolerance: Hoe goed gaat je systeem om met failures.

### Design for failure

Je moet er vanuit gaan dat services soms niet beschikbaar zijn. Met name het netwerk kan wel eens down gaan.

- Use libraries (Polly voor .NET)
- Be idempotent (zelfde actie altijd zelfde uitkomst)
- Versioning in your API

Bulkhead pattern: Als er iets mis gaat in het systeem zorg dan dat alleen een gedeelte niet werkt.
Circuit breaker pattern: Don't keep waiting on timeouts from an unhealthy service. Vooral toepassen bij externe systemen.

## Types

### Event notification

Something has changed. Service A notificeert service B. Vervolgens moet service B zelf data ophalen.

### Event carried state tranfer

This particular thing has changed. Gives new data from service A to B. Data zit in notificatie.

### Event sourcing

Service ontvangt events. Events zijn de bron van de data.
Niet hele model opslaan in database. Sla losse events met volgorde op in database. Dit levert een immutable list of events op. Bij een request wordt er weer door alle events gegaan om de state te bouwen.

Snapshots kunnen worden gebruikt om performance te verbeteren. Liever geen snapshots. Dan misschien beter om domein nog verder los te koppelen.

Command => command handler => command handler checkt business rules => replay event

In database twee tabellen:

- Events: Id, AggregateId, Order (volgorde events, zoals timestamp), EventType (type of event), EventData (serialized event).
- Aggregate: AggregateId, Version

After executing command: only thing that happens is add event to db (when version of aggregate is equal to current).

### CQRS

Command Query Responsibility Segregation. Gebruik het niet (te veel).
Scheiding tussen commando's (updating data) en queries (lezen van data).
Je scheidt hierbij ook de datamodellen (command modellen vs query modellen) in de dezelfde database.
Je kan ook verschillende databases hebben voor het write model en het read model. In dit geval wordt vanuit het write model een event naar de projector gestuurd die voor de database zit achter het read model.

Traditioneel: UI => Logica (api controller, manager) => DB
Event driven: UI => Logica (api controller, command handler, (1. domain, 2. repository)) => DB

#### CQRS vs CRUD vs Task based

**Crud**: Haal hele model op en stuur hele model terug. Je weet niet welke business rules erhaan hangen.
**Task based**: Haal model op en stuur aparte call (commando) voor bijvoorbeeld CorrectAddress (spelling corrigeren) en voor RelocateUser (adres + postcode wijzigen.
