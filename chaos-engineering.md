# Chaos engineering

Bij Chaos Engineering voeren ontwikkelaars experimenten uit op hun software, servers en netwerkinfrastructuur waaraan ze aan het bouwen zijn. Hierbij is het doel om failures (zoals onerwachte omstandigheden) te identificeren voordat ze enorm worden. Hierbij wordt met name gericht op de infrastructuur en het netwerk. Dit wordt voornamelijk gedaan door het testen van het systeem under stress. Het ultieme doel is om de experimenten op productiesystemen uit te voeren.

**Performance vs Load test**: Een performance test test hoe snel de app reageert met een normale load en een load test test hoe de app blijft reageren met veel users.

**Chaos engineering & SlackOps**: SlackOps is dat je notificatie/berichten krijgt bij bepaalde acties of fouten. Als je ziet dat er bepaalde fouten optreden tijdens chaos engineering kun je een notificatie sturen.

## Proces

Chaos engineering process steps:

1. Set a baseline (how should the system operate?)
2. Create a hypothesis (what could happen?)
3. Test
4. Evaluate

## Tools

Eén van de meest handige tools voor chaos engineering is Gremlin (failure as a service), al zal Chaos Monkey (random instance failures) van Netflix bij de meesten een belletje doen rinkelen.

### Chaos Monkey

Opzettelijk computers in productie uitschakelen om te testen hoe het systeem hierop reageert.

### Gremlin

Failure in je systeem injecteren om zwakheden te identificeren en downtime te voorkomen. Hierbij gaat het om fouten in het netwerk. Met name om de connectie tussen microservices.

### Chaos Mesh

Een tool om Chaos Engineering te doen in Kubernetes. Can be deployed in a Kubernetes cluster.

![Chaos Mesh overview](/images/chaos-engineering-chaos-mesh-overview.png)

#### Experiments

- PodChaos
  - pod-failure: injects the errors into the pods and will cause pod creation failure for a while.
  - pod-kill: kill selected pods.
  - container-kill: kill container in targeted pods.
- NetworkChaos
  - Network Partition: blocks communication between pods.
  - Network Emulation: regular network faults, such as network delay, duplication, loss, and corruption.
- StressChaos
  - Memory Stress: continuously stress out virtual memory.
  - CPU Stress: continuously stress out CPU.

## Shift left

Denk aan het begin van het project al na over testen, deployen en monitoren. In plaats van alles ontwikkelen en daarna pas alles live zetten zoals traditioneel zo is.

## Shift right

Eerder load testen en performance testen. Performance en load testen in productie met echte omstandigheden. Je kan in een staging area testen (die lijkt op productie) of productie omgeving lokaal halen. Je wil het liefst load testen op productie, want dat is de echte omgeving.
