\# Architecture Overview



\## System Description



This project implements a self-hosted home server running on a Raspberry Pi, designed to provide secure remote access, network-wide DNS filtering, and containerized service management.



The system is built using Docker to ensure modularity, isolation, and ease of maintenance.



\## Core Components



The architecture is composed of the following services:



\* \*\*Pi-hole\*\*: Network-wide DNS sinkhole for ad-blocking and tracking protection.

\* \*\*WireGuard\*\*: VPN server to securely access the home network remotely.

\* \*\*Portainer\*\*: Web-based Docker management interface.

\* \*\*DuckDNS\*\*: Dynamic DNS service to expose the home network using a consistent domain.



\## High-Level Architecture Diagram



The system follows a single-node architecture where all services run on a Raspberry Pi using Docker containers.



```

&#x20;               Internet

&#x20;                   │

&#x20;                   ▼

&#x20;           \[ DuckDNS Domain ]

&#x20;                   │

&#x20;                   ▼

&#x20;            \[ Router / NAT ]

&#x20;                   │

&#x20;                   ▼

&#x20;           \[ WireGuard VPN ]

&#x20;                   │

&#x20;   ┌───────────────┴───────────────┐

&#x20;   ▼                               ▼

\[ Pi-hole DNS ]            \[ Internal Network ]

&#x20;       │

&#x20;       ▼

&#x20; \[ Upstream DNS ]

```



\## Networking Model



\* The system uses \*\*WireGuard VPN\*\* as the only entry point from the internet.

\* No internal services (like Pi-hole or Portainer) are exposed directly.

\* DNS traffic is handled locally by Pi-hole.

\* External DNS queries are forwarded to upstream providers (e.g., Cloudflare).



\## Deployment Model



\* All services are containerized using Docker.

\* Each service is defined independently using its own `docker-compose.yml`.

\* Persistent data is stored on the host filesystem under `/srv/docker/data`.

\* Configuration is managed using environment variables (`.env` files).



\## Design Principles



The system is built following these principles:



\* \*\*Security first\*\*: No unnecessary ports exposed to the internet.

\* \*\*Modularity\*\*: Each service is isolated and independently managed.

\* \*\*Reproducibility\*\*: The system can be redeployed using the provided configuration.

\* \*\*Simplicity\*\*: Designed for a single-node environment without unnecessary complexity.



