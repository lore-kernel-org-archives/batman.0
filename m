Message-ID: <a934d3f30801301420q261b6784l7ee60982076f6fdc@mail.gmail.com>
Date: Wed, 30 Jan 2008 17:20:44 -0500
From: "Vinay Menon" <vinaymenon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9722_8932642.1201731644277"
Subject: [B.A.T.M.A.N.] Problems with 0.3-beta rv963 and kmod-batgat
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

------=_Part_9722_8932642.1201731644277
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I am testing out batman 0.3-beta rv963 with openwrt-trunk (r10219) .
I could get the expected results when i am using tun instead of kmod-batgat
.

but when i use kmod-batgat even tho the tunnel gate0 is established  the
routing rules and firewall is same as with kmod-tun i cant get traffic thru
gate0

My Setup:

---- Wired
- - - - WiFi

 192.168.111.1-----(WAN)-192.168.111.74(Gateway)10.1.125.158 - - - - - -
10-1-125-158 (Node2)

*With kmod-batgat:*

from
ping 192.168.111.1 -I gate0

##on gateway
root@10-1-125-158:~# lsmod |grep batgat
batgat                 10976  1

##Ping from Node
root@Node2:~# ping 192.168.111.1 -I gate0
PING 192.168.111.1 (192.168.111.1): 56 data bytes
--- 192.168.111.1 ping statistics ---
46 packets transmitted, 0 packets received, 100% packet loss


##tcpdump on node
root@10-1-125-158:~# tcpdump -i gate0 proto \\icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on gate0, link-type EN10MB (Ethernet), capture size 96 bytes

0 packets captured
0 packets received by filter
0 packets dropped by kernel



*With kmod-tun:*
root@10-1-125-158:/# lsmod |grep tun
tun                     6592  1

*##on Node*

batman -cd2
     Gateway     (#/255)         Nexthop [outgoingIF], gw_class ... [
B.A.T.M.A.N. 0.3-beta rv963, MainIF/IP: ath0/10.1.124.248, UT: 0d 0h52m]
=> 10.1.125.158    (255 + 0)    10.1.125.158 [      ath0], gw_class  49 -
4MBit/1024KBit, reliability: 0


*##Ping from Node*
root@Node2:~# ping 192.168.111.1
PING 192.168.111.1 (192.168.111.1): 56 data bytes
64 bytes from 192.168.111.1: seq=0 ttl=63 time=8.473 ms
64 bytes from 192.168.111.1: seq=1 ttl=63 time=6.585 ms


*##tcpDump on gateway's gate0*

root@10-1-125-158:/# tcpdump -i gate0 proto \\icmp
tcpdump: WARNING: arptype 65534 not supported by libpcap - falling back to
cooked socket
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on gate0, link-type LINUX_SLL (Linux cooked), capture size 96
bytes
00:50:45.798376 IP 169.254.0.1 > 192.168.111.1: ICMP echo request, id 1004,
seq 0, length 64
00:50:46.614360 IP 192.168.111.1 > 169.254.0.1: ICMP echo reply, id 1004,
seq 0, length 64
00:50:46.805310 IP 169.254.0.1 > 192.168.111.1: ICMP echo request, id 1004,
seq 1, length 64
00:50:46.806369 IP 192.168.111.1 > 169.254.0.1: ICMP echo reply, id 1004,
seq 1, length 64

*##tcpDump on gateway's eth0*
root@10-1-125-158:/# tcpdump -i eth0 proto \\icmp
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
00:48:29.108148 IP 192.168.111.74 > 192.168.111.1: ICMP echo request, id
1003, seq 6, length 64
00:48:29.145367 IP 192.168.111.1 > 192.168.111.74: ICMP echo reply, id 1003,
seq 6, length 64


Also at times  ip rules dont appear on node and i have to restart batmand to
get the network working.

-- 
Vinay Menon

------=_Part_9722_8932642.1201731644277
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I am testing out batman 0.3-beta rv963 with openwrt-trunk (r10219) .<br>I could get the expected results when i am using tun instead of kmod-batgat .<br><br>but when i use kmod-batgat even tho the tunnel gate0 is established&nbsp; the <br>
routing rules and firewall is same as with kmod-tun i cant get traffic thru gate0<br><br>My Setup:<br><br>---- Wired<br>- - - - WiFi<br><br>&nbsp;192.168.111.1-----(WAN)-192.168.111.74(Gateway)10.1.125.158 - - - - - - 10-1-125-158 (Node2)<br>
<br><b>With kmod-batgat:</b><br><br>from<br>ping <a href="http://192.168.111.1">192.168.111.1</a> -I gate0 <br><br>##on gateway<br>root@10-1-125-158:~# lsmod |grep batgat<br>batgat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10976&nbsp; 1<br><br>##Ping from Node<br>
root@Node2:~# ping <a href="http://192.168.111.1">192.168.111.1</a> -I gate0<br>PING <a href="http://192.168.111.1">192.168.111.1</a> (<a href="http://192.168.111.1">192.168.111.1</a>): 56 data bytes<br>--- <a href="http://192.168.111.1">192.168.111.1</a> ping statistics ---<br>

46 packets transmitted, 0 packets received, 100% packet loss<br>
<br>&nbsp;<br>##tcpdump on node<br>root@10-1-125-158:~# tcpdump -i gate0 proto \\icmp<br>tcpdump: verbose output suppressed, use -v or -vv for full protocol decode<br>listening on gate0, link-type EN10MB (Ethernet), capture size 96 bytes<br>
<br>0 packets captured<br>0 packets received by filter<br>0 packets dropped by kernel<br><br><br><br><b>With kmod-tun:</b><br>root@10-1-125-158:/# lsmod |grep tun<br>tun&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6592&nbsp; 1<br><br><i>##on Node</i><br>
<br>batman -cd2<br>&nbsp;&nbsp;&nbsp;&nbsp; Gateway&nbsp;&nbsp;&nbsp;&nbsp; (#/255)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Nexthop [outgoingIF], gw_class ... [B.A.T.M.A.N. 0.3-beta rv963, MainIF/IP: ath0/10.1.124.248, UT: 0d 0h52m]<br>=&gt; <a href="http://10.1.125.158">10.1.125.158</a>&nbsp;&nbsp;&nbsp; (255 + 0)&nbsp;&nbsp;&nbsp; <a href="http://10.1.125.158">10.1.125.158</a> [&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ath0], gw_class&nbsp; 49 - 4MBit/1024KBit, reliability: 0<br>
<br><br><i>##Ping from Node</i><br>root@Node2:~# ping <a href="http://192.168.111.1">192.168.111.1</a><br>PING <a href="http://192.168.111.1">192.168.111.1</a> (<a href="http://192.168.111.1">192.168.111.1</a>): 56 data bytes<br>
64 bytes from <a href="http://192.168.111.1">192.168.111.1</a>: seq=0 ttl=63 time=8.473 ms<br>64 bytes from <a href="http://192.168.111.1">192.168.111.1</a>: seq=1 ttl=63 time=6.585 ms<br><br><br><i>##tcpDump on gateway&#39;s gate0</i><br>
&nbsp;  <br>root@10-1-125-158:/# tcpdump -i gate0 proto \\icmp<br>tcpdump: WARNING: arptype 65534 not supported by libpcap - falling back to cooked socket<br>tcpdump: verbose output suppressed, use -v or -vv for full protocol decode<br>
listening on gate0, link-type LINUX_SLL (Linux cooked), capture size 96 bytes<br>00:50:45.798376 IP <a href="http://169.254.0.1">169.254.0.1</a> &gt; <a href="http://192.168.111.1">192.168.111.1</a>: ICMP echo request, id 1004, seq 0, length 64<br>
00:50:46.614360 IP <a href="http://192.168.111.1">192.168.111.1</a> &gt; <a href="http://169.254.0.1">169.254.0.1</a>: ICMP echo reply, id 1004, seq 0, length 64<br>00:50:46.805310 IP <a href="http://169.254.0.1">169.254.0.1</a> &gt; <a href="http://192.168.111.1">192.168.111.1</a>: ICMP echo request, id 1004, seq 1, length 64<br>
00:50:46.806369 IP <a href="http://192.168.111.1">192.168.111.1</a> &gt; <a href="http://169.254.0.1">169.254.0.1</a>: ICMP echo reply, id 1004, seq 1, length 64<br><br><i>##tcpDump on gateway&#39;s eth0</i><br>root@10-1-125-158:/# tcpdump -i eth0 proto \\icmp<br>
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode<br>listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes<br>00:48:29.108148 IP <a href="http://192.168.111.74">192.168.111.74</a> &gt; <a href="http://192.168.111.1">192.168.111.1</a>: ICMP echo request, id 1003, seq 6, length 64<br>
00:48:29.145367 IP <a href="http://192.168.111.1">192.168.111.1</a> &gt; <a href="http://192.168.111.74">192.168.111.74</a>: ICMP echo reply, id 1003, seq 6, length 64<br><br><br>Also at times&nbsp; ip rules dont appear on node and i have to restart batmand to get the network working.<br>
<br>-- <br>Vinay Menon

------=_Part_9722_8932642.1201731644277--
