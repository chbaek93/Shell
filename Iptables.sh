#!/bin/sh

# -- chb@mz.co.kr , Nov 10, 2016
# -- Set Iptables
# -- Env : vim sw=4, ts=4

# sysctl net.ipv4.ip_forward
# net.ipv4.ip_forward = 0
# sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

# Define Some Variables
ipt=/sbin/iptables

allow_tcp_port="22 25 53 80 110 143 873 3306 5432 "
allow_udp_port="53"
dev="eth0"
log="mylog"

# -- Flush iptables -- #
$ipt -F
$ipt -X
$ipt -Z

$ipt -t nat -F
$ipt -t nat -X
$ipt -t nat -Z

$ipt -t mangle -F
$ipt -t mangle -X
$ipt -t mangle -Z

$ipt -P OUTPUT ACCEPT
$ipt -P FORWARD ACCEPT
$ipt -P INPUT ACCEPT

for tcp_port in $allow_port;
do
    $ipt -A INPUT -i $dev -p tcp --deport $tcp_port -m state --state NEW,ESTABLISHED -j ACCEPT
    $ipt -A OUTPUT -i $dev -p tcp --sport $tcp_port -m state --state ESTABLISHED -j ACCEPT
done

# -- OR -- #
$ipt -A INPUT -i $dev -p tcp -m multiport --dport $allow_tcp_port -m state --state NEW,ESTABLISHED -j ACCEPT
$ipt -A OUTPUT -o $dev -p tcp -m multiport --sport $allow_tcp_port -m state --state ESTABLISHED -j ACCEPT

# -- Allow Open UDP port -- #
for udp_port in $allow_udp_port;
do
    $ipt -A INPUT -i $dev -p tcp --dport $allow_udp_port -m state --state NEW,ESTABLISHED -j ACCEPT
    $ipt -A OUTPUT -o $dev -p tcp --sport $allow_udp_port -m state --state ESTABLISHED -j ACCEPT

done
# -- ICMP -- #
$ipt -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
$ipt -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

$ipt -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
$ipt -A OUTPUT -p tcmp --icmp-type echo-reply -j ACCEPT


# -- Use Logging System -- #
$ipt -N $log
$ipt -A INPUT -j $log
$ipt -A $log -m limit --limit 2/min -j LOG --log-prefix "Iptables Packet Dropped: " --log-level 7
$ipt -A $log -j DROP

# -- Load Balancer -- #
$ipt -t nat -A PREROUTING -p tcp -i $dev -d 0.0.0.0 --dort 80 -j DNAT --to 10.10.10.10:80
$ipt -t nat -A PREROUTING -p tcp -i $dev -d 0.0.0.0 --dort 80 -j DNAT --to 10.10.10.11:80
$ipt -t nat -A PREROUTING -p tcp -i $dev -d 0.0.0.0 --dort 80 -j DNAT --to 10.10.10.12:80

# -- Redirect Port -- #
$ipt -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080


# -- Check Iptables -- #
# watch -n 1 "iptables -v -nL --line-numbers"



# -- End of Line -- #
