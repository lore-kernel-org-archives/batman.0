Return-Path: <gmazzurco89@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4DB49ECD.8040808@interia.pl>
References: <4DB49ECD.8040808@interia.pl>
Date: Mon, 25 Apr 2011 10:45:21 +0200
Message-ID: <BANLkTi=4LGtryT6T_CehmkM_2YYbp4DrTA@mail.gmail.com>
From: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Batmand - ping 169.254.0.0 from client is not
	working.
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I think you shouldn't use 169.254.0.0 as ip... try using 169.254.0.1 instea=
d

2011/4/25 Krzysiek Go=B3=EAbiewski <gollab@interia.pl>:
> Hello all!
>
> From quite long time I was trying to configure batmand. I am a student an=
d
> my M.A. thesis is based on MESH. I have chosen a batman_adv and batmand t=
o
> compare it (performance f.e). Batman_adv is working for me (I used an
> instruction from another page) and now I would like to configure batmand.
> Finally I have found this website.
>
> My devices:
> Now I have Asus WL-500gPremium router with Mini PCI Atheros inside. On bo=
th
> routers there is Backfire 10.03.1-rc4. I have installed a package batmand
> (Version: r1439-1) and also kmod-tun, libpthread and kmod-batgat too.
>
> Thanks to earlier posts in this archive I could run batmand and do some
> configuration (based on posts from another users from here and some own
> initiative and ideas.
>
> Now my settings are:
>
> GATEWAY:
>
> /ETC/CONFIG/WIRELESS:
>
> config 'wifi-device' 'wifi0'
> =A0 =A0 =A0 =A0option 'type' 'atheros'
> =A0 =A0 =A0 =A0option 'disabled' '0'
> =A0 =A0 =A0 =A0option 'channel' '1'
> =A0 =A0 =A0 =A0option 'txpower' '1'
> =A0 =A0 =A0 =A0option 'hwmode' '11g'
>
> config 'wifi-iface'
> =A0 =A0 =A0 =A0option 'device' 'wifi0'
> =A0 =A0 =A0 =A0option 'encryption' 'none'
> =A0 =A0 =A0 =A0option 'ssid' 'potato'
> =A0 =A0 =A0 =A0option 'bssid' '01:CA:FF:EE:BA:BE'
> =A0 =A0 =A0 =A0option 'swmerge' '1'
> =A0 =A0 =A0 =A0option 'mode' 'adhoc'
>
>
> /ETC/CONFIG/NETWORK:
>
>
> config 'switch' 'eth0'
> =A0 =A0 =A0 =A0option 'enable' '1'
>
> config 'switch_vlan' 'eth0_0'
> =A0 =A0 =A0 =A0option 'device' 'eth0'
> =A0 =A0 =A0 =A0option 'vlan' '0'
> =A0 =A0 =A0 =A0option 'ports' '1 2 3 4 5'
>
> config 'switch_vlan' 'eth0_1'
> =A0 =A0 =A0 =A0option 'device' 'eth0'
> =A0 =A0 =A0 =A0option 'vlan' '1'
> =A0 =A0 =A0 =A0option 'ports' '0 5'
>
> config 'interface' 'loopback'
> =A0 =A0 =A0 =A0option 'ifname' 'lo'
> =A0 =A0 =A0 =A0option 'proto' 'static'
> =A0 =A0 =A0 =A0option 'ipaddr' '127.0.0.1'
> =A0 =A0 =A0 =A0option 'netmask' '255.0.0.0'
>
> config 'interface' 'wan'
> =A0 =A0 =A0 =A0option 'ifname' 'eth0.1'
> =A0 =A0 =A0 =A0option 'proto' 'dhcp'
> =A0 =A0 =A0 =A0#option 'proto' 'static'
> =A0 =A0 =A0 =A0#option 'ipaddr' '10.130.1.1'
> =A0 =A0 =A0 =A0#option 'netmask' '255.255.255.0'
>
> config 'interface' 'lan'
> =A0 =A0 =A0 =A0#option 'type' 'bridge'
> =A0 =A0 =A0 =A0option 'ifname' 'eth0.0'
> =A0 =A0 =A0 =A0option 'proto' 'static'
> =A0 =A0 =A0 =A0option 'ipaddr' '192.168.3.1'
> =A0 =A0 =A0 =A0option 'netmask' '255.255.255.0'
>
> config 'interface' 'ath0'
> =A0 =A0 =A0 =A0option 'ifname' =A0'ath0'
> =A0 =A0 =A0 =A0option 'proto' =A0 'static'
> =A0 =A0 =A0 =A0option 'ipaddr' =A0'10.130.1.1'
> =A0 =A0 =A0 =A0option 'netmask' '255.255.255.0'
>
>
>
> /ETC/CONFIG/FIREWALL
>
>
> config defaults
> =A0 =A0 =A0 =A0option syn_flood =A0 =A0 =A0 =A01
> =A0 =A0 =A0 =A0option input =A0 =A0 =A0 =A0 =A0 =A0ACCEPT
> =A0 =A0 =A0 =A0option output =A0 =A0 =A0 =A0 =A0 ACCEPT
> =A0 =A0 =A0 =A0option forward =A0 =A0 =A0 =A0 =A0REJECT
>
> config zone
> =A0 =A0 =A0 =A0option name =A0 =A0 =A0 =A0 =A0 =A0 lan
> =A0 =A0 =A0 =A0option input =A0 =A0ACCEPT
> =A0 =A0 =A0 =A0option output =A0 ACCEPT
> =A0 =A0 =A0 =A0option forward =A0REJECT
>
> config zone
> =A0 =A0 =A0 =A0option name =A0 =A0 =A0 =A0 =A0 =A0 wan
> =A0 =A0 =A0 =A0option input =A0 =A0REJECT
> =A0 =A0 =A0 =A0option output =A0 ACCEPT
> =A0 =A0 =A0 =A0option forward =A0REJECT
> =A0 =A0 =A0 =A0option masq =A0 =A0 =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0 =A0option mtu_fix =A01
>
> config forwarding
> =A0 =A0 =A0 =A0option src =A0 =A0 =A0lan
> =A0 =A0 =A0 =A0option dest =A0 =A0 wan
>
> config forwarding
> =A0 =A0 =A0 =A0option src =A0 =A0 =A0wan
> =A0 =A0 =A0 =A0option dest =A0 =A0 lan
>
> # We need to accept udp packets on port 68,
> # see https://dev.openwrt.org/ticket/4108
> config rule
> =A0 =A0 =A0 =A0option src =A0 =A0 =A0 =A0 =A0 =A0 =A0wan
> =A0 =A0 =A0 =A0option proto =A0 =A0 =A0 =A0 =A0 =A0udp
> =A0 =A0 =A0 =A0option dest_port =A0 =A0 =A0 =A068
> =A0 =A0 =A0 =A0option target =A0 =A0 =A0 =A0 =A0 ACCEPT
>
> #Allow ping
> config rule
> =A0 =A0 =A0 =A0option src wan
> =A0 =A0 =A0 =A0option proto icmp
> =A0 =A0 =A0 =A0option icmp_type echo-request
> =A0 =A0 =A0 =A0option target ACCEPT
>
> # include a file with users custom iptables rules
> config include
> =A0 =A0 =A0 =A0option path /etc/firewall.user
>
>
> ### EXAMPLE CONFIG SECTIONS
> # do not allow a specific ip to access wan
> #config rule
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option src_ip =A0 192.168.45.2
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 wan
> # =A0 =A0 =A0 option proto =A0 =A0tcp
> # =A0 =A0 =A0 option target =A0 REJECT
>
> # block a specific mac on wan
> #config rule
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 wan
> # =A0 =A0 =A0 option src_mac =A000:11:22:33:44:66
> # =A0 =A0 =A0 option target =A0 REJECT
>
> # block incoming ICMP traffic on a zone
> #config rule
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option proto =A0 =A0ICMP
> # =A0 =A0 =A0 option target =A0 DROP
>
> # port redirect port coming in on wan to lan
> #config redirect
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wan
> # =A0 =A0 =A0 option src_dport =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lan
> # =A0 =A0 =A0 option dest_ip =A0 =A0 =A0 =A0 =A0192.168.3.1
> # =A0 =A0 =A0 option dest_port =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 option proto =A0 =A0 =A0 =A0 =A0 =A0tcp
> #config redirect
> # =A0 =A0 =A0 =A0option src =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wa=
n
> # =A0 =A0 =A0 =A0option src_dport =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 =A0option dest =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lan
> # =A0 =A0 =A0 =A0option dest_ip =A0 =A0 =A0 =A0 =A0192.168.3.1
> # =A0 =A0 =A0 =A0option dest_port =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 =A0option proto =A0 =A0 =A0 =A0 =A0 =A0udp
>
> ### FULL CONFIG SECTIONS
> #config rule
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option src_ip =A0 192.168.45.2
> # =A0 =A0 =A0 option src_mac =A000:11:22:33:44:55
> # =A0 =A0 =A0 option src_port 80
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 wan
> # =A0 =A0 =A0 option dest_ip =A0194.25.2.129
> # =A0 =A0 =A0 option dest_port =A0 =A0 =A0 =A0120
> # =A0 =A0 =A0 option proto =A0 =A0tcp
> # =A0 =A0 =A0 option target =A0 REJECT
>
> #config redirect
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option src_ip =A0 192.168.45.2
> # =A0 =A0 =A0 option src_mac =A000:11:22:33:44:55
> # =A0 =A0 =A0 option src_port =A0 =A0 =A0 =A0 1024
> # =A0 =A0 =A0 option src_dport =A0 =A0 =A0 =A080
> # =A0 =A0 =A0 option dest_ip =A0194.25.2.129
> # =A0 =A0 =A0 option dest_port =A0 =A0 =A0 =A0120
> # =A0 =A0 =A0 option proto =A0 =A0tcp
>
>
> and one client (at least so far)
>
> CLIENT:
>
> /ETC/CONFIG/WIRELESS:
>
> config 'wifi-device' 'wifi0'
> =A0 =A0 =A0 =A0option 'type' 'atheros'
> =A0 =A0 =A0 =A0option 'disabled' '0'
> =A0 =A0 =A0 =A0option 'channel' '1'
> =A0 =A0 =A0 =A0option 'txpower' '1'
> =A0 =A0 =A0 =A0option 'hwmode' '11g'
>
> config 'wifi-iface'
> =A0 =A0 =A0 =A0option 'device' 'wifi0'
> =A0 =A0 =A0 =A0option 'encryption' 'none'
> =A0 =A0 =A0 =A0option 'ssid' 'potato'
> =A0 =A0 =A0 =A0option 'bssid' '01:CA:FF:EE:BA:BE'
> =A0 =A0 =A0 =A0option 'swmerge' '1'
> =A0 =A0 =A0 =A0option 'mode' 'adhoc'
>
> /ETC/CONFIG/NETWORK:
>
> config 'switch' 'eth0'
> =A0 =A0 =A0 =A0option 'enable' '1'
>
> config 'switch_vlan' 'eth0_0'
> =A0 =A0 =A0 =A0option 'device' 'eth0'
> =A0 =A0 =A0 =A0option 'vlan' '0'
> =A0 =A0 =A0 =A0option 'ports' '1 2 3 4 5'
>
> config 'switch_vlan' 'eth0_1'
> =A0 =A0 =A0 =A0option 'device' 'eth0'
> =A0 =A0 =A0 =A0option 'vlan' '1'
> =A0 =A0 =A0 =A0option 'ports' '0 5'
>
> config 'interface' 'loopback'
> =A0 =A0 =A0 =A0option 'ifname' 'lo'
> =A0 =A0 =A0 =A0option 'proto' 'static'
> =A0 =A0 =A0 =A0option 'ipaddr' '127.0.0.1'
> =A0 =A0 =A0 =A0option 'netmask' '255.0.0.0'
>
> config 'interface' 'wan'
> =A0 =A0 =A0 =A0#option 'type' 'bridge'
> =A0 =A0 =A0 =A0#list 'ifname' 'wifi0'
> =A0 =A0 =A0 =A0#option 'ifname' 'eth0.1'
> =A0 =A0 =A0 =A0#option 'dns' '10.130.1.1'
> =A0 =A0 =A0 =A0#option 'defaultroute' '0'
> =A0 =A0 =A0 =A0#option 'peerdns' '0'
> =A0 =A0 =A0 =A0#option 'proto' 'static'
> =A0 =A0 =A0 =A0#option 'ipaddr' '10.130.1.3'
> =A0 =A0 =A0 =A0#option 'netmask' '255.255.255.0'
> =A0 =A0 =A0 =A0#option 'gateway' '10.130.1.1'
>
> config 'interface' 'lan'
> =A0 =A0 =A0 =A0option 'ifname' 'eth0.0'
> =A0 =A0 =A0 =A0option 'proto' 'static'
> =A0 =A0 =A0 =A0option 'netmask' '255.255.255.0'
> =A0 =A0 =A0 =A0option 'ipaddr' '192.168.4.1'
>
> config 'interface' 'ath0'
> =A0 =A0option 'ifname' 'ath0'
> =A0 =A0option 'proto' 'static'
> =A0 =A0option 'ipaddr' '10.130.1.3'
> =A0 =A0option 'netmask' '255.255.255.0'
> =A0 =A0option 'gateway' '10.130.1.1'
> =A0 =A0option 'dns' '10.130.1.1'
>
>
> /ETC/CONFIG/FIREWALL
>
> config defaults
> =A0 =A0 =A0 =A0option syn_flood =A0 =A0 =A0 =A01
> =A0 =A0 =A0 =A0option input =A0 =A0 =A0 =A0 =A0 =A0ACCEPT
> =A0 =A0 =A0 =A0option output =A0 =A0 =A0 =A0 =A0 ACCEPT
> =A0 =A0 =A0 =A0option forward =A0 =A0 =A0 =A0 =A0REJECT
>
> config zone
> =A0 =A0 =A0 =A0option name =A0 =A0 =A0 =A0 =A0 =A0 lan
> =A0 =A0 =A0 =A0option input =A0 =A0ACCEPT
> =A0 =A0 =A0 =A0option output =A0 ACCEPT
> =A0 =A0 =A0 =A0option forward =A0REJECT
>
> config zone
> =A0 =A0 =A0 =A0option name =A0 =A0 =A0 =A0 =A0 =A0 wan
> =A0 =A0 =A0 =A0option input =A0 =A0REJECT
> =A0 =A0 =A0 =A0option output =A0 ACCEPT
> =A0 =A0 =A0 =A0option forward =A0REJECT
> =A0 =A0 =A0 =A0option masq =A0 =A0 =A0 =A0 =A0 =A0 1
> =A0 =A0 =A0 =A0option mtu_fix =A01
>
> config forwarding
> =A0 =A0 =A0 =A0option src =A0 =A0 =A0lan
> =A0 =A0 =A0 =A0option dest =A0 =A0 wan
>
> config forwarding
> =A0 =A0 =A0 =A0option src =A0 =A0 =A0wan
> =A0 =A0 =A0 =A0option dest =A0 =A0 lan
>
> # We need to accept udp packets on port 68,
> # see https://dev.openwrt.org/ticket/4108
> config rule
> =A0 =A0 =A0 =A0option src =A0 =A0 =A0 =A0 =A0 =A0 =A0wan
> =A0 =A0 =A0 =A0option proto =A0 =A0 =A0 =A0 =A0 =A0udp
> =A0 =A0 =A0 =A0option dest_port =A0 =A0 =A0 =A068
> =A0 =A0 =A0 =A0option target =A0 =A0 =A0 =A0 =A0 ACCEPT
>
> #Allow ping
> config rule
> =A0 =A0 =A0 =A0option src wan
> =A0 =A0 =A0 =A0option proto icmp
> =A0 =A0 =A0 =A0option icmp_type echo-request
> =A0 =A0 =A0 =A0option target ACCEPT
>
> # include a file with users custom iptables rules
> config include
> =A0 =A0 =A0 =A0option path /etc/firewall.user
>
>
> ### EXAMPLE CONFIG SECTIONS
> # do not allow a specific ip to access wan
> #config rule
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option src_ip =A0 192.168.45.2
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 wan
> # =A0 =A0 =A0 option proto =A0 =A0tcp
> # =A0 =A0 =A0 option target =A0 REJECT
>
> # block a specific mac on wan
> #config rule
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 wan
> # =A0 =A0 =A0 option src_mac =A000:11:22:33:44:66
> # =A0 =A0 =A0 option target =A0 REJECT
>
> # block incoming ICMP traffic on a zone
> #config rule
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option proto =A0 =A0ICMP
> # =A0 =A0 =A0 option target =A0 DROP
>
> # port redirect port coming in on wan to lan
> #config redirect
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wan
> # =A0 =A0 =A0 option src_dport =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lan
> # =A0 =A0 =A0 option dest_ip =A0 =A0 =A0 =A0 =A0192.168.2.140
> # =A0 =A0 =A0 option dest_port =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 option proto =A0 =A0 =A0 =A0 =A0 =A0tcp
> #config redirect
> # =A0 =A0 =A0 =A0option src =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wa=
n
> # =A0 =A0 =A0 =A0option src_dport =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 =A0option dest =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lan
> # =A0 =A0 =A0 =A0option dest_ip =A0 =A0 =A0 =A0 =A0192.168.2.140
> # =A0 =A0 =A0 =A0option dest_port =A0 =A0 =A0 =A05001
> # =A0 =A0 =A0 =A0option proto =A0 =A0 =A0 =A0 =A0 =A0udp
>
> ### FULL CONFIG SECTIONS
> #config rule
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option src_ip =A0 192.168.45.2
> # =A0 =A0 =A0 option src_mac =A000:11:22:33:44:55
> # =A0 =A0 =A0 option src_port 80
> # =A0 =A0 =A0 option dest =A0 =A0 =A0 =A0 =A0 =A0 wan
> # =A0 =A0 =A0 option dest_ip =A0194.25.2.129
> # =A0 =A0 =A0 option dest_port =A0 =A0 =A0 =A0120
> # =A0 =A0 =A0 option proto =A0 =A0tcp
> # =A0 =A0 =A0 option target =A0 REJECT
>
> #config redirect
> # =A0 =A0 =A0 option src =A0 =A0 =A0 =A0 =A0 =A0 =A0lan
> # =A0 =A0 =A0 option src_ip =A0 192.168.45.2
> # =A0 =A0 =A0 option src_mac =A000:11:22:33:44:55
> # =A0 =A0 =A0 option src_port =A0 =A0 =A0 =A0 1024
> # =A0 =A0 =A0 option src_dport =A0 =A0 =A0 =A080
> # =A0 =A0 =A0 option dest_ip =A0194.25.2.129
> # =A0 =A0 =A0 option dest_port =A0 =A0 =A0 =A0120
> # =A0 =A0 =A0 option proto =A0 =A0tcp
>
>
> I start batmand with:
>
> On the Gateway:
> batmand -d 3 -g 11000 -a 192.168.3.0/24 --hop-penalty 5 --purge-timeout
> 50000 ath0
>
> and on the client
> batmand -d 3 -r 2 -a 192.168.4.0/24 --disable-client-nat --hop-penalty 5
> --purge-timeout 50000 ath0
>
>
> Then I check all:
>
> batmand -d1 -c
> On the gateway:
> Originator =A0(#/255) =A0 =A0 =A0 =A0 Nexthop [outgoingIF]: =A0 Potential=
 nexthops ...
> [B.A.T.M.A.N. 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.1, UT: 0d 0h 1m]
> 10.130.1.3 =A0 =A0 =A0(234) =A0 =A0 =A010.130.1.3 [ =A0 =A0 =A0ath0]: =A0=
 =A0 =A010.130.1.3 (234)
>
>
> On the client:
> =A0Originator =A0(#/255) =A0 =A0 =A0 =A0 Nexthop [outgoingIF]: =A0 Potent=
ial nexthops ...
> [B.A.T.M.A.N. 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.3, UT: 0d 0h 3m]
> 10.130.1.1 =A0 =A0 =A0(243) =A0 =A0 =A010.130.1.1 [ =A0 =A0 =A0ath0]: =A0=
 =A0 =A010.130.1.1 (243)
>
>
>
>
> batmand -d2 -c
>
>
>
> On the gateway:
> Gateway =A0 =A0 (#/255) =A0 =A0 =A0 =A0 Nexthop [outgoingIF], gw_class ..=
. [B.A.T.M.A.N.
> 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.1, UT: 0d 0h 2m]
> No gateways in range ...
>
>
>
> On the client:
> I can see my gateway -> 10.130.1.1
> =A0 =A0 Gateway =A0 =A0 (#/255) =A0 =A0 =A0 =A0 Nexthop [outgoingIF], gw_=
class ...
> [B.A.T.M.A.N. 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.3, UT: 0d 0h 4m]
> =3D> 10.130.1.1 =A0 =A0 =A0(255) =A0 =A0 =A010.130.1.1 [ =A0 =A0 =A0ath0]=
, gw_class 184 -
> 12MBit/1536KBit, gateway failures: 0
>
>
>
>
> Command ifconfig showed:
> on the gateway:
>
> ath0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:0E:8E:18:F7:91
> =A0 =A0 =A0 =A0 inet addr:10.130.1.1 =A0Bcast:10.130.1.255 =A0Mask:255.25=
5.255.0
> =A0 =A0 =A0 =A0 UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 RX packets:517 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 TX packets:3301 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 collisions:0 txqueuelen:0
> =A0 =A0 =A0 =A0 RX bytes:28892 (28.2 KiB) =A0TX bytes:213735 (208.7 KiB)
>
> eth0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:1A:92:7E:27:B7
> =A0 =A0 =A0 =A0 UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 RX packets:3709 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 TX packets:4320 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 collisions:0 txqueuelen:1000
> =A0 =A0 =A0 =A0 RX bytes:351741 (343.4 KiB) =A0TX bytes:754122 (736.4 KiB=
)
> =A0 =A0 =A0 =A0 Interrupt:4
>
> eth0.0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:1A:92:7E:27:B7
> =A0 =A0 =A0 =A0 inet addr:192.168.3.1 =A0Bcast:192.168.3.255 =A0Mask:255.=
255.255.0
> =A0 =A0 =A0 =A0 UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 RX packets:3581 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 TX packets:2304 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 collisions:0 txqueuelen:0
> =A0 =A0 =A0 =A0 RX bytes:274574 (268.1 KiB) =A0TX bytes:602269 (588.1 KiB=
)
>
> eth0.1 =A0 =A0Link encap:Ethernet =A0HWaddr 00:1A:92:7E:27:B7
> =A0 =A0 =A0 =A0 inet addr:192.168.2.2 =A0Bcast:192.168.2.255 =A0Mask:255.=
255.255.0
> =A0 =A0 =A0 =A0 UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 RX packets:111 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 TX packets:2017 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 collisions:0 txqueuelen:0
> =A0 =A0 =A0 =A0 RX bytes:9083 (8.8 KiB) =A0TX bytes:105082 (102.6 KiB)
>
> gate0 =A0 =A0 Link encap:Ethernet =A0HWaddr 00:00:00:00:00:00
> =A0 =A0 =A0 =A0 inet addr:169.254.0.0 =A0P-t-P:169.254.0.0 =A0Mask:255.25=
5.255.255
> =A0 =A0 =A0 =A0 UP POINTOPOINT RUNNING NOARP MULTICAST =A0MTU:1471 =A0Met=
ric:1
> =A0 =A0 =A0 =A0 RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 collisions:0 txqueuelen:1000
> =A0 =A0 =A0 =A0 RX bytes:0 (0.0 B) =A0TX bytes:0 (0.0 B)
>
> lo =A0 =A0 =A0 =A0Link encap:Local Loopback
> =A0 =A0 =A0 =A0 inet addr:127.0.0.1 =A0Mask:255.0.0.0
> =A0 =A0 =A0 =A0 UP LOOPBACK RUNNING =A0MTU:16436 =A0Metric:1
> =A0 =A0 =A0 =A0 RX packets:214 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 TX packets:214 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 collisions:0 txqueuelen:0
> =A0 =A0 =A0 =A0 RX bytes:18654 (18.2 KiB) =A0TX bytes:18654 (18.2 KiB)
>
> wifi0 =A0 =A0 Link encap:UNSPEC =A0HWaddr
> 00-0E-8E-18-F7-91-00-00-00-00-00-00-00-00-00-00
> =A0 =A0 =A0 =A0 UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 RX packets:6600 errors:0 dropped:0 overruns:0 frame:696
> =A0 =A0 =A0 =A0 TX packets:3933 errors:271 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 collisions:0 txqueuelen:195
> =A0 =A0 =A0 =A0 RX bytes:856392 (836.3 KiB) =A0TX bytes:344114 (336.0 KiB=
)
> =A0 =A0 =A0 =A0 Interrupt:6
>
>
>
> and on the client:
>
>
>
> ath0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:0E:8E:18:F7:AE
> =A0 =A0 =A0 =A0 =A0inet addr:10.130.1.3 =A0Bcast:10.130.1.255 =A0Mask:255=
.255.255.0
> =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 =A0RX packets:3805 errors:0 dropped:7 overruns:0 frame:0
> =A0 =A0 =A0 =A0 =A0TX packets:1236 errors:0 dropped:0 overruns:0 carrier:=
0
> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:0
> =A0 =A0 =A0 =A0 =A0RX bytes:192820 (188.3 KiB) =A0TX bytes:83458 (81.5 Ki=
B)
>
> eth0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:1A:92:7E:27:71
> =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 =A0RX packets:4205 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 =A0TX packets:3622 errors:0 dropped:0 overruns:0 carrier:=
0
> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000
> =A0 =A0 =A0 =A0 =A0RX bytes:337594 (329.6 KiB) =A0TX bytes:360497 (352.0 =
KiB)
> =A0 =A0 =A0 =A0 =A0Interrupt:4
>
> eth0.0 =A0 =A0Link encap:Ethernet =A0HWaddr 00:1A:92:7E:27:71
> =A0 =A0 =A0 =A0 =A0inet addr:192.168.4.1 =A0Bcast:192.168.4.255 =A0Mask:2=
55.255.255.0
> =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 =A0RX packets:4200 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 =A0TX packets:3620 errors:0 dropped:0 overruns:0 carrier:=
0
> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:0
> =A0 =A0 =A0 =A0 =A0RX bytes:261741 (255.6 KiB) =A0TX bytes:335861 (327.9 =
KiB)
>
> gate0 =A0 =A0 Link encap:UNSPEC =A0HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> =A0 =A0 =A0 =A0 =A0inet addr:169.254.0.1 =A0P-t-P:169.254.0.1 =A0Mask:255=
.255.255.255
> =A0 =A0 =A0 =A0 =A0UP POINTOPOINT RUNNING NOARP MULTICAST =A0MTU:1471 =A0=
Metric:1
> =A0 =A0 =A0 =A0 =A0RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 =A0TX packets:15 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:500
> =A0 =A0 =A0 =A0 =A0RX bytes:0 (0.0 B) =A0TX bytes:1260 (1.2 KiB)
>
> gate1 =A0 =A0 Link encap:UNSPEC =A0HWaddr
> 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> =A0 =A0 =A0 =A0 =A0inet addr:169.254.0.1 =A0P-t-P:169.254.0.1 =A0Mask:255=
.255.255.255
> =A0 =A0 =A0 =A0 =A0UP POINTOPOINT RUNNING NOARP MULTICAST =A0MTU:1471 =A0=
Metric:1
> =A0 =A0 =A0 =A0 =A0RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 =A0TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:500
> =A0 =A0 =A0 =A0 =A0RX bytes:0 (0.0 B) =A0TX bytes:0 (0.0 B)
>
> lo =A0 =A0 =A0 =A0Link encap:Local Loopback
> =A0 =A0 =A0 =A0 =A0inet addr:127.0.0.1 =A0Mask:255.0.0.0
> =A0 =A0 =A0 =A0 =A0UP LOOPBACK RUNNING =A0MTU:16436 =A0Metric:1
> =A0 =A0 =A0 =A0 =A0RX packets:34 errors:0 dropped:0 overruns:0 frame:0
> =A0 =A0 =A0 =A0 =A0TX packets:34 errors:0 dropped:0 overruns:0 carrier:0
> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:0
> =A0 =A0 =A0 =A0 =A0RX bytes:2164 (2.1 KiB) =A0TX bytes:2164 (2.1 KiB)
>
> wifi0 =A0 =A0 Link encap:UNSPEC =A0HWaddr
> 00-0E-8E-18-F7-AE-00-00-00-00-00-00-00-00-00-00
> =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Metric:1
> =A0 =A0 =A0 =A0 =A0RX packets:43355 errors:0 dropped:0 overruns:0 frame:8=
01
> =A0 =A0 =A0 =A0 =A0TX packets:1938 errors:333 dropped:0 overruns:0 carrie=
r:0
> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:195
> =A0 =A0 =A0 =A0 =A0RX bytes:4590804 (4.3 MiB) =A0TX bytes:175638 (171.5 K=
iB)
> =A0 =A0 =A0 =A0 =A0Interrupt:6
>
>
>
> And route -n =A0 =A0showed:
>
> on the gateway:
>
> Kernel IP routing table
> Destination =A0 =A0 Gateway =A0 =A0 =A0 =A0 Genmask =A0 =A0 =A0 =A0 Flags=
 Metric Ref =A0 =A0Use
> Iface
> 10.130.1.0 =A0 =A0 =A00.0.0.0 =A0 =A0 =A0 =A0 255.255.255.0 =A0 U =A0 =A0=
 0 =A0 =A0 =A00 =A0 =A0 =A0 =A00 ath0
> 192.168.3.0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 255.255.255.0 =A0 U =A0 =A0 0=
 =A0 =A0 =A00 =A0 =A0 =A0 =A00
> eth0.0
> 192.168.2.0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 255.255.255.0 =A0 U =A0 =A0 0=
 =A0 =A0 =A00 =A0 =A0 =A0 =A00
> eth0.1
> 169.254.0.0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 255.255.0.0 =A0 =A0 U =A0 =A0=
 0 =A0 =A0 =A00 =A0 =A0 =A0 =A00
> gate0
> 0.0.0.0 =A0 =A0 =A0 =A0 192.168.2.1 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 UG =
=A0 =A00 =A0 =A0 =A00 =A0 =A0 =A0 =A00
> eth0.1
>
>
>
> and on the client:
>
>
>
> Kernel IP routing table
> Destination =A0 =A0 Gateway =A0 =A0 =A0 =A0 Genmask =A0 =A0 =A0 =A0 Flags=
 Metric Ref =A0 =A0Use
> Iface
> 192.168.4.0 =A0 =A0 0.0.0.0 =A0 =A0 =A0 =A0 255.255.255.0 =A0 U =A0 =A0 0=
 =A0 =A0 =A00 =A0 =A0 =A0 =A00
> eth0.0
> 10.130.1.0 =A0 =A0 =A00.0.0.0 =A0 =A0 =A0 =A0 255.255.255.0 =A0 U =A0 =A0=
 0 =A0 =A0 =A00 =A0 =A0 =A0 =A00 ath0
> 0.0.0.0 =A0 =A0 =A0 =A0 10.130.1.1 =A0 =A0 =A00.0.0.0 =A0 =A0 =A0 =A0 UG =
=A0 =A00 =A0 =A0 =A00 =A0 =A0 =A0 =A00 ath0
>
>
>
> I added also a registration to iptable (on the gateway and on the client =
the
> same)
> iptables -t nat -I POSTROUTING -o gate0 -j MASQUERADE
>
>
>
> So, nodes can see each other, and the gateway is broadcasting (client can
> see it).
> I can ping from gateway to client by tunnel -> ping 169.254.0.0 but I can=
`t
> ping from client to gateway -> ping 169.254.0.0 , what`s wrong?
> Unfortunately, I can`t get internet too.
>
> Can somebody help me? I suppose there is a small mistake, as always but I
> have recently started my adventures with Open Wrt so I don`t understand
> everything and it can be my mistake.
> Thanks in Advance,
> Krzysiek (student).
>
>
> -------------------------------------------------
> Ustaw Interie jako strone startowa!
> Zobacz jak to zrobic >> http://linkint.pl/f297e
>
>
