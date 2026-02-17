# Disable TCP offloading on all interfaces
for iface in $(ls /sys/class/net | grep -v lo); do
    sudo ethtool -K "$iface" tso off gso off gro off 2>/dev/null || true
done

# Core network buffers
sysctl -w net.core.rmem_max=268435456
sysctl -w net.core.rmem_default=134217728
sysctl -w net.core.wmem_max=268435456
sysctl -w net.core.wmem_default=16777216

# TCP memory tuning
sysctl -w net.ipv4.tcp_rmem='8192 87380 134217728'
sysctl -w net.ipv4.tcp_wmem='8192 65536 134217728'
sysctl -w net.ipv4.tcp_mem='8388608 8388608 8388608'

# TCP performance optimizations
sysctl -w net.ipv4.tcp_no_metrics_save=1
sysctl -w net.ipv4.tcp_congestion_control=bbr
sysctl -w net.ipv4.tcp_mtu_probing=1
sysctl -w net.ipv4.tcp_ecn=1
sysctl -w net.ipv4.tcp_reordering=3

# Queue discipline
sysctl -w net.core.default_qdisc=fq

# Neighbor cache
sysctl -w net.ipv4.neigh.default.proxy_qlen=96
sysctl -w net.ipv4.neigh.default.unres_qlen=6

# Flush routing cache
sysctl -w net.ipv4.route.flush=1