# 🔐 Security Model

This project is designed with a **security-first approach**, prioritizing minimal exposure and controlled access to all services.

---

## 🎯 Security Principles

The system is built around the following core principles:

- **Zero public exposure of internal services**
- **Single secure entry point (VPN)**
- **Network isolation**
- **Least privilege access**
- **Separation of code and sensitive data**

---

## 🚫 No Public Services

No services are directly exposed to the internet.

The only open port is:

- `51820/UDP` → WireGuard VPN

All other services (Pi-hole, Portainer, etc.) are:

- Bound to internal networks
- Accessible only through VPN

---

## 🔐 VPN-Only Access (WireGuard)

WireGuard acts as the **single entry point** to the infrastructure.

### Why this approach?

- Eliminates attack surface from exposed web interfaces
- Avoids brute-force attacks on services like Portainer
- Prevents direct access to internal APIs
- Encrypts all traffic between client and server

---

## 🌐 Network Isolation

The internal network is not accessible from the public internet.

Access flow:

1. User connects via WireGuard
2. Receives IP in VPN subnet (`10.8.0.0/24`)
3. Gains controlled access to LAN (`192.168.1.0/24`)

---

## 🧠 DNS Control (Pi-hole)

All VPN clients use Pi-hole as DNS resolver:

- Blocks ads and tracking domains
- Provides local DNS resolution
- Prevents DNS leaks

---

## 🔑 Secrets Management

Sensitive data is never stored in the repository.

### Excluded from Git:

- `.env` files
- WireGuard configs (`wg0.conf`, keys)
- Databases and runtime data

### Included:

- `.env.example` → template only

---

## 🧱 Container Security

WireGuard container runs with required capabilities only:

- `NET_ADMIN`
- `SYS_MODULE`

Other security considerations:

- No privileged mode
- Controlled device access (`/dev/net/tun`)
- IP forwarding explicitly enabled

---

## ⚠️ Threats Mitigated

This architecture reduces exposure to:

- Brute-force attacks on web services
- Unauthorized access to management interfaces
- Port scanning and service fingerprinting
- DNS-based tracking and leaks
- Credential exposure via misconfigured services

---

## 🧭 Design Decision Summary

| Decision            | Reason                                   |
| ------------------- | ---------------------------------------- |
| VPN-only access     | Minimize attack surface                  |
| No exposed services | Prevent direct exploitation              |
| Externalized config | Avoid leaking sensitive data             |
| Pi-hole as DNS      | Control and filter network traffic       |
| Docker isolation    | Contain services and reduce blast radius |

---

## ✅ Result

The system provides:

- Secure remote access
- Minimal external footprint
- Controlled internal communication
- Reproducible and safe deployment model
