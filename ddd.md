# Domain Driven Design

## Strategic design

### Ubiquitous language

Gebruik zelfde woorden voor dezelfde dingen, kan je lijst met definities voor maken.

### Bounded context

Bubbel waarin woorden een bepaalde betekenis hebben. Een woord kan namelijk meerdere betekenissen hebben, dit moet je afbakenen

### Context mapping

Je hebt alle contexten (bounded contexts) benoemd en die kun je op elkaar mappen. Wat hebben ze met elkaar te maken?

- **Customer/Supplier**: Als een team afhankelijk is van een ander team. Partij A wil iets van partij B, bijv. een api. Partij B gaat voor partij A maken.
- **Conformist**: Als een team afhankelijk is van een ander team. Upstream party has no interest in downstream needs.
- **Anti Corruption Layer**: Partij A stuurt 'corrupte' data naar B. Partij B vormt de data om dat binnen hun bounded context klopt.
- **Separate ways**: Not worth the effort. We gaan het niet implementeren.

### Event storming

Method to find out things that are relevant for the domain.

![Resultaat na event storming](/images/ddd-event-storming.jpg)

### Model integrity

Zorg voor kloppende datamodellen.

## Tactical design

### Aggregate

- **Event**: Er is iets gebeurd. Resultaat van een commando.
- **Commando**: zorgt dat iets gebeurd. Dus triggert het event. Resultaat is het event. Een event kan niet falen.

Een commando verandert iets binnen iets. Een aggregate is eigenlijk het hoofdonderwerp van je commando's.

- **Entity pattern**: Object with unique identity. Model in db, heeft een id zoals postcode + huisnr.
- **Value object** Value has no identity. Entity zonder id, gedefinieerd door al zn waarden. Bijv een postzegel.
- **Domain events**: Something that happened in the domain that you want other parts of the same domain (in-process) to be aware of. Bijv: OrderStarted.

![Aggregate voorbeeld](/images/ddd-aggregate.png)
