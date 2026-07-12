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

echo "[nginx] Copying nginx configs..."
cp reverse-proxy-gateway/nginx/nginx.conf /etc/nginx/nginx.conf
cp -r reverse-proxy-gateway/nginx/sites-available/* /etc/nginx/http.d/

echo "[nginx] Testing config..."
nginx -t

echo "[nginx] Reloading nginx..."
nginx -s reload

echo "[nginx] NGINX configured."


#
# --- WIREGUARD ---
#

echo "[wireguard] Installing WireGuard tools..."
apk add wireguard-tools

echo "[wireguard] Creating WireGuard directories..."
mkdir -p /etc/wireguard
mkdir -p /etc/wireguard/peers

echo "[wireguard] Copying WireGuard configs..."
cp reverse-proxy-gateway/wireguard/wg0.conf /etc/wireguard/wg0.conf
cp reverse-proxy-gateway/wireguard/peers/* /etc/wireguard/peers/

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

echo "[wireguard] Restarting WireGuard..."
rc-service wg-quick restart

echo "=== Installation & configuration complete ==="
