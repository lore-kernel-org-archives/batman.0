Return-Path: <gollab@interia.pl>
Message-ID: <4DB49ECD.8040808@interia.pl>
Date: Mon, 25 Apr 2011 00:06:05 +0200
From: =?UTF-8?B?S3J6eXNpZWsgR2/FgsSZYmlld3NraQ==?= <gollab@interia.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Batmand - ping 169.254.0.0 from client is not
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hello all!

 From quite long time I was trying to configure batmand. I am a student 
and my M.A. thesis is based on MESH. I have chosen a batman_adv and 
batmand to compare it (performance f.e). Batman_adv is working for me (I 
used an instruction from another page) and now I would like to configure 
batmand. Finally I have found this website.

My devices:
Now I have Asus WL-500gPremium router with Mini PCI Atheros inside. On 
both routers there is Backfire 10.03.1-rc4. I have installed a package 
batmand (Version: r1439-1) and also kmod-tun, libpthread and kmod-batgat 
too.

Thanks to earlier posts in this archive I could run batmand and do some 
configuration (based on posts from another users from here and some own 
initiative and ideas.

Now my settings are:

GATEWAY:

/ETC/CONFIG/WIRELESS:

config 'wifi-device' 'wifi0'
         option 'type' 'atheros'
         option 'disabled' '0'
         option 'channel' '1'
         option 'txpower' '1'
         option 'hwmode' '11g'

config 'wifi-iface'
         option 'device' 'wifi0'
         option 'encryption' 'none'
         option 'ssid' 'potato'
         option 'bssid' '01:CA:FF:EE:BA:BE'
         option 'swmerge' '1'
         option 'mode' 'adhoc'


/ETC/CONFIG/NETWORK:


config 'switch' 'eth0'
         option 'enable' '1'

config 'switch_vlan' 'eth0_0'
         option 'device' 'eth0'
         option 'vlan' '0'
         option 'ports' '1 2 3 4 5'

config 'switch_vlan' 'eth0_1'
         option 'device' 'eth0'
         option 'vlan' '1'
         option 'ports' '0 5'

config 'interface' 'loopback'
         option 'ifname' 'lo'
         option 'proto' 'static'
         option 'ipaddr' '127.0.0.1'
         option 'netmask' '255.0.0.0'

config 'interface' 'wan'
         option 'ifname' 'eth0.1'
         option 'proto' 'dhcp'
         #option 'proto' 'static'
         #option 'ipaddr' '10.130.1.1'
         #option 'netmask' '255.255.255.0'

config 'interface' 'lan'
         #option 'type' 'bridge'
         option 'ifname' 'eth0.0'
         option 'proto' 'static'
         option 'ipaddr' '192.168.3.1'
         option 'netmask' '255.255.255.0'

config 'interface' 'ath0'
         option 'ifname'  'ath0'
         option 'proto'   'static'
         option 'ipaddr'  '10.130.1.1'
         option 'netmask' '255.255.255.0'



/ETC/CONFIG/FIREWALL


config defaults
         option syn_flood        1
         option input            ACCEPT
         option output           ACCEPT
         option forward          REJECT

config zone
         option name             lan
         option input    ACCEPT
         option output   ACCEPT
         option forward  REJECT

config zone
         option name             wan
         option input    REJECT
         option output   ACCEPT
         option forward  REJECT
         option masq             1
         option mtu_fix  1

config forwarding
         option src      lan
         option dest     wan

config forwarding
         option src      wan
         option dest     lan

# We need to accept udp packets on port 68,
# see https://dev.openwrt.org/ticket/4108
config rule
         option src              wan
         option proto            udp
         option dest_port        68
         option target           ACCEPT

#Allow ping
config rule
         option src wan
         option proto icmp
         option icmp_type echo-request
         option target ACCEPT

# include a file with users custom iptables rules
config include
         option path /etc/firewall.user


### EXAMPLE CONFIG SECTIONS
# do not allow a specific ip to access wan
#config rule
#       option src              lan
#       option src_ip   192.168.45.2
#       option dest             wan
#       option proto    tcp
#       option target   REJECT

# block a specific mac on wan
#config rule
#       option dest             wan
#       option src_mac  00:11:22:33:44:66
#       option target   REJECT

# block incoming ICMP traffic on a zone
#config rule
#       option src              lan
#       option proto    ICMP
#       option target   DROP

# port redirect port coming in on wan to lan
#config redirect
#       option src                      wan
#       option src_dport        5001
#       option dest                     lan
#       option dest_ip          192.168.3.1
#       option dest_port        5001
#       option proto            tcp
#config redirect
#        option src                      wan
#        option src_dport        5001
#        option dest                     lan
#        option dest_ip          192.168.3.1
#        option dest_port        5001
#        option proto            udp

### FULL CONFIG SECTIONS
#config rule
#       option src              lan
#       option src_ip   192.168.45.2
#       option src_mac  00:11:22:33:44:55
#       option src_port 80
#       option dest             wan
#       option dest_ip  194.25.2.129
#       option dest_port        120
#       option proto    tcp
#       option target   REJECT

#config redirect
#       option src              lan
#       option src_ip   192.168.45.2
#       option src_mac  00:11:22:33:44:55
#       option src_port         1024
#       option src_dport        80
#       option dest_ip  194.25.2.129
#       option dest_port        120
#       option proto    tcp


and one client (at least so far)

CLIENT:

/ETC/CONFIG/WIRELESS:

config 'wifi-device' 'wifi0'
         option 'type' 'atheros'
         option 'disabled' '0'
         option 'channel' '1'
         option 'txpower' '1'
         option 'hwmode' '11g'

config 'wifi-iface'
         option 'device' 'wifi0'
         option 'encryption' 'none'
         option 'ssid' 'potato'
         option 'bssid' '01:CA:FF:EE:BA:BE'
         option 'swmerge' '1'
         option 'mode' 'adhoc'

/ETC/CONFIG/NETWORK:

config 'switch' 'eth0'
         option 'enable' '1'

config 'switch_vlan' 'eth0_0'
         option 'device' 'eth0'
         option 'vlan' '0'
         option 'ports' '1 2 3 4 5'

config 'switch_vlan' 'eth0_1'
         option 'device' 'eth0'
         option 'vlan' '1'
         option 'ports' '0 5'

config 'interface' 'loopback'
         option 'ifname' 'lo'
         option 'proto' 'static'
         option 'ipaddr' '127.0.0.1'
         option 'netmask' '255.0.0.0'

config 'interface' 'wan'
         #option 'type' 'bridge'
         #list 'ifname' 'wifi0'
         #option 'ifname' 'eth0.1'
         #option 'dns' '10.130.1.1'
         #option 'defaultroute' '0'
         #option 'peerdns' '0'
         #option 'proto' 'static'
         #option 'ipaddr' '10.130.1.3'
         #option 'netmask' '255.255.255.0'
         #option 'gateway' '10.130.1.1'

config 'interface' 'lan'
         option 'ifname' 'eth0.0'
         option 'proto' 'static'
         option 'netmask' '255.255.255.0'
         option 'ipaddr' '192.168.4.1'

config 'interface' 'ath0'
     option 'ifname' 'ath0'
     option 'proto' 'static'
     option 'ipaddr' '10.130.1.3'
     option 'netmask' '255.255.255.0'
     option 'gateway' '10.130.1.1'
     option 'dns' '10.130.1.1'


/ETC/CONFIG/FIREWALL

config defaults
         option syn_flood        1
         option input            ACCEPT
         option output           ACCEPT
         option forward          REJECT

config zone
         option name             lan
         option input    ACCEPT
         option output   ACCEPT
         option forward  REJECT

config zone
         option name             wan
         option input    REJECT
         option output   ACCEPT
         option forward  REJECT
         option masq             1
         option mtu_fix  1

config forwarding
         option src      lan
         option dest     wan

config forwarding
         option src      wan
         option dest     lan

# We need to accept udp packets on port 68,
# see https://dev.openwrt.org/ticket/4108
config rule
         option src              wan
         option proto            udp
         option dest_port        68
         option target           ACCEPT

#Allow ping
config rule
         option src wan
         option proto icmp
         option icmp_type echo-request
         option target ACCEPT

# include a file with users custom iptables rules
config include
         option path /etc/firewall.user


### EXAMPLE CONFIG SECTIONS
# do not allow a specific ip to access wan
#config rule
#       option src              lan
#       option src_ip   192.168.45.2
#       option dest             wan
#       option proto    tcp
#       option target   REJECT

# block a specific mac on wan
#config rule
#       option dest             wan
#       option src_mac  00:11:22:33:44:66
#       option target   REJECT

# block incoming ICMP traffic on a zone
#config rule
#       option src              lan
#       option proto    ICMP
#       option target   DROP

# port redirect port coming in on wan to lan
#config redirect
#       option src                      wan
#       option src_dport        5001
#       option dest                     lan
#       option dest_ip          192.168.2.140
#       option dest_port        5001
#       option proto            tcp
#config redirect
#        option src                      wan
#        option src_dport        5001
#        option dest                     lan
#        option dest_ip          192.168.2.140
#        option dest_port        5001
#        option proto            udp

### FULL CONFIG SECTIONS
#config rule
#       option src              lan
#       option src_ip   192.168.45.2
#       option src_mac  00:11:22:33:44:55
#       option src_port 80
#       option dest             wan
#       option dest_ip  194.25.2.129
#       option dest_port        120
#       option proto    tcp
#       option target   REJECT

#config redirect
#       option src              lan
#       option src_ip   192.168.45.2
#       option src_mac  00:11:22:33:44:55
#       option src_port         1024
#       option src_dport        80
#       option dest_ip  194.25.2.129
#       option dest_port        120
#       option proto    tcp


I start batmand with:

On the Gateway:
batmand -d 3 -g 11000 -a 192.168.3.0/24 --hop-penalty 5 --purge-timeout 
50000 ath0

and on the client
batmand -d 3 -r 2 -a 192.168.4.0/24 --disable-client-nat --hop-penalty 5 
--purge-timeout 50000 ath0


Then I check all:

batmand -d1 -c
On the gateway:
Originator  (#/255)         Nexthop [outgoingIF]:   Potential nexthops 
... [B.A.T.M.A.N. 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.1, UT: 0d 
0h 1m]
10.130.1.3      (234)      10.130.1.3 [      ath0]:      10.130.1.3 (234)


On the client:
   Originator  (#/255)         Nexthop [outgoingIF]:   Potential 
nexthops ... [B.A.T.M.A.N. 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.3, 
UT: 0d 0h 3m]
10.130.1.1      (243)      10.130.1.1 [      ath0]:      10.130.1.1 (243)




batmand -d2 -c



On the gateway:
Gateway     (#/255)         Nexthop [outgoingIF], gw_class ... 
[B.A.T.M.A.N. 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.1, UT: 0d 0h 2m]
No gateways in range ...



On the client:
I can see my gateway -> 10.130.1.1
      Gateway     (#/255)         Nexthop [outgoingIF], gw_class ... 
[B.A.T.M.A.N. 0.4-alpha rv1439, MainIF/IP: ath0/10.130.1.3, UT: 0d 0h 4m]
=> 10.130.1.1      (255)      10.130.1.1 [      ath0], gw_class 184 - 
12MBit/1536KBit, gateway failures: 0




Command ifconfig showed:
on the gateway:

ath0      Link encap:Ethernet  HWaddr 00:0E:8E:18:F7:91
          inet addr:10.130.1.1  Bcast:10.130.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:517 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3301 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:28892 (28.2 KiB)  TX bytes:213735 (208.7 KiB)

eth0      Link encap:Ethernet  HWaddr 00:1A:92:7E:27:B7
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3709 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4320 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:351741 (343.4 KiB)  TX bytes:754122 (736.4 KiB)
          Interrupt:4

eth0.0    Link encap:Ethernet  HWaddr 00:1A:92:7E:27:B7
          inet addr:192.168.3.1  Bcast:192.168.3.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3581 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2304 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:274574 (268.1 KiB)  TX bytes:602269 (588.1 KiB)

eth0.1    Link encap:Ethernet  HWaddr 00:1A:92:7E:27:B7
          inet addr:192.168.2.2  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:111 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2017 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:9083 (8.8 KiB)  TX bytes:105082 (102.6 KiB)

gate0     Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          inet addr:169.254.0.0  P-t-P:169.254.0.0  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1471  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:214 errors:0 dropped:0 overruns:0 frame:0
          TX packets:214 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:18654 (18.2 KiB)  TX bytes:18654 (18.2 KiB)

wifi0     Link encap:UNSPEC  HWaddr 
00-0E-8E-18-F7-91-00-00-00-00-00-00-00-00-00-00
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6600 errors:0 dropped:0 overruns:0 frame:696
          TX packets:3933 errors:271 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:195
          RX bytes:856392 (836.3 KiB)  TX bytes:344114 (336.0 KiB)
          Interrupt:6



and on the client:



ath0      Link encap:Ethernet  HWaddr 00:0E:8E:18:F7:AE
           inet addr:10.130.1.3  Bcast:10.130.1.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:3805 errors:0 dropped:7 overruns:0 frame:0
           TX packets:1236 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:192820 (188.3 KiB)  TX bytes:83458 (81.5 KiB)

eth0      Link encap:Ethernet  HWaddr 00:1A:92:7E:27:71
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:4205 errors:0 dropped:0 overruns:0 frame:0
           TX packets:3622 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:337594 (329.6 KiB)  TX bytes:360497 (352.0 KiB)
           Interrupt:4

eth0.0    Link encap:Ethernet  HWaddr 00:1A:92:7E:27:71
           inet addr:192.168.4.1  Bcast:192.168.4.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:4200 errors:0 dropped:0 overruns:0 frame:0
           TX packets:3620 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:261741 (255.6 KiB)  TX bytes:335861 (327.9 KiB)

gate0     Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
           inet addr:169.254.0.1  P-t-P:169.254.0.1  Mask:255.255.255.255
           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1471  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:15 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:500
           RX bytes:0 (0.0 B)  TX bytes:1260 (1.2 KiB)

gate1     Link encap:UNSPEC  HWaddr 
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
           inet addr:169.254.0.1  P-t-P:169.254.0.1  Mask:255.255.255.255
           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1471  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:500
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:34 errors:0 dropped:0 overruns:0 frame:0
           TX packets:34 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:2164 (2.1 KiB)  TX bytes:2164 (2.1 KiB)

wifi0     Link encap:UNSPEC  HWaddr 
00-0E-8E-18-F7-AE-00-00-00-00-00-00-00-00-00-00
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:43355 errors:0 dropped:0 overruns:0 frame:801
           TX packets:1938 errors:333 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:195
           RX bytes:4590804 (4.3 MiB)  TX bytes:175638 (171.5 KiB)
           Interrupt:6



And route -n    showed:

on the gateway:

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
10.130.1.0      0.0.0.0         255.255.255.0   U     0      0        0 ath0
192.168.3.0     0.0.0.0         255.255.255.0   U     0      0        0 
eth0.0
192.168.2.0     0.0.0.0         255.255.255.0   U     0      0        0 
eth0.1
169.254.0.0     0.0.0.0         255.255.0.0     U     0      0        0 
gate0
0.0.0.0         192.168.2.1     0.0.0.0         UG    0      0        0 
eth0.1



and on the client:



Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use 
Iface
192.168.4.0     0.0.0.0         255.255.255.0   U     0      0        0 
eth0.0
10.130.1.0      0.0.0.0         255.255.255.0   U     0      0        0 ath0
0.0.0.0         10.130.1.1      0.0.0.0         UG    0      0        0 ath0



I added also a registration to iptable (on the gateway and on the client 
the same)
iptables -t nat -I POSTROUTING -o gate0 -j MASQUERADE



So, nodes can see each other, and the gateway is broadcasting (client 
can see it).
I can ping from gateway to client by tunnel -> ping 169.254.0.0 but I 
can`t ping from client to gateway -> ping 169.254.0.0 , what`s wrong?
Unfortunately, I can`t get internet too.

Can somebody help me? I suppose there is a small mistake, as always but 
I have recently started my adventures with Open Wrt so I don`t 
understand everything and it can be my mistake.
Thanks in Advance,
Krzysiek (student).


-------------------------------------------------	
Ustaw Interie jako strone startowa!
Zobacz jak to zrobic >> http://linkint.pl/f297e

