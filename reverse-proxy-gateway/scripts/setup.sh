#!/bin/sh
set -e

echo "=== Installing NGINX & WireGuard ==="

#
# --- NGINX ---
#

echo "[nginx] Updating system..."
apk update

echo "[nginx] Installing nginx..."
apk add nginx

echo "[nginx] Enabling nginx service..."
rc-update add nginx

echo "[nginx] Creating config directories..."
mkdir -p /etc/nginx/http.d

echo "[nginx] Testing config..."
nginx -t

echo "[nginx] NGINX configured."


#
# --- WIREGUARD ---
#

echo "[wireguard] Installing WireGuard tools..."
apk add wireguard-tools

echo "[wireguard] Installing wg-quick OpenRC service..."
cat << 'EOF' > /etc/init.d/wg-quick
#!/sbin/openrc-run

description="WireGuard Quick"

depend() {
    need localmount
    need net
}

start() {
    wg-quick up wg0
}

stop() {
    wg-quick down wg0
}
EOF

chmod +x /etc/init.d/wg-quick

echo "[wireguard] Enabling wg-quick service..."
rc-update add wg-quick

echo "=== Installation & configuration complete ==="
