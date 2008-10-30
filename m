Message-ID: <8c906fa50810300708j1a3547fdoabb6aa7b395f9f07@mail.gmail.com>
Date: Thu, 30 Oct 2008 12:08:40 -0200
From: "Gustavo Lindberg" <gus.lindberg@gmail.com>
Subject: Re: [B.A.T.M.A.N.] BMX problem in r1138 with client node and tun
In-Reply-To: <200810292133.58495.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5209_12528683.1225375720357"
References: <d5bba6ce0810251333r67247a0cpaf164be0e33b0f38@mail.gmail.com>
	<200810280856.11668.axel@open-mesh.net>
	<d5bba6ce0810290758q517ea4b3vf7a688599c2fe2f0@mail.gmail.com>
	<200810292133.58495.axel@open-mesh.net>
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

------=_Part_5209_12528683.1225375720357
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/10/29 Axel Neumann <axel@open-mesh.net>

> Hey Julio,
>
> actually I am a bit clueless. Today I came back to Berlin, where I could
> test
> on Foneros MIPS devices (I suspected the endian type to be related to the
> problem but it also works very smoothly there. I tried with rv1146 on gw
> and
> client and with exactly the same parameter which you used. For me it looks
> like the handshake messages send by the client do not even end up at the
> bmxd
> running in the gw-node.
>
> In rv1147 i fixed some more misdirected debug-messages send by the tunnel
> thread (but I doubt this was the reason for the problem) and I put another
> debug message in the tunnel thread which should log invalid tunnel messages
> to debug-level 0 and 3. Have a look also on what printed to debug-level 0 /
> logread.  If this doesnt show anything useful and if you are able to
>  compile
> the binaries on your own, you may uncomment lines 1179 and 1180 in
> posix/tunnel.c which should cause the tunnel thread to log all incoming
> message on its dedicated port.
>
> If you send the output of
> ip a
> ip rule
> iptables -t nat -L -nv
> iptables -L -nv
>
> I would also have a look on that.
>
> Some more comments inline...
>
> On Mittwoch 29 Oktober 2008, Julio Cesar Puigpinos wrote:
> >
> > Yes, it does set up bat0.
> >
> > > The client should
> > > have set tun0 up after the handshake process (with -o 2000 -r 1
> > > approximately 200 seconds after startup)
> >
> > No, it didn't do it.
>
> shit but makes sense, the client does only setit up after a succesfull
> handshake.
>
> >
> > One message that I saw that sometimes appears, while using debug level
> > 3 in both the client and the gw, was like this "ERROR: rcvd dbgl msg
> > via fd 10, len 0, error Success".
>
> ok thats no problem, not really an error. Have to fix that. This message
> always appears when "bmxd -c ..." terminates after pulling for example
> on-the-fly debug-messages from the main daemon.
>
> >
> > > Note that usually I would suspect a firewall issue but this shuld be
> > > ruled out as you said you are working with the same setup that worked
> > > with rv1069.
> >
> > Right, it works well with rv1069. To test both revisions I just opkg
> > remove, install and reboot each time.
>
> Maybe the problem is related to something completely different. What about
> using
>
> http://downloads.open-mesh.net/batman/development/misc/batmand-exp_0.3-alpha-current_mips-kk-elf-32-msb-dynamic
> exchange current with rv1147/rv11 and dynamic with static to
> old reveisions can be found here:
>
> http://downloads.open-mesh.net/batman/development/misc/old/batmand-exp_0.3-alpha-rv1069_mips-kk-elf-32-msb-dynamic

Hi Alex, Gustavo.
These binaries were compiled on a kamikaze trunk ?  Details?
TIA

>
>
> save it to /tmp/bmxd, dont forget chmod u+x /tmp/bmxd, maybe set a link
> from /usr/sbin/bmxd to /tmp/bmxd,... and just restart the daemon
>
> you can use "bmxd -c --purge" to shortcut the duplicate address detection
> timeout which you may have noticed. With -o 2000 this can be annoying.
>
> >
> > This are 3 lines from the output (both client and gw showed the same,
> > except the IP order):
> > 00:12:23.353439 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto
> > UDP (17), length 35) 5.129.82.40.4306 > 5.252.88.99.4306: UDP, length
>
> looks good. Just misses the reply :-(
>
> >
> > > Just for testing you may try with one-way-tunnel at the client side to
> > > see if the bat0 interface is set up correctly. This tunneltype is
> > > stateless and therefore needs no handshake messages between client and
> gw
> > > node. A simple bmxd -c --one-way-tunnel=4
> > > assigned to the runnung client-daemon should at least show the bat0
> > > interface (now configured with a 5.255.22.x IP instead of a 169.254.1.x
> > > ip) at the client. But for really using it you may need to modify your
> > > iptables settings.
> >
> > Using that, debug level 3 shows:
> > [    200363] using default tunnel to GW 5.252.88.99 (gw_flags: 49,
> > packet_count: 960, gw_product: 589824)
> > [    200364] add_default_route()...
> > [    200413] client_to_gw_tun() started...
> > [    200417] Tried to name tunnel to bat0 ... success
> > [    200421] select() indicated changed interface status! Going to
> > check interfaces!
> > [    200423] researching min. MTU, so fare: 1500, current dev ath2, mtu:
> > 1500 [    200423] select() indicated changed interface status! Going to
> > check interfaces!
>
> >
> > And the bat0 shows up like this:
> > bat0      Link encap:UNSPEC  HWaddr
> > 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> >           inet addr:5.129.82.40  P-t-P:5.129.82.40  Mask:255.255.255.255
> >           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1471  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:282 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:500
> >           RX bytes:0 (0.0 B)  TX bytes:20776 (20.2 KiB)
>
> also looks good.
>
>
> >
> > > happy testing,
> > > axel
> > >
> > >
> > > Altogether debuglevel3 should look like this (on the gw-client side):
> > > root@248:~# bmxd -cd3
> > > [...]
> >
> > In mi case, this doesn't happens. It just keeps requesting an IP, then
> > gives up for some seconds and tries again and again.
> >
> > > On the gw-side it should look like:
> > > neumann@smart:/usr/src/batman-svn/trunk/batman-experimental$ sudo
> > > ./batmand -o 2000 -g 5000 -d 3 eth0:bmx [...]
> > > [      2782] change route to 103.130.30.248  via 103.130.30.248    1 /
> > > 100 (prev. via 0.0.0.0           0) [    181474] Gateway - assigned
> > > 169.254.1.245 to client: 103.130.30.248
> >
> > In my case it didn't asign an IP to the client.
> >
> >                    Saludos, Julio
> >
> >
> > ++++ Logs taked from the gw ++++
> > *Debug level 8
> > BatMan-eXp 0.3-alpha, IF ath2 5.252.88.99, LinkWindowSize 100,
> > PathWindSize 100, OGI 2000ms, currSeqno 22461, UT 0:00:36:09, CPU
> > 1/1000, IntTime    2169739
> > Neighbor        outgoingIF     bestNextHop brc (~rcvd  knownSince
> > lseq lvld rid nid ) [     viaIF RTQ  RQ  TQ]..
> > 5.129.82.40     ath2           5.129.82.40 100 (   99  0:00:10:00
> > 44589    1   1   1 ) [      ath2 100 100 100]
> >
> > Originator      outgoingIF     bestNextHop brc (~rcvd  knownSince
> > lseq lvld pws  ogi cpu hop change ) alternativeNextHops brc ...
> > 5.129.82.40     ath2           5.129.82.40 100 (   99  0:00:10:00
> > 44589    1 100 2014   5   1      1 )
> >    1 known Originator(s), averages:        100 (   99
> >     1 100 2014   5   1      1 )
> >
> > *Debug level 3
> > BatMan-eXp 0.3-alpha (compatibility version 10) !
> >
> > gateway class: 49 -> propagating: 4MBit/1024KBit
> >
> > Startup parameters: bmxd -o 2000 -g 5000 -d 3 ath2
> >
> >    duplicate-address-detection timeout 100s, purge timeout 2525s,
> > originator interval 2000ms, window size 100
> >
> > searching min. MTU, so fare: 1500, current dev ath2, mtu: 1500
> >
> > detected wireless interface ath2  (use ath2 /l to correct this
> assumption)
> >
> > changing /proc/sys/net/ipv4/conf/ath2/send_redirects from 1 to 0
> >
> > activated interface ath2 5.252.88.99/8 broadcast address 5.255.255.255
> >
> > add rule from 0.0.0.0/0, table 64, prio 6500, if (null), type 1
> >
> > add rule from 0.0.0.0/0, table 66, prio 6600, if (null), type 1
> >
> > add rule from 0.0.0.0/0, table 65, prio 6699, if (null), type 1
> >
> > add route to 127.0.0.0 via 0.0.0.0 src 0.0.0.0 dev lo, table 65, type 1
> >
> > add route to 10.0.0.0 via 0.0.0.0 src 0.0.0.0 dev eth0, table 65, type 1
> >
> > add route to 10.88.99.0 via 0.0.0.0 src 0.0.0.0 dev ath0, table 65, type
> 1
> >
> > add route to 10.88.99.128 via 0.0.0.0 src 0.0.0.0 dev ath1, table 65,
> type
> > 1
> >
> > start_gw_service ()
> >
> > [       124] changing /proc/sys/net/ipv4/conf/all/send_redirects from 1
> to
> > 0
> >
> > [       132] changing /proc/sys/net/ipv4/conf/default/send_redirects
> > from 1 to 0
> >
> > [       139] gw_listen() started...
> >
> > [       139] gw_listen(): my_tun_ip 169.254.0.0, my_tun_netmask:
> > 255.255.252.0
> >
> > [       140] Tried to name tunnel to bat0 ... success
> >
> > [       140] select() indicated changed interface status! Going to
> > check interfaces!
> >
> > [       141] researching min. MTU, so fare: 1500, current dev ath2, mtu:
> > 1500
> >
> > [       142] select() indicated changed interface status! Going to
> > check interfaces!
> >
> > [       142] researching min. MTU, so fare: 1500, current dev ath2, mtu:
> > 1500
> >
> > [       143] select() indicated changed interface status! Going to
> > check interfaces!
> >
> > [       144] researching min. MTU, so fare: 1500, current dev ath2, mtu:
> > 1500
> >
> > [       165] select() indicated changed interface status! Going to
> > check interfaces!
> >
> > [       166] researching min. MTU, so fare: 1500, current dev ath2, mtu:
> > 1500
> >
> > [   15710] change route to 5.129.82.40     via 5.129.82.40       1 /
> > 100 (prev. Via 0.0.0.0           0)
> >
> > *bat0 shows up like this
> > bat0      Link encap:UNSPEC  HWaddr
> > 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
> >
> >           inet addr:169.254.0.0  P-t-P:169.254.0.0  Mask:255.255.255.255
> >
> >           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1471  Metric:1
> >
> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> >
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >
> >           collisions:0 txqueuelen:500
> >
> >           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> >
> >
> >
> > ++++ Logs taked from the client ++++
> > *Debug level 8
> > BatMan-eXp 0.3-alpha, IF ath2 5.129.82.40, LinkWindowSize 100,
> > PathWindSize 100, OGI 2000ms, currSeqno 7055, UT 0:00:13:13, CPU
> > 3/1000, IntTime     793302
> > Neighbor        outgoingIF     bestNextHop brc (~rcvd  knownSince
> > lseq lvld rid nid ) [     viaIF RTQ  RQ  TQ]..
> > 5.252.88.99     ath2           5.252.88.99 100 (   99  0:00:06:56
> > 21584    1   1   1 ) [      ath2 100 100 100]
> >
> > Originator      outgoingIF     bestNextHop brc (~rcvd  knownSince
> > lseq lvld pws  ogi cpu hop change ) alternativeNextHops brc ...
> > 5.252.88.99     ath2           5.252.88.99 100 (   99  0:00:06:56
> > 21584    1 100 1998   1   1      1 )
> >    1 known Originator(s), averages:        100 (   99
> >     1 100 1998   1   1      1 )
> >
> >
> > *Debug level 3
> > [    379294] change route to 5.252.88.99     via 5.252.88.99       1 /
> > 100 (prev. via 0.0.0.0           0)
> > [    379299] found new gateway 5.252.88.99, announced by 5.252.88.99
> > -> class: 49 - 4MBit/1024KBit, new supported tunnel types TWT, OWT
> > [    380363] using default tunnel to GW 5.252.88.99 (gw_flags: 49,
> > packet_count: 10, gw_product: 64)
> > [    380364] add_default_route()...
> > [    380375] client_to_gw_tun() started...
> > [    380375] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> >       .........................  20 times the same message
> > .........................
> > [    403643] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> > [    404634] ERROR: rcvd dbgl msg via fd 15, len 0, error Success
> > [    404643] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> >        .........................  37 times the same message
> > .........................
> > [    445253] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> > [    445454] Gateway client - disconnecting from unresponsive gateway
> > (5.252.88.99) !
> > [    445455] Gateway client - Maximum number of tunnel ip requests send !
> > [    445455] Gateway client - Ignoring this GW for 10 secs
> > [    445456] terminating client_to_gw_tun thread: is_aborted(): NO,
> > curr_gateway: 4799696, deleted: 0
> > [    445459] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
> > (table 68): No such process
> > [    445466] Error - can't delete tun device: Inappropriate ioctl for
> > device [    456306] using default tunnel to GW 5.252.88.99 (gw_flags:
> 49,
> > packet_count: 370, gw_product: 87616)
> > [    456310] add_default_route()...
> > [    456318] client_to_gw_tun() started...
> > [    456352] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> >       .........................  59 times the same message
> > .........................
> > [    521513] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> > [    521714] Gateway client - disconnecting from unresponsive gateway
> > (5.252.88.99) !
> > [    521715] Gateway client - Maximum number of tunnel ip requests send !
> > [    521715] Gateway client - Ignoring this GW for 40 secs
> > [    521716] terminating client_to_gw_tun thread: is_aborted(): NO,
> > curr_gateway: 4799696, deleted: 0
> > [    521719] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
> > (table 68): No such process
> > [    521726] Error - can't delete tun device: Inappropriate ioctl for
> > device [    561963] using default tunnel to GW 5.252.88.99 (gw_flags:
> 49,
> > packet_count: 890, gw_product: 506944)
> > [    561964] add_default_route()...
> > [    561973] client_to_gw_tun() started...
> > [    561974] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> >       .........................  60 times the same message
> > .........................
> > [    627583] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> > [    627784] Gateway client - disconnecting from unresponsive gateway
> > (5.252.88.99) !
> > [    627785] Gateway client - Maximum number of tunnel ip requests send !
> > [    627785] Gateway client - Ignoring this GW for 90 secs
> > [    627786] terminating client_to_gw_tun thread: is_aborted(): NO,
> > curr_gateway: 4799696, deleted: 0
> > [    627790] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
> > (table 68): No such process
> > [    627796] Error - can't delete tun device: Inappropriate ioctl for
> > device [    717783] using default tunnel to GW 5.252.88.99 (gw_flags:
> 49,
> > packet_count: 990, gw_product: 627264)
> > [    717784] add_default_route()...
> > [    717792] client_to_gw_tun() started...
> > [    717793] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> >       .........................  59 times the same message
> > .........................
> > [    782623] send ip request to gateway: 5.252.88.99, preferred IP:
> 0.0.0.0
> > [    782824] Gateway client - disconnecting from unresponsive gateway
> > (5.252.88.99) !
> > [    782825] Gateway client - Maximum number of tunnel ip requests send !
> > [    782825] Gateway client - Ignoring this GW for 160 secs
> > [    782826] terminating client_to_gw_tun thread: is_aborted(): NO,
> > curr_gateway: 4799696, deleted: 0
> > [    782830] Error - can't delete route to 0.0.0.0/0 via 0.0.0.0
> > (table 68): No such process
> > [    782836] Error - can't delete tun device: Inappropriate ioctl for
> > device
> >
> > And it will go on like this, again and again, after the ignoring time
> > passes.
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

------=_Part_5209_12528683.1225375720357
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">2008/10/29 Axel Neumann <span dir="ltr">&lt;<a href="mailto:axel@open-mesh.net">axel@open-mesh.net</a>&gt;</span><br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Hey Julio,<br>
<br>
actually I am a bit clueless. Today I came back to Berlin, where I could test<br>
on Foneros MIPS devices (I suspected the endian type to be related to the<br>
problem but it also works very smoothly there. I tried with rv1146 on gw and<br>
client and with exactly the same parameter which you used. For me it looks<br>
like the handshake messages send by the client do not even end up at the bmxd<br>
running in the gw-node.<br>
<br>
In rv1147 i fixed some more misdirected debug-messages send by the tunnel<br>
thread (but I doubt this was the reason for the problem) and I put another<br>
debug message in the tunnel thread which should log invalid tunnel messages<br>
to debug-level 0 and 3. Have a look also on what printed to debug-level 0 /<br>
logread. &nbsp;If this doesnt show anything useful and if you are able to &nbsp;compile<br>
the binaries on your own, you may uncomment lines 1179 and 1180 in<br>
posix/tunnel.c which should cause the tunnel thread to log all incoming<br>
message on its dedicated port.<br>
<br>
If you send the output of<br>
ip a<br>
ip rule<br>
iptables -t nat -L -nv<br>
iptables -L -nv<br>
<br>
I would also have a look on that.<br>
<br>
Some more comments inline...<br>
<div class="Ih2E3d"><br>
On Mittwoch 29 Oktober 2008, Julio Cesar Puigpinos wrote:<br>
&gt;<br>
&gt; Yes, it does set up bat0.<br>
&gt;<br>
&gt; &gt; The client should<br>
&gt; &gt; have set tun0 up after the handshake process (with -o 2000 -r 1<br>
&gt; &gt; approximately 200 seconds after startup)<br>
&gt;<br>
&gt; No, it didn&#39;t do it.<br>
<br>
</div>shit but makes sense, the client does only setit up after a succesfull<br>
handshake.<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; One message that I saw that sometimes appears, while using debug level<br>
&gt; 3 in both the client and the gw, was like this &quot;ERROR: rcvd dbgl msg<br>
&gt; via fd 10, len 0, error Success&quot;.<br>
<br>
</div>ok thats no problem, not really an error. Have to fix that. This message<br>
always appears when &quot;bmxd -c ...&quot; terminates after pulling for example<br>
on-the-fly debug-messages from the main daemon.<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; &gt; Note that usually I would suspect a firewall issue but this shuld be<br>
&gt; &gt; ruled out as you said you are working with the same setup that worked<br>
&gt; &gt; with rv1069.<br>
&gt;<br>
&gt; Right, it works well with rv1069. To test both revisions I just opkg<br>
&gt; remove, install and reboot each time.<br>
<br>
</div>Maybe the problem is related to something completely different. What about<br>
using<br>
<a href="http://downloads.open-mesh.net/batman/development/misc/batmand-exp_0.3-alpha-current_mips-kk-elf-32-msb-dynamic" target="_blank">http://downloads.open-mesh.net/batman/development/misc/batmand-exp_0.3-alpha-current_mips-kk-elf-32-msb-dynamic</a><br>

exchange current with rv1147/rv11 and dynamic with static to<br>
old reveisions can be found here:<br>
<a href="http://downloads.open-mesh.net/batman/development/misc/old/batmand-exp_0.3-alpha-rv1069_mips-kk-elf-32-msb-dynamic" target="_blank">http://downloads.open-mesh.net/batman/development/misc/old/batmand-exp_0.3-alpha-rv1069_mips-kk-elf-32-msb-dynamic</a></blockquote>
<div></div><div>Hi Alex, Gustavo.</div><div>These binaries were compiled on a kamikaze trunk ? &nbsp;Details?</div><div></div><div>TIA</div><div></div><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<br>
<br>
save it to /tmp/bmxd, dont forget chmod u+x /tmp/bmxd, maybe set a link<br>
from /usr/sbin/bmxd to /tmp/bmxd,... and just restart the daemon<br>
<br>
you can use &quot;bmxd -c --purge&quot; to shortcut the duplicate address detection<br>
timeout which you may have noticed. With -o 2000 this can be annoying.<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; This are 3 lines from the output (both client and gw showed the same,<br>
&gt; except the IP order):<br>
&gt; 00:12:23.353439 IP (tos 0x0, ttl 64, id 0, offset 0, flags [DF], proto<br>
&gt; UDP (17), length 35) 5.129.82.40.4306 &gt; 5.252.88.99.4306: UDP, length<br>
<br>
</div>looks good. Just misses the reply :-(<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; &gt; Just for testing you may try with one-way-tunnel at the client side to<br>
&gt; &gt; see if the bat0 interface is set up correctly. This tunneltype is<br>
&gt; &gt; stateless and therefore needs no handshake messages between client and gw<br>
&gt; &gt; node. A simple bmxd -c --one-way-tunnel=4<br>
&gt; &gt; assigned to the runnung client-daemon should at least show the bat0<br>
&gt; &gt; interface (now configured with a 5.255.22.x IP instead of a 169.254.1.x<br>
&gt; &gt; ip) at the client. But for really using it you may need to modify your<br>
&gt; &gt; iptables settings.<br>
&gt;<br>
&gt; Using that, debug level 3 shows:<br>
&gt; [ &nbsp; &nbsp;200363] using default tunnel to GW <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> (gw_flags: 49,<br>
&gt; packet_count: 960, gw_product: 589824)<br>
&gt; [ &nbsp; &nbsp;200364] add_default_route()...<br>
&gt; [ &nbsp; &nbsp;200413] client_to_gw_tun() started...<br>
&gt; [ &nbsp; &nbsp;200417] Tried to name tunnel to bat0 ... success<br>
&gt; [ &nbsp; &nbsp;200421] select() indicated changed interface status! Going to<br>
&gt; check interfaces!<br>
&gt; [ &nbsp; &nbsp;200423] researching min. MTU, so fare: 1500, current dev ath2, mtu:<br>
&gt; 1500 [ &nbsp; &nbsp;200423] select() indicated changed interface status! Going to<br>
&gt; check interfaces!<br>
<br>
&gt;<br>
</div><div class="Ih2E3d">&gt; And the bat0 shows up like this:<br>
&gt; bat0 &nbsp; &nbsp; &nbsp;Link encap:UNSPEC &nbsp;HWaddr<br>
&gt; 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet addr:<a href="http://5.129.82.40" target="_blank">5.129.82.40</a> &nbsp;P-t-P:<a href="http://5.129.82.40" target="_blank">5.129.82.40</a> &nbsp;Mask:<a href="http://255.255.255.255" target="_blank">255.255.255.255</a><br>

&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP POINTOPOINT RUNNING NOARP MULTICAST &nbsp;MTU:1471 &nbsp;Metric:1<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TX packets:282 errors:0 dropped:0 overruns:0 carrier:0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; collisions:0 txqueuelen:500<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:0 (0.0 B) &nbsp;TX bytes:20776 (20.2 KiB)<br>
<br>
</div>also looks good.<br>
<div><div class="Wj3C7c"><br>
<br>
&gt;<br>
&gt; &gt; happy testing,<br>
&gt; &gt; axel<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Altogether debuglevel3 should look like this (on the gw-client side):<br>
&gt; &gt; root@248:~# bmxd -cd3<br>
&gt; &gt; [...]<br>
&gt;<br>
&gt; In mi case, this doesn&#39;t happens. It just keeps requesting an IP, then<br>
&gt; gives up for some seconds and tries again and again.<br>
&gt;<br>
&gt; &gt; On the gw-side it should look like:<br>
&gt; &gt; neumann@smart:/usr/src/batman-svn/trunk/batman-experimental$ sudo<br>
&gt; &gt; ./batmand -o 2000 -g 5000 -d 3 eth0:bmx [...]<br>
&gt; &gt; [ &nbsp; &nbsp; &nbsp;2782] change route to <a href="http://103.130.30.248" target="_blank">103.130.30.248</a> &nbsp;via <a href="http://103.130.30.248" target="_blank">103.130.30.248</a> &nbsp; &nbsp;1 /<br>
&gt; &gt; 100 (prev. via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0) [ &nbsp; &nbsp;181474] Gateway - assigned<br>
&gt; &gt; <a href="http://169.254.1.245" target="_blank">169.254.1.245</a> to client: <a href="http://103.130.30.248" target="_blank">103.130.30.248</a><br>
&gt;<br>
&gt; In my case it didn&#39;t asign an IP to the client.<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Saludos, Julio<br>
&gt;<br>
&gt;<br>
&gt; ++++ Logs taked from the gw ++++<br>
&gt; *Debug level 8<br>
&gt; BatMan-eXp 0.3-alpha, IF ath2 <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, LinkWindowSize 100,<br>
&gt; PathWindSize 100, OGI 2000ms, currSeqno 22461, UT 0:00:36:09, CPU<br>
&gt; 1/1000, IntTime &nbsp; &nbsp;2169739<br>
&gt; Neighbor &nbsp; &nbsp; &nbsp; &nbsp;outgoingIF &nbsp; &nbsp; bestNextHop brc (~rcvd &nbsp;knownSince<br>
&gt; lseq lvld rid nid ) [ &nbsp; &nbsp; viaIF RTQ &nbsp;RQ &nbsp;TQ]..<br>
&gt; <a href="http://5.129.82.40" target="_blank">5.129.82.40</a> &nbsp; &nbsp; ath2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://5.129.82.40" target="_blank">5.129.82.40</a> 100 ( &nbsp; 99 &nbsp;0:00:10:00<br>
&gt; 44589 &nbsp; &nbsp;1 &nbsp; 1 &nbsp; 1 ) [ &nbsp; &nbsp; &nbsp;ath2 100 100 100]<br>
&gt;<br>
&gt; Originator &nbsp; &nbsp; &nbsp;outgoingIF &nbsp; &nbsp; bestNextHop brc (~rcvd &nbsp;knownSince<br>
&gt; lseq lvld pws &nbsp;ogi cpu hop change ) alternativeNextHops brc ...<br>
&gt; <a href="http://5.129.82.40" target="_blank">5.129.82.40</a> &nbsp; &nbsp; ath2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://5.129.82.40" target="_blank">5.129.82.40</a> 100 ( &nbsp; 99 &nbsp;0:00:10:00<br>
&gt; 44589 &nbsp; &nbsp;1 100 2014 &nbsp; 5 &nbsp; 1 &nbsp; &nbsp; &nbsp;1 )<br>
&gt; &nbsp; &nbsp;1 known Originator(s), averages: &nbsp; &nbsp; &nbsp; &nbsp;100 ( &nbsp; 99<br>
&gt; &nbsp; &nbsp; 1 100 2014 &nbsp; 5 &nbsp; 1 &nbsp; &nbsp; &nbsp;1 )<br>
&gt;<br>
&gt; *Debug level 3<br>
&gt; BatMan-eXp 0.3-alpha (compatibility version 10) !<br>
&gt;<br>
&gt; gateway class: 49 -&gt; propagating: 4MBit/1024KBit<br>
&gt;<br>
&gt; Startup parameters: bmxd -o 2000 -g 5000 -d 3 ath2<br>
&gt;<br>
&gt; &nbsp; &nbsp;duplicate-address-detection timeout 100s, purge timeout 2525s,<br>
&gt; originator interval 2000ms, window size 100<br>
&gt;<br>
&gt; searching min. MTU, so fare: 1500, current dev ath2, mtu: 1500<br>
&gt;<br>
&gt; detected wireless interface ath2 &nbsp;(use ath2 /l to correct this assumption)<br>
&gt;<br>
&gt; changing /proc/sys/net/ipv4/conf/ath2/send_redirects from 1 to 0<br>
&gt;<br>
&gt; activated interface ath2 <a href="http://5.252.88.99/8" target="_blank">5.252.88.99/8</a> broadcast address <a href="http://5.255.255.255" target="_blank">5.255.255.255</a><br>
&gt;<br>
&gt; add rule from <a href="http://0.0.0.0/0" target="_blank">0.0.0.0/0</a>, table 64, prio 6500, if (null), type 1<br>
&gt;<br>
&gt; add rule from <a href="http://0.0.0.0/0" target="_blank">0.0.0.0/0</a>, table 66, prio 6600, if (null), type 1<br>
&gt;<br>
&gt; add rule from <a href="http://0.0.0.0/0" target="_blank">0.0.0.0/0</a>, table 65, prio 6699, if (null), type 1<br>
&gt;<br>
&gt; add route to <a href="http://127.0.0.0" target="_blank">127.0.0.0</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> src <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> dev lo, table 65, type 1<br>
&gt;<br>
&gt; add route to <a href="http://10.0.0.0" target="_blank">10.0.0.0</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> src <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> dev eth0, table 65, type 1<br>
&gt;<br>
&gt; add route to <a href="http://10.88.99.0" target="_blank">10.88.99.0</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> src <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> dev ath0, table 65, type 1<br>

&gt;<br>
&gt; add route to <a href="http://10.88.99.128" target="_blank">10.88.99.128</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> src <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> dev ath1, table 65, type<br>

&gt; 1<br>
&gt;<br>
&gt; start_gw_service ()<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 124] changing /proc/sys/net/ipv4/conf/all/send_redirects from 1 to<br>
&gt; 0<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 132] changing /proc/sys/net/ipv4/conf/default/send_redirects<br>
&gt; from 1 to 0<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 139] gw_listen() started...<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 139] gw_listen(): my_tun_ip <a href="http://169.254.0.0" target="_blank">169.254.0.0</a>, my_tun_netmask:<br>
&gt; <a href="http://255.255.252.0" target="_blank">255.255.252.0</a><br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 140] Tried to name tunnel to bat0 ... success<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 140] select() indicated changed interface status! Going to<br>
&gt; check interfaces!<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 141] researching min. MTU, so fare: 1500, current dev ath2, mtu:<br>
&gt; 1500<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 142] select() indicated changed interface status! Going to<br>
&gt; check interfaces!<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 142] researching min. MTU, so fare: 1500, current dev ath2, mtu:<br>
&gt; 1500<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 143] select() indicated changed interface status! Going to<br>
&gt; check interfaces!<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 144] researching min. MTU, so fare: 1500, current dev ath2, mtu:<br>
&gt; 1500<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 165] select() indicated changed interface status! Going to<br>
&gt; check interfaces!<br>
&gt;<br>
&gt; [ &nbsp; &nbsp; &nbsp; 166] researching min. MTU, so fare: 1500, current dev ath2, mtu:<br>
&gt; 1500<br>
&gt;<br>
&gt; [ &nbsp; 15710] change route to <a href="http://5.129.82.40" target="_blank">5.129.82.40</a> &nbsp; &nbsp; via <a href="http://5.129.82.40" target="_blank">5.129.82.40</a> &nbsp; &nbsp; &nbsp; 1 /<br>
&gt; 100 (prev. Via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0)<br>
&gt;<br>
&gt; *bat0 shows up like this<br>
&gt; bat0 &nbsp; &nbsp; &nbsp;Link encap:UNSPEC &nbsp;HWaddr<br>
&gt; 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; inet addr:<a href="http://169.254.0.0" target="_blank">169.254.0.0</a> &nbsp;P-t-P:<a href="http://169.254.0.0" target="_blank">169.254.0.0</a> &nbsp;Mask:<a href="http://255.255.255.255" target="_blank">255.255.255.255</a><br>

&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; UP POINTOPOINT RUNNING NOARP MULTICAST &nbsp;MTU:1471 &nbsp;Metric:1<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX packets:0 errors:0 dropped:0 overruns:0 frame:0<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TX packets:0 errors:0 dropped:0 overruns:0 carrier:0<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; collisions:0 txqueuelen:500<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RX bytes:0 (0.0 B) &nbsp;TX bytes:0 (0.0 B)<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; ++++ Logs taked from the client ++++<br>
&gt; *Debug level 8<br>
&gt; BatMan-eXp 0.3-alpha, IF ath2 <a href="http://5.129.82.40" target="_blank">5.129.82.40</a>, LinkWindowSize 100,<br>
&gt; PathWindSize 100, OGI 2000ms, currSeqno 7055, UT 0:00:13:13, CPU<br>
&gt; 3/1000, IntTime &nbsp; &nbsp; 793302<br>
&gt; Neighbor &nbsp; &nbsp; &nbsp; &nbsp;outgoingIF &nbsp; &nbsp; bestNextHop brc (~rcvd &nbsp;knownSince<br>
&gt; lseq lvld rid nid ) [ &nbsp; &nbsp; viaIF RTQ &nbsp;RQ &nbsp;TQ]..<br>
&gt; <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> &nbsp; &nbsp; ath2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> 100 ( &nbsp; 99 &nbsp;0:00:06:56<br>
&gt; 21584 &nbsp; &nbsp;1 &nbsp; 1 &nbsp; 1 ) [ &nbsp; &nbsp; &nbsp;ath2 100 100 100]<br>
&gt;<br>
&gt; Originator &nbsp; &nbsp; &nbsp;outgoingIF &nbsp; &nbsp; bestNextHop brc (~rcvd &nbsp;knownSince<br>
&gt; lseq lvld pws &nbsp;ogi cpu hop change ) alternativeNextHops brc ...<br>
&gt; <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> &nbsp; &nbsp; ath2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> 100 ( &nbsp; 99 &nbsp;0:00:06:56<br>
&gt; 21584 &nbsp; &nbsp;1 100 1998 &nbsp; 1 &nbsp; 1 &nbsp; &nbsp; &nbsp;1 )<br>
&gt; &nbsp; &nbsp;1 known Originator(s), averages: &nbsp; &nbsp; &nbsp; &nbsp;100 ( &nbsp; 99<br>
&gt; &nbsp; &nbsp; 1 100 1998 &nbsp; 1 &nbsp; 1 &nbsp; &nbsp; &nbsp;1 )<br>
&gt;<br>
&gt;<br>
&gt; *Debug level 3<br>
&gt; [ &nbsp; &nbsp;379294] change route to <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> &nbsp; &nbsp; via <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> &nbsp; &nbsp; &nbsp; 1 /<br>
&gt; 100 (prev. via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0)<br>
&gt; [ &nbsp; &nbsp;379299] found new gateway <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, announced by <a href="http://5.252.88.99" target="_blank">5.252.88.99</a><br>
&gt; -&gt; class: 49 - 4MBit/1024KBit, new supported tunnel types TWT, OWT<br>
&gt; [ &nbsp; &nbsp;380363] using default tunnel to GW <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> (gw_flags: 49,<br>
&gt; packet_count: 10, gw_product: 64)<br>
&gt; [ &nbsp; &nbsp;380364] add_default_route()...<br>
&gt; [ &nbsp; &nbsp;380375] client_to_gw_tun() started...<br>
&gt; [ &nbsp; &nbsp;380375] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; &nbsp; &nbsp; &nbsp; ......................... &nbsp;20 times the same message<br>
&gt; .........................<br>
&gt; [ &nbsp; &nbsp;403643] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; [ &nbsp; &nbsp;404634] ERROR: rcvd dbgl msg via fd 15, len 0, error Success<br>
&gt; [ &nbsp; &nbsp;404643] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;......................... &nbsp;37 times the same message<br>
&gt; .........................<br>
&gt; [ &nbsp; &nbsp;445253] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; [ &nbsp; &nbsp;445454] Gateway client - disconnecting from unresponsive gateway<br>
&gt; (<a href="http://5.252.88.99" target="_blank">5.252.88.99</a>) !<br>
&gt; [ &nbsp; &nbsp;445455] Gateway client - Maximum number of tunnel ip requests send !<br>
&gt; [ &nbsp; &nbsp;445455] Gateway client - Ignoring this GW for 10 secs<br>
&gt; [ &nbsp; &nbsp;445456] terminating client_to_gw_tun thread: is_aborted(): NO,<br>
&gt; curr_gateway: 4799696, deleted: 0<br>
&gt; [ &nbsp; &nbsp;445459] Error - can&#39;t delete route to <a href="http://0.0.0.0/0" target="_blank">0.0.0.0/0</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; (table 68): No such process<br>
&gt; [ &nbsp; &nbsp;445466] Error - can&#39;t delete tun device: Inappropriate ioctl for<br>
&gt; device [ &nbsp; &nbsp;456306] using default tunnel to GW <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> (gw_flags: 49,<br>
&gt; packet_count: 370, gw_product: 87616)<br>
&gt; [ &nbsp; &nbsp;456310] add_default_route()...<br>
&gt; [ &nbsp; &nbsp;456318] client_to_gw_tun() started...<br>
&gt; [ &nbsp; &nbsp;456352] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; &nbsp; &nbsp; &nbsp; ......................... &nbsp;59 times the same message<br>
&gt; .........................<br>
&gt; [ &nbsp; &nbsp;521513] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; [ &nbsp; &nbsp;521714] Gateway client - disconnecting from unresponsive gateway<br>
&gt; (<a href="http://5.252.88.99" target="_blank">5.252.88.99</a>) !<br>
&gt; [ &nbsp; &nbsp;521715] Gateway client - Maximum number of tunnel ip requests send !<br>
&gt; [ &nbsp; &nbsp;521715] Gateway client - Ignoring this GW for 40 secs<br>
&gt; [ &nbsp; &nbsp;521716] terminating client_to_gw_tun thread: is_aborted(): NO,<br>
&gt; curr_gateway: 4799696, deleted: 0<br>
&gt; [ &nbsp; &nbsp;521719] Error - can&#39;t delete route to <a href="http://0.0.0.0/0" target="_blank">0.0.0.0/0</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; (table 68): No such process<br>
&gt; [ &nbsp; &nbsp;521726] Error - can&#39;t delete tun device: Inappropriate ioctl for<br>
&gt; device [ &nbsp; &nbsp;561963] using default tunnel to GW <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> (gw_flags: 49,<br>
&gt; packet_count: 890, gw_product: 506944)<br>
&gt; [ &nbsp; &nbsp;561964] add_default_route()...<br>
&gt; [ &nbsp; &nbsp;561973] client_to_gw_tun() started...<br>
&gt; [ &nbsp; &nbsp;561974] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; &nbsp; &nbsp; &nbsp; ......................... &nbsp;60 times the same message<br>
&gt; .........................<br>
&gt; [ &nbsp; &nbsp;627583] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; [ &nbsp; &nbsp;627784] Gateway client - disconnecting from unresponsive gateway<br>
&gt; (<a href="http://5.252.88.99" target="_blank">5.252.88.99</a>) !<br>
&gt; [ &nbsp; &nbsp;627785] Gateway client - Maximum number of tunnel ip requests send !<br>
&gt; [ &nbsp; &nbsp;627785] Gateway client - Ignoring this GW for 90 secs<br>
&gt; [ &nbsp; &nbsp;627786] terminating client_to_gw_tun thread: is_aborted(): NO,<br>
&gt; curr_gateway: 4799696, deleted: 0<br>
&gt; [ &nbsp; &nbsp;627790] Error - can&#39;t delete route to <a href="http://0.0.0.0/0" target="_blank">0.0.0.0/0</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; (table 68): No such process<br>
&gt; [ &nbsp; &nbsp;627796] Error - can&#39;t delete tun device: Inappropriate ioctl for<br>
&gt; device [ &nbsp; &nbsp;717783] using default tunnel to GW <a href="http://5.252.88.99" target="_blank">5.252.88.99</a> (gw_flags: 49,<br>
&gt; packet_count: 990, gw_product: 627264)<br>
&gt; [ &nbsp; &nbsp;717784] add_default_route()...<br>
&gt; [ &nbsp; &nbsp;717792] client_to_gw_tun() started...<br>
&gt; [ &nbsp; &nbsp;717793] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; &nbsp; &nbsp; &nbsp; ......................... &nbsp;59 times the same message<br>
&gt; .........................<br>
&gt; [ &nbsp; &nbsp;782623] send ip request to gateway: <a href="http://5.252.88.99" target="_blank">5.252.88.99</a>, preferred IP: <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; [ &nbsp; &nbsp;782824] Gateway client - disconnecting from unresponsive gateway<br>
&gt; (<a href="http://5.252.88.99" target="_blank">5.252.88.99</a>) !<br>
&gt; [ &nbsp; &nbsp;782825] Gateway client - Maximum number of tunnel ip requests send !<br>
&gt; [ &nbsp; &nbsp;782825] Gateway client - Ignoring this GW for 160 secs<br>
&gt; [ &nbsp; &nbsp;782826] terminating client_to_gw_tun thread: is_aborted(): NO,<br>
&gt; curr_gateway: 4799696, deleted: 0<br>
&gt; [ &nbsp; &nbsp;782830] Error - can&#39;t delete route to <a href="http://0.0.0.0/0" target="_blank">0.0.0.0/0</a> via <a href="http://0.0.0.0" target="_blank">0.0.0.0</a><br>
&gt; (table 68): No such process<br>
&gt; [ &nbsp; &nbsp;782836] Error - can&#39;t delete tun device: Inappropriate ioctl for<br>
&gt; device<br>
&gt;<br>
&gt; And it will go on like this, again and again, after the ignoring time<br>
&gt; passes.<br>
<br>
<br>
</div></div><div><div class="Wj3C7c">_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br>
<a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div><br>

------=_Part_5209_12528683.1225375720357--
