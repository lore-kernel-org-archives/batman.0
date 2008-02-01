Message-ID: <a934d3f30801312219s59d740bcr9b6a0597e8cc51d9@mail.gmail.com>
Date: Fri, 1 Feb 2008 01:19:39 -0500
From: "Vinay Menon" <vinaymenon@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Problems with 0.3-beta rv963 and kmod-batgat
In-Reply-To: <200801311608.18934.an.langer@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12232_27118938.1201846779635"
References: <a934d3f30801301420q261b6784l7ee60982076f6fdc@mail.gmail.com>
	<200801311608.18934.an.langer@gmx.de>
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

------=_Part_12232_27118938.1201846779635
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

sorry,i was hasty in posting its working now. the problem was at my end.
things working fine :)
thanks

On Jan 31, 2008 10:08 AM, Andreas Langer <an.langer@gmx.de> wrote:

> hi,
> i try to help....with batgat on the gateway please check the kernel
> log.....on
> the client side run batman with -d 3 and check if you get a virtual ip
> from
> the gateway, on a fresh restart it can be a delay until you get an ip.
>
>
> Am Mittwoch, 30. Januar 2008 23:20:44 schrieb Vinay Menon:
> > Hi,
> > I am testing out batman 0.3-beta rv963 with openwrt-trunk (r10219) .
> > I could get the expected results when i am using tun instead of
> kmod-batgat
> > .
> >
> > but when i use kmod-batgat even tho the tunnel gate0 is established  the
> > routing rules and firewall is same as with kmod-tun i cant get traffic
> thru
> > gate0
> >
> > My Setup:
> >
> > ---- Wired
> > - - - - WiFi
> >
> >  192.168.111.1-----(WAN)-192.168.111.74(Gateway)10.1.125.158 - - - - - -
> > 10-1-125-158 (Node2)
> >
>
> your setup is :
>
> wan with 192.168.111.1
> gateway with 10.1.125.158, 192.168.111.74
> node with 10.1.125.158
>
> ???
>
> > *With kmod-batgat:*
> >
> > from
> > ping 192.168.111.1 -I gate0
> >
> > ##on gateway
> > root@10-1-125-158:~# lsmod |grep batgat
> > batgat                 10976  1
> >
> > ##Ping from Node
> > root@Node2:~# ping 192.168.111.1 -I gate0
> > PING 192.168.111.1 (192.168.111.1): 56 data bytes
> > --- 192.168.111.1 ping statistics ---
> > 46 packets transmitted, 0 packets received, 100% packet loss
> >
> >
> > ##tcpdump on node
> > root@10-1-125-158:~# tcpdump -i gate0 proto \\icmp
> > tcpdump: verbose output suppressed, use -v or -vv for full protocol
> decode
> > listening on gate0, link-type EN10MB (Ethernet), capture size 96 bytes
> >
> > 0 packets captured
> > 0 packets received by filter
> > 0 packets dropped by kernel
> >
> >
> >
> > *With kmod-tun:*
> > root@10-1-125-158:/# lsmod |grep tun
> > tun                     6592  1
> >
> > *##on Node*
> >
> > batman -cd2
> >      Gateway     (#/255)         Nexthop [outgoingIF], gw_class ... [
> > B.A.T.M.A.N. 0.3-beta rv963, MainIF/IP: ath0/10.1.124.248, UT: 0d 0h52m]
> > => 10.1.125.158    (255 + 0)    10.1.125.158 [      ath0], gw_class  49
> -
> > 4MBit/1024KBit, reliability: 0
> >
> >
> > *##Ping from Node*
> > root@Node2:~# ping 192.168.111.1
> > PING 192.168.111.1 (192.168.111.1): 56 data bytes
> > 64 bytes from 192.168.111.1: seq=0 ttl=63 time=8.473 ms
> > 64 bytes from 192.168.111.1: seq=1 ttl=63 time=6.585 ms
> >
> >
> > *##tcpDump on gateway's gate0*
> >
> > root@10-1-125-158:/# tcpdump -i gate0 proto \\icmp
> > tcpdump: WARNING: arptype 65534 not supported by libpcap - falling back
> to
> > cooked socket
> > tcpdump: verbose output suppressed, use -v or -vv for full protocol
> decode
> > listening on gate0, link-type LINUX_SLL (Linux cooked), capture size 96
> > bytes
> > 00:50:45.798376 IP 169.254.0.1 > 192.168.111.1: ICMP echo request, id
> 1004,
> > seq 0, length 64
> > 00:50:46.614360 IP 192.168.111.1 > 169.254.0.1: ICMP echo reply, id
> 1004,
> > seq 0, length 64
> > 00:50:46.805310 IP 169.254.0.1 > 192.168.111.1: ICMP echo request, id
> 1004,
> > seq 1, length 64
> > 00:50:46.806369 IP 192.168.111.1 > 169.254.0.1: ICMP echo reply, id
> 1004,
> > seq 1, length 64
> >
> > *##tcpDump on gateway's eth0*
> > root@10-1-125-158:/# tcpdump -i eth0 proto \\icmp
> > tcpdump: verbose output suppressed, use -v or -vv for full protocol
> decode
> > listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
> > 00:48:29.108148 IP 192.168.111.74 > 192.168.111.1: ICMP echo request, id
> > 1003, seq 6, length 64
> > 00:48:29.145367 IP 192.168.111.1 > 192.168.111.74: ICMP echo reply, id
> > 1003, seq 6, length 64
> >
> >
> > Also at times  ip rules dont appear on node and i have to restart
> batmand
> > to get the network working.
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>



-- 
Vinay Menon

------=_Part_12232_27118938.1201846779635
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

sorry,i was hasty in posting its working now. the problem was at my end.<br>things working fine :)<br>thanks<br><br><div class="gmail_quote">On Jan 31, 2008 10:08 AM, Andreas Langer &lt;<a href="mailto:an.langer@gmx.de">an.langer@gmx.de</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">hi,<br>i try to help....with batgat on the gateway please check the kernel log.....on<br>the client side run batman with -d 3 and check if you get a virtual ip from<br>
the gateway, on a fresh restart it can be a delay until you get an ip.<br><br><br>Am Mittwoch, 30. Januar 2008 23:20:44 schrieb Vinay Menon:<br><div class="Ih2E3d">&gt; Hi,<br>&gt; I am testing out batman 0.3-beta rv963 with openwrt-trunk (r10219) .<br>
&gt; I could get the expected results when i am using tun instead of kmod-batgat<br>&gt; .<br>&gt;<br>&gt; but when i use kmod-batgat even tho the tunnel gate0 is established &nbsp;the<br>&gt; routing rules and firewall is same as with kmod-tun i cant get traffic thru<br>
&gt; gate0<br>&gt;<br>&gt; My Setup:<br>&gt;<br>&gt; ---- Wired<br>&gt; - - - - WiFi<br>&gt;<br>&gt; &nbsp;192.168.111.1-----(WAN)-192.168.111.74(Gateway)10.1.125.158 - - - - - -<br>&gt; 10-1-125-158 (Node2)<br>&gt;<br><br></div>
your setup is :<br><br>wan with <a href="http://192.168.111.1" target="_blank">192.168.111.1</a><br>gateway with <a href="http://10.1.125.158" target="_blank">10.1.125.158</a>, <a href="http://192.168.111.74" target="_blank">192.168.111.74</a><br>
node with <a href="http://10.1.125.158" target="_blank">10.1.125.158</a><br><br>???<br><br>&gt; *With kmod-batgat:*<br><div><div></div><div class="Wj3C7c">&gt;<br>&gt; from<br>&gt; ping <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> -I gate0<br>
&gt;<br>&gt; ##on gateway<br>&gt; root@10-1-125-158:~# lsmod |grep batgat<br>&gt; batgat &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 10976 &nbsp;1<br>&gt;<br>&gt; ##Ping from Node<br>&gt; root@Node2:~# ping <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> -I gate0<br>
&gt; PING <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> (<a href="http://192.168.111.1" target="_blank">192.168.111.1</a>): 56 data bytes<br>&gt; --- <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> ping statistics ---<br>
&gt; 46 packets transmitted, 0 packets received, 100% packet loss<br>&gt;<br>&gt;<br>&gt; ##tcpdump on node<br>&gt; root@10-1-125-158:~# tcpdump -i gate0 proto \\icmp<br>&gt; tcpdump: verbose output suppressed, use -v or -vv for full protocol decode<br>
&gt; listening on gate0, link-type EN10MB (Ethernet), capture size 96 bytes<br>&gt;<br>&gt; 0 packets captured<br>&gt; 0 packets received by filter<br>&gt; 0 packets dropped by kernel<br>&gt;<br>&gt;<br>&gt;<br>&gt; *With kmod-tun:*<br>
&gt; root@10-1-125-158:/# lsmod |grep tun<br>&gt; tun &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 6592 &nbsp;1<br>&gt;<br>&gt; *##on Node*<br>&gt;<br>&gt; batman -cd2<br>&gt; &nbsp; &nbsp; &nbsp;Gateway &nbsp; &nbsp; (#/255) &nbsp; &nbsp; &nbsp; &nbsp; Nexthop [outgoingIF], gw_class ... [<br>&gt; B.A.T.M.A.N. 0.3-beta rv963, MainIF/IP: ath0/10.1.124.248, UT: 0d 0h52m]<br>
&gt; =&gt; <a href="http://10.1.125.158" target="_blank">10.1.125.158</a> &nbsp; &nbsp;(255 + 0) &nbsp; &nbsp;<a href="http://10.1.125.158" target="_blank">10.1.125.158</a> [ &nbsp; &nbsp; &nbsp;ath0], gw_class &nbsp;49 -<br>&gt; 4MBit/1024KBit, reliability: 0<br>
&gt;<br>&gt;<br>&gt; *##Ping from Node*<br>&gt; root@Node2:~# ping <a href="http://192.168.111.1" target="_blank">192.168.111.1</a><br>&gt; PING <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> (<a href="http://192.168.111.1" target="_blank">192.168.111.1</a>): 56 data bytes<br>
&gt; 64 bytes from <a href="http://192.168.111.1" target="_blank">192.168.111.1</a>: seq=0 ttl=63 time=8.473 ms<br>&gt; 64 bytes from <a href="http://192.168.111.1" target="_blank">192.168.111.1</a>: seq=1 ttl=63 time=6.585 ms<br>
&gt;<br>&gt;<br>&gt; *##tcpDump on gateway&#39;s gate0*<br>&gt;<br>&gt; root@10-1-125-158:/# tcpdump -i gate0 proto \\icmp<br>&gt; tcpdump: WARNING: arptype 65534 not supported by libpcap - falling back to<br>&gt; cooked socket<br>
&gt; tcpdump: verbose output suppressed, use -v or -vv for full protocol decode<br>&gt; listening on gate0, link-type LINUX_SLL (Linux cooked), capture size 96<br>&gt; bytes<br>&gt; 00:50:45.798376 IP <a href="http://169.254.0.1" target="_blank">169.254.0.1</a> &gt; <a href="http://192.168.111.1" target="_blank">192.168.111.1</a>: ICMP echo request, id 1004,<br>
&gt; seq 0, length 64<br>&gt; 00:50:46.614360 IP <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> &gt; <a href="http://169.254.0.1" target="_blank">169.254.0.1</a>: ICMP echo reply, id 1004,<br>&gt; seq 0, length 64<br>
&gt; 00:50:46.805310 IP <a href="http://169.254.0.1" target="_blank">169.254.0.1</a> &gt; <a href="http://192.168.111.1" target="_blank">192.168.111.1</a>: ICMP echo request, id 1004,<br>&gt; seq 1, length 64<br>&gt; 00:50:46.806369 IP <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> &gt; <a href="http://169.254.0.1" target="_blank">169.254.0.1</a>: ICMP echo reply, id 1004,<br>
&gt; seq 1, length 64<br>&gt;<br>&gt; *##tcpDump on gateway&#39;s eth0*<br>&gt; root@10-1-125-158:/# tcpdump -i eth0 proto \\icmp<br>&gt; tcpdump: verbose output suppressed, use -v or -vv for full protocol decode<br>&gt; listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes<br>
&gt; 00:48:29.108148 IP <a href="http://192.168.111.74" target="_blank">192.168.111.74</a> &gt; <a href="http://192.168.111.1" target="_blank">192.168.111.1</a>: ICMP echo request, id<br>&gt; 1003, seq 6, length 64<br>&gt; 00:48:29.145367 IP <a href="http://192.168.111.1" target="_blank">192.168.111.1</a> &gt; <a href="http://192.168.111.74" target="_blank">192.168.111.74</a>: ICMP echo reply, id<br>
&gt; 1003, seq 6, length 64<br>&gt;<br>&gt;<br>&gt; Also at times &nbsp;ip rules dont appear on node and i have to restart batmand<br>&gt; to get the network working.<br><br><br></div></div>_______________________________________________<br>
B.A.T.M.A.N mailing list<br><a href="mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br><a href="https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target="_blank">https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</blockquote></div><br><br clear="all"><br>-- <br>Vinay Menon

------=_Part_12232_27118938.1201846779635--
