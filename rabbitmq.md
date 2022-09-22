# RabbitMQ

Loosely coupled: Omdat sommige onderdelen of services er niet altijd zijn.
Er is geen standaard protocol voor messages.

## Overview

RabbitMQ is een broker. Wordt ook wel eens een message bus genoemd. Maakt gebruik van AMQP protocol.

Onderdelen van AMQP:

- **Exchange**: Waar je berichtjes binnen krijgt (receive messages). De brievenbus.
- **Queue**: Plek waar je berichtjes bewaart waar anderen zich op kunnen abonneren.
- **Bindings**: Koppelt exchange aan queue.

![RabbitMQ overview](/images/rabbitmq-overview.jpg)

Er zijn verschillende manieren om berichten van een naar andere kant te krijgen:

- **Queue**: Producer en Consumer kennen allebei de rij.
- **Work Queue**: Een bericht kan een keer eruit gehaald worden.
- **Publish/Subscribe**: Dump bericht in brievenbus en dat bericht wordt automatisch de juiste Consumer afleverd.
- **Routing**: Bericht wordt bewaard als er een fout is. Alleen het adres wordt gebruikt om bericht te bezorgen.
- **Topic**: Vergelijkbaar met Publish/Subscribe. Consumers hebben invloed op waar ze geïnsteresserd in zijn. Er wordt gekeken waar het bericht over gaat.
- **RPC**: Producer en Consumer communiceren met elkaar waarbij het lijkt alsof ze in dezelfde server zitten maar dat is niet zo.

Er zijn verschillende exchange soorten:

**Fanout**: Alles wat je naar de exchange stuurt wordt naar alle queues verzonden die daar aan verbonden zitten. Een Subscriber is verantwoordelijk voor het aanmaken van een queue.
