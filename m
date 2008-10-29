Message-ID: <d5bba6ce0810290758q517ea4b3vf7a688599c2fe2f0@mail.gmail.com>
Date: Wed, 29 Oct 2008 12:58:31 -0200
From: "Julio Cesar Puigpinos" <jcpuigpinos@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
In-Reply-To: <200810280856.11668.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
	<200810270502.41531.axel@open-mesh.net>
	<d5bba6ce0810271636p2d1b0476q35dd43dd17fc07af@mail.gmail.com>
	<200810280856.11668.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

2008/10/28 Axel Neumann :
> Hi,

Hi

> Can you just to give a bigger picture also send the debuglevel
> 3 and 8 log of the gateway and the client?

Sure, they are at the bottom of this email.

> Please check if your output differs from the below given ones.
> The gw node should setup a bat0 interface from the beginning.

Yes, it does set up bat0.

> The client should
> have set tun0 up after the handshake process (with -o 2000 -r 1
> approximately 200 seconds after startup)

No, it didn't do it.

One message that I saw that sometimes appears, while using debug level
3 in both the client and the gw, was like this "ERROR: rcvd dbgl msg
via fd 10, len 0, error Success".

> Note that usually I would suspect a firewall issue but this shuld be ruled out
> as you said you are working with the same setup that worked with rv1069.

Right, it works well with rv1069. To test both revisions I just opkg
remove, install and reboot each time.

> If you have tcpdump on your devices or a monitoring external computer,
> check if handshake messages are really exchanged on port 4306, eg:
> tcpdump -i ath0 -nv port 4306
> 08:33:19.703484 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 35) 103.130.30.248.4306 > 103.130.30.3.4306: UDP, length 7
> 08:33:19.703559 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 35) 103.130.30.3.4306 > 103.130.30.248.4306: UDP, length 7

This are 3 lines from the output (both client and gw showed the same,
except the IP order):
00:12:23.353439 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto
UDP (17), length 35) 5.129.82.40.4306 > 5.252.88.99.4306: UDP, length
7
00:12:24.420921 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto
UDP (17), length 35) 5.129.82.40.4306 > 5.252.88.99.4306: UDP, length
7
00:12:25.421004 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto
UDP (17), length 35) 5.129.82.40.4306 > 5.252.88.99.4306: UDP, length
7

> Just for testing you may try with one-way-tunnel at the client side to
> see if the bat0 interface is set up correctly. This tunneltype is stateless
> and therefore needs no handshake messages between client and gw node.
> A simple bmxd -c --one-way-tunnel=4
> assigned to the runnung client-daemon should at least show the bat0 interface
> (now configured with a 5.255.22.x IP instead of a 169.254.1.x ip) at the client.
> But for really using it you may need to modify your iptables settings.

Using that, debug level 3 shows:
[    200363] using default tunnel to GW 5.252.88.99 (gw_flags: 49,
packet_count: 960, gw_product: 589824)
[    200364] add_default_route()...
[    200413] client_to_gw_tun() started...
[    200417] Tried to name tunnel to bat0 ... success
[    200421] select() indicated changed interface status! Going to
check interfaces!
[    200423] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500
[    200423] select() indicated changed interface status! Going to
check interfaces!
[    200424] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500
[    200425] select() indicated changed interface status! Going to
check interfaces!
[    200425] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500
[    200426] select() indicated changed interface status! Going to
check interfaces!
[    200427] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500

And the bat0 shows up like this:
bat0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          inet addr:5.129.82.40  P-t-P:5.129.82.40  Mask:255.255.255.255
          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1471  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:282 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:500
          RX bytes:0 (0.0 B)  TX bytes:20776 (20.2 KiB)

> happy testing,
> axel
>
>
> Altogether debuglevel3 should look like this (on the gw-client side):
> root@248:~# bmxd -cd3
> [...]

In mi case, this doesn't happens. It just keeps requesting an IP, then
gives up for some seconds and tries again and again.


> On the gw-side it should look like:
> neumann@smart:/usr/src/batman-svn/trunk/batman-experimental$ sudo ./batmand -o 2000 -g 5000 -d 3 eth0:bmx
> [...]
> [      2782] change route to 103.130.30.248  via 103.130.30.248    1 / 100 (prev. via 0.0.0.0           0)
> [    181474] Gateway - assigned 169.254.1.245 to client: 103.130.30.248

In my case it didn't asign an IP to the client.

                   Saludos, Julio


++++ Logs taked from the gw ++++
*Debug level 8
BatMan-eXp 0.3-alpha, IF ath2 5.252.88.99, LinkWindowSize 100,
PathWindSize 100, OGI 2000ms, currSeqno 22461, UT 0:00:36:09, CPU
1/1000, IntTime    2169739
Neighbor        outgoingIF     bestNextHop brc (~rcvd  knownSince
lseq lvld rid nid ) [     viaIF RTQ  RQ  TQ]..
5.129.82.40     ath2           5.129.82.40 100 (   99  0:00:10:00
44589    1   1   1 ) [      ath2 100 100 100]

Originator      outgoingIF     bestNextHop brc (~rcvd  knownSince
lseq lvld pws  ogi cpu hop change ) alternativeNextHops brc ...
5.129.82.40     ath2           5.129.82.40 100 (   99  0:00:10:00
44589    1 100 2014   5   1      1 )
   1 known Originator(s), averages:        100 (   99
    1 100 2014   5   1      1 )

*Debug level 3
BatMan-eXp 0.3-alpha (compatibility version 10) !

gateway class: 49 -> propagating: 4MBit/1024KBit

Startup parameters: bmxd -o 2000 -g 5000 -d 3 ath2

   duplicate-address-detection timeout 100s, purge timeout 2525s,
originator interval 2000ms, window size 100

searching min. MTU, so fare: 1500, current dev ath2, mtu: 1500

detected wireless interface ath2  (use ath2 /l to correct this assumption)

changing /proc/sys/net/ipv4/conf/ath2/send_redirects from 1 to 0

activated interface ath2 5.252.88.99/8 broadcast address 5.255.255.255

add rule from 0.0.0.0/0, table 64, prio 6500, if (null), type 1

add rule from 0.0.0.0/0, table 66, prio 6600, if (null), type 1

add rule from 0.0.0.0/0, table 65, prio 6699, if (null), type 1

add route to 127.0.0.0 via 0.0.0.0 src 0.0.0.0 dev lo, table 65, type 1

add route to 10.0.0.0 via 0.0.0.0 src 0.0.0.0 dev eth0, table 65, type 1

add route to 10.88.99.0 via 0.0.0.0 src 0.0.0.0 dev ath0, table 65, type 1

add route to 10.88.99.128 via 0.0.0.0 src 0.0.0.0 dev ath1, table 65, type 1

start_gw_service ()

[       124] changing /proc/sys/net/ipv4/conf/all/send_redirects from 1 to 0

[       132] changing /proc/sys/net/ipv4/conf/default/send_redirects
from 1 to 0

[       139] gw_listen() started...

[       139] gw_listen(): my_tun_ip 169.254.0.0, my_tun_netmask: 255.255.252.0

[       140] Tried to name tunnel to bat0 ... success

[       140] select() indicated changed interface status! Going to
check interfaces!

[       141] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500

[       142] select() indicated changed interface status! Going to
check interfaces!

[       142] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500

[       143] select() indicated changed interface status! Going to
check interfaces!

[       144] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500

[       165] select() indicated changed interface status! Going to
check interfaces!

[       166] researching min. MTU, so fare: 1500, current dev ath2, mtu: 1500

[   15710] change route to 5.129.82.40     via 5.129.82.40       1 /
100 (prev. Via 0.0.0.0           0)

*bat0 shows up like this
bat0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00

          inet addr:169.254.0.0  P-t-P:169.254.0.0  Mask:255.255.255.255

          UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1471  Metric:1

          RX packets:0 errors:0 dropped:0 overruns:0 frame:0

          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:500

          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)



++++ Logs taked from the client ++++
*Debug level 8
BatMan-eXp 0.3-alpha, IF ath2 5.129.82.40, LinkWindowSize 100,
PathWindSize 100, OGI 2000ms, currSeqno 7055, UT 0:00:13:13, CPU
3/1000, IntTime     793302
Neighbor        outgoingIF     bestNextHop brc (~rcvd  knownSince
lseq lvld rid nid ) [     viaIF RTQ  RQ  TQ]..
5.252.88.99     ath2           5.252.88.99 100 (   99  0:00:06:56
21584    1   1   1 ) [      ath2 100 100 100]

Originator      outgoingIF     bestNextHop brc (~rcvd  knownSince
lseq lvld pws  ogi cpu hop change ) alternativeNextHops brc ...
5.252.88.99     ath2           5.252.88.99 100 (   99  0:00:06:56
21584    1 100 1998   1   1      1 )
   1 known Originator(s), averages:        100 (   99
    1 100 1998   1   1      1 )


*Debug level 3
[    379294] change route to 5.252.88.99     via 5.252.88.99       1 /
100 (prev. via 0.0.0.0           0)
[    379299] found new gateway 5.252.88.99, announced by 5.252.88.99
-> class: 49 - 4MBit/1024KBit, new supported tunnel types TWT, OWT
[    380363] using default tunnel to GW 5.252.88.99 (gw_flags: 49,
packet_count: 10, gw_product: 64)
[    380364] add_default_route()...
[    380375] client_to_gw_tun() started...
[    380375] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
      .........................  20 times the same message
.........................
[    403643] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
[    404634] ERROR: rcvd dbgl msg via fd 15, len 0, error Success
[    404643] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
       .........................  37 times the same message
.........................
[    445253] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
[    445454] Gateway client - disconnecting from unresponsive gateway
(5.252.88.99) !
[    445455] Gateway client - Maximum number of tunnel ip requests send !
[    445455] Gateway client - Ignoring this GW for 10 secs
[    445456] terminating client_to_gw_tun thread: is_aborted(): NO,
curr_gateway: 4799696, deleted: 0
[    445459] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
(table 68): No such process
[    445466] Error - can't delete tun device: Inappropriate ioctl for device
[    456306] using default tunnel to GW 5.252.88.99 (gw_flags: 49,
packet_count: 370, gw_product: 87616)
[    456310] add_default_route()...
[    456318] client_to_gw_tun() started...
[    456352] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
      .........................  59 times the same message
.........................
[    521513] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
[    521714] Gateway client - disconnecting from unresponsive gateway
(5.252.88.99) !
[    521715] Gateway client - Maximum number of tunnel ip requests send !
[    521715] Gateway client - Ignoring this GW for 40 secs
[    521716] terminating client_to_gw_tun thread: is_aborted(): NO,
curr_gateway: 4799696, deleted: 0
[    521719] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
(table 68): No such process
[    521726] Error - can't delete tun device: Inappropriate ioctl for device
[    561963] using default tunnel to GW 5.252.88.99 (gw_flags: 49,
packet_count: 890, gw_product: 506944)
[    561964] add_default_route()...
[    561973] client_to_gw_tun() started...
[    561974] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
      .........................  60 times the same message
.........................
[    627583] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
[    627784] Gateway client - disconnecting from unresponsive gateway
(5.252.88.99) !
[    627785] Gateway client - Maximum number of tunnel ip requests send !
[    627785] Gateway client - Ignoring this GW for 90 secs
[    627786] terminating client_to_gw_tun thread: is_aborted(): NO,
curr_gateway: 4799696, deleted: 0
[    627790] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
(table 68): No such process
[    627796] Error - can't delete tun device: Inappropriate ioctl for device
[    717783] using default tunnel to GW 5.252.88.99 (gw_flags: 49,
packet_count: 990, gw_product: 627264)
[    717784] add_default_route()...
[    717792] client_to_gw_tun() started...
[    717793] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
      .........................  59 times the same message
.........................
[    782623] send ip request to gateway: 5.252.88.99, preferred IP: 0.0.0.0
[    782824] Gateway client - disconnecting from unresponsive gateway
(5.252.88.99) !
[    782825] Gateway client - Maximum number of tunnel ip requests send !
[    782825] Gateway client - Ignoring this GW for 160 secs
[    782826] terminating client_to_gw_tun thread: is_aborted(): NO,
curr_gateway: 4799696, deleted: 0
[    782830] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
(table 68): No such process
[    782836] Error - can't delete tun device: Inappropriate ioctl for device

And it will go on like this, again and again, after the ignoring time passes.

-- 
www.lugro-mesh.org.ar/        Wireless Mesh Networks Group
www.lugro.org.ar                         GNU/Linux User Group Rosario, Argentina
Slackware rulez :P             www.slackware.org
NO A LA MATRICULA!!!: http://noalamatricula.wordpress.com/
