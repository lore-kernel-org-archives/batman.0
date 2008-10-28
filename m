From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
Date: Tue, 28 Oct 2008 09:56:11 +0200
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
	<200810270502.41531.axel@open-mesh.net>
	<d5bba6ce0810271636p2d1b0476q35dd43dd17fc07af@mail.gmail.com>
In-Reply-To: <d5bba6ce0810271636p2d1b0476q35dd43dd17fc07af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810280856.11668.axel@open-mesh.net>
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

Hi,

Can you just to give a bigger picture also send the debuglevel 
3 and 8 log of the gateway and the client?
Please check if your output differs from the below given ones.
The gw node should setup a bat0 interface from the beginning. The client should 
have set tun0 up after the handshake process (with -o 2000 -r 1 
approximately 200 seconds after startup)

Note that usually I would suspect a firewall issue but this shuld be ruled out 
as you said you are working with the same setup that worked with rv1069.

If you have tcpdump on your devices or a monitoring external computer,
check if handshake messages are really exchanged on port 4306, eg:
tcpdump -i ath0 -nv port 4306
08:33:19.703484 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 35) 103.130.30.248.4306 > 103.130.30.3.4306: UDP, length 7
08:33:19.703559 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto UDP (17), length 35) 103.130.30.3.4306 > 103.130.30.248.4306: UDP, length 7

Just for testing you may try with one-way-tunnel at the client side to 
see if the bat0 interface is set up correctly. This tunneltype is stateless 
and therefore needs no handshake messages between client and gw node.
A simple bmxd -c --one-way-tunnel=4  
assigned to the runnung client-daemon should at least show the bat0 interface
(now configured with a 5.255.22.x IP instead of a 169.254.1.x ip) at the client.
But for really using it you may need to modify your iptables settings.



happy testing,
axel


Altogether debuglevel3 should look like this (on the gw-client side):
root@248:~# bmxd -cd3
BatMan-eXp 0.3-alpha rv1134 (compatibility version 10) !
[     23151] change route to 103.130.30.3    via 103.130.30.3      1 / 100 (prev. via 0.0.0.0           0)
[     23156] found new gateway 103.130.30.3, announced by 103.130.30.3 -> class: 49 - 4MBit/1024KBit, new supported tunnel types TWT, OWT
[    200614] using default tunnel to GW 103.130.30.3 (gw_flags: 49, packet_count: 830, gw_product: 440896)
[    200617] add_default_route()...
[    200684] client_to_gw_tun() started...
[    200688] send ip request to gateway: 103.130.30.3, preferred IP: 0.0.0.0
[    200691] Gateway client - gateway (103.130.30.3) replyed with virtual IP
[    200694] Gateway client - got IP 169.254.1.245 (preferred: IP 0.0.0.0) from gateway: 103.130.30.3 for 600 seconds.
[    200697] Tried to name tunnel to bat0 ... success
[    200701] Gateway client - refreshed IP 169.254.1.245
[    200704] select() indicated changed interface status! Going to check interfaces!
[    200708] researching min. MTU, so fare: 1500, current dev eth0.0:bmx, mtu: 1500
and when the first udp/tcp packet is send from the gw-client to the internet..
[    399653] changed GW state: from 1 to 2, incoming IP protocol: 17

On the gw-side it should look like:
neumann@smart:/usr/src/batman-svn/trunk/batman-experimental$ sudo ./batmand -o 2000 -g 5000 -d 3 eth0:bmx
BatMan-eXp 0.3-alpha (compatibility version 10) !
gateway class: 49 -> propagating: 4MBit/1024KBit
Startup parameters: ./batmand -o 2000 -g 5000 -d 3 eth0:bmx
   duplicate-address-detection timeout 100s, purge timeout 2525s, originator interval 2000ms, window size 100
searching min. MTU, so fare: 1500, current dev eth0:bmx, mtu: 1500
detected non-wireless interface eth0:bmx  (use eth0:bmx /w to correct this assumption)
activated interface eth0:bmx 103.130.30.3/8 broadcast address 103.255.255.255
add rule from 0.0.0.0/0, table 64, prio 6500, if (null), type 1
add rule from 0.0.0.0/0, table 66, prio 6600, if (null), type 1
add rule from 0.0.0.0/0, table 65, prio 6699, if (null), type 1
add route to 127.0.0.0 via 0.0.0.0 src 0.0.0.0 dev lo, table 65, type 1
add route to 1.0.0.0 via 0.0.0.0 src 0.0.0.0 dev lo:test, table 65, type 1
add route to 192.168.1.0 via 0.0.0.0 src 0.0.0.0 dev wlan0, table 65, type 1
start_gw_service ()
[         7] changing /proc/sys/net/ipv4/conf/all/send_redirects from 1 to 0
[         8] changing /proc/sys/net/ipv4/conf/default/send_redirects from 1 to 0
[         9] changing /proc/sys/net/ipv4/ip_forward from 0 to 1
[         9] gw_listen() started...
[        10] gw_listen(): my_tun_ip 169.254.0.0, my_tun_netmask: 255.255.252.0
[        10] Tried to name tunnel to bat0 ... success
[        10] select() indicated changed interface status! Going to check interfaces!
[        10] researching min. MTU, so fare: 1500, current dev eth0:bmx, mtu: 1500
[      2782] change route to 103.130.30.248  via 103.130.30.248    1 / 100 (prev. via 0.0.0.0           0)
[    181474] Gateway - assigned 169.254.1.245 to client: 103.130.30.248
                                   

On Dienstag 28 Oktober 2008, Julio Cesar Puigpinos wrote:
> 2008/10/27 Axel Neumann <axel@open-mesh.net>:
> > Hi Julio, Stephan,..
>
> Hi Axel
>
> > I could not reproduce the described problems (in my setup with x86 and
> > mipsel r1069 and 1138 cooperated as expected). But your reports pointed
> > me to some forgotten and falsley directed debug messages from the tunnel
> > thread, some other threading issues, and the need for Sven Eckelmanns
> > patch for allocate.c which is applied now.
> >
> > please let me know if there are further issues with MIPS big endian.
>
> I'm still getting the same messages, and having the same problem.
>
> Is there any other info that I can provide or test to do, to help find
> the source of the problem?
>
> > ciao,
> > axel
>
>             Saludos, Julio


