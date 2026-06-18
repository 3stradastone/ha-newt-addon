# Newt (Pangolin) — Home Assistant Add-on

Runs [Newt](https://github.com/fosrl/newt), the Pangolin tunnel connector, on your
Home Assistant machine with **minimal privileges**. Wraps the official
`fosrl/newt:latest` image.

## Why this add-on
The two community Newt add-ons request dangerous privileges a tunnel does not need
(one grants `full_access` + read-write to `/config` + disables AppArmor; the other
grants `docker_api`, i.e. host root). This one requests **only**:

- `host_network` — bind the tunnel on the host network stack
- `NET_ADMIN`, `NET_RAW` — create/configure the WireGuard interface

No `full_access`, no `docker_api`, no `/config` access, AppArmor left enabled.

## Setup
1. In the **Pangolin dashboard**, create a new **Site** (Newt connector). It generates a
   `NEWT_ID` and `NEWT_SECRET` and shows your `PANGOLIN_ENDPOINT`.
2. Install this add-on, open **Configuration**, and fill in:
   - `pangolin_endpoint` — e.g. `https://your-pangolin-server`
   - `newt_id`
   - `newt_secret`
   - `log_level` — INFO by default
3. **Save**, then **Start**. Check **Logs** for a successful connection.
4. In Pangolin, point a **resource/target** at the LAN service you want to reach
   (e.g. the Music Assistant streamserver at `192.168.1.84:8097`). Put Pangolin auth
   in front — the MA streamserver has no auth of its own.

## Updating Newt
This add-on tracks `fosrl/newt:latest`. To force a refresh after an upstream release,
**Rebuild** the add-on (⋮ → Rebuild) — it re-pulls `latest`. To pin a specific Newt
version, change the tag in `newt/Dockerfile` (`FROM fosrl/newt:<version>`), bump
`version:` in `newt/config.yaml`, commit, and **Update** in HA.
