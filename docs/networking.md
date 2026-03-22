# 🌐 Networking Architecture

This home server uses a **VPN-first network model** to ensure secure remote access without exposing internal services to the internet.

---

## 🔐 VPN Access (WireGuard)

Remote access is handled through a WireGuard VPN deployed via Docker.

### Key characteristics:

- Only **UDP port 51820** is exposed externally
- No internal services are publicly accessible
- All management interfaces (e.g. Portainer, Pi-hole) are accessed via VPN

---

## 🧱 Network Topology

```text
[ Remote Client ]
        │
        ▼
   (WireGuard VPN)
        │
        ▼
[ Raspberry Pi Host ]
        │
        ├── Pi-hole (DNS)
        ├── Portainer
        ├── Other containers
```

---

## 🌍 IP Addressing

- VPN subnet: `10.8.0.0/24`
- LAN subnet: `192.168.1.0/24`

Clients connected via VPN can:

- Access internal services via LAN IPs
- Resolve DNS queries using Pi-hole

---

## 🧠 DNS Resolution (Pi-hole Integration)

WireGuard clients are configured to use Pi-hole as their primary DNS:

```env
WG_DEFAULT_DNS=192.168.1.10
```

This provides:

- Network-wide ad blocking
- Local DNS resolution
- Consistent behavior across devices

---

## 🔄 Traffic Flow

1. Client connects via WireGuard
2. VPN assigns IP from `10.8.0.0/24`
3. Traffic is routed to internal network
4. DNS queries go through Pi-hole
5. Services are accessed securely via LAN

---

## 🔒 Security Model

- No direct exposure of services to the internet
- Single entry point via VPN
- Internal network remains isolated
