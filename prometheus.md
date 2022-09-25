# Prometheus

Monitoring toolkit for collecting, storing and querying metrics. Prometheus is a metrics server. That means it reads and stores the metrics. Grafana is a tool that visualizes metrics by quering the metrics server. So this can be called the visualizer. You can query metrics by using the PromQL query language. Prometheus is a stateful application

Example of PromQL:

```PromQL
# Get total number of running containers across all managers
sum(engine_daemon_container_states_containers{state="running"})

# Rate of HTTP requests per second for the last 5 mins.
sum(irate(http_requests_total[5m]))
```

Your apps should use the `/metrics` endpoint to use Prometheus. It calls this endpoint for all your services and stores all the metrics it gets in a time series database. It does this at a set interval. So it scrapes thd data provides by the endpoints at an interval.

You can set this metrics endpoint up in 2 ways:

- Exporter: additional component that adds metrics to an existing system. Deze gebruik je meestal my third-party apps zoals een database.
- Client library: Deze gebruik je voor custom apps (.NET, Java etc.).

![Prometheus overview](/images/prometheus-overview.webp)
![Prometheus overview 2](/images/prometheus-overview-2.svg)

## Collector registry

The client library implements a collector registry which implements all different kind of metrics. The collector registry consists of different types of metrics.

- Process (memory usage)
- Runtime (response time, active requests)
- Custom (app info)

## Metrics

Prometheus has a few different kind of metrics.

### Counter

It is a simple number. This cumulative metric is suitable for tracking the number of requests, errors or completed tasks. It cannot decrease, and must either go up or be reset to zero.

Counters should be used for:

- Recording a value that only increases
- Assessing the rate of increase

### Gauge

This is a simple number. This point-in-time metric can go both up and down. It is suitable for measuring current memory use and concurrent requests (thread count).

Gauges should be used for:

- Recording a value that may go up or down
- Cases where you don’t need to query the rate of the value

### Histogram

It groups together multiple samples of the same metric. This metric is suitable for aggregated measures, including request durations, response sizes, and Apdex scores that measure application performance. Histograms sample observations and categorize data into buckets that you can customize.

Histograms should be used for:

- Multiple measurements of a single value, allowing for the calculation of averages or percentiles
- Values that can be approximate
- A range of values that you determine in advance, by using default definitions in a histogram bucket, or your custom values

### Custom

Custom metrics use the built in Prometheus metric types.
There are several ways how you can implement custom metrics in your app:

- Manually setting values (manually creating metric and updating it in code when it changes)
- Using middleware (processing pipeline)
- Aspect-Oriented Programming (injecting metrics into specific endpoints)

## Service Discovery

Service discovery is het automatisch detecteren van services in een netwerk. In het geval van Kubernetes wil je namelijk alle Pods kunnen tracken ook al zijn er meerdere replica's. Die runnen allemaal in hun eigen lokale Pod IP adres.

### SD Docker

In Docker heb je de zogenaamd `tasks` prefix. In dit geval zou `tasks.nginx` van alle nginx containers het IP adres retourneren.

![Prometheus Service Discovery Docker](/images/prometheus-sd-docker.png)
