Return-Path: <tracer@robotech.de>
Message-ID: <4E5E6301.3050905@robotech.de>
Date: Wed, 31 Aug 2011 18:36:17 +0200
From: Tobias <tracer@robotech.de>
MIME-Version: 1.0
References: <4E5D69E3.30403@robotech.de>
In-Reply-To: <4E5D69E3.30403@robotech.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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

> Hi,
>
> >  At first everything seemed to work. A node on the one end could ping a
> >  node on the other end over the mesh-network. The ping was hopping from
> >  node to node as expected.
> >
> >  But sometimes some paths do not work anymore.
> >
> >  Some nodes can only reach their direct neighbors via a "normal ping". A
> >  ping to a node via one hop does not work. A "batctl ping" does work!
> >
> >  This only happens to parts of the network and is not permanent. If i
> >  wait it will recover, but then the problem appears at another node.
>
> since "batctl ping" works I'd say your mesh works fine - you have a problem in
> your higher layers. Maybe a mac address collision or an ARP timeout ?
>
> Can you provide specific examples we can go through ? For instance, provide
> the batctl ping output to the neighbor in question, the ping error message
> (does it say timeout / host could not be found / etc), a batctl traceroute to
> the neighbor in question and the output of the global translation table.
>
> Are you trying to ping a 'fixed' node or a node that is roaming ?
>
> Regards,
> Marek
>
Hello Marek,

thanks for you response. I'll try to give you an example - i'll cut out 
the parts that are not relevant (i hope).

First i have to correct the version - it seems to be 2011.3 - not 2011.2 
as the subject says.

root@fon-58:~# dmesg | grep "batman_adv"
batman_adv: B.A.T.M.A.N. advanced 2011.3.0 (compatibility version 14) loaded

The route from bat49 to bat58 is not working. It should hop via bat59.

root@1043-49:~# batctl o
[B.A.T.M.A.N. adv 2011.3.0, MainIF/MAC: wlan2/9e:0c:6d:ee:7c:ba (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
             bat58    3.080s   (168)             bat59 [     
wlan2]:             bat59 (168)             bat51 (  0)             
bat60 (127)
             bat59    3.130s   (202)             bat59 [     
wlan2]:             bat60 (155)             bat51 (134)             
bat59 (202)

root@fon-59:~# batctl o
[B.A.T.M.A.N. adv 2011.3.0, MainIF/MAC: wlan2/0a:18:84:80:87:9d (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
             bat58    4.740s   (210)             bat58 [     
wlan2]:             bat55 (  0)             bat51 (  0)             
bat49 (  0)             bat52 (  0)             bat67 (148)             
bat53 (120)             bat54 (191)             bat60 (170)             
bat58 (210)
             bat49    0.040s   (192)             bat49 [     
wlan2]:             bat52 ( 36)             bat55 (  0)             
bat67 (106)             bat58 (148)             bat54 (129)             
bat53 ( 80)             bat60 (152)             bat49 (192)             
bat51 (112)

root@fon-58:~# batctl o
[B.A.T.M.A.N. adv 2011.3.0, MainIF/MAC: wlan2/0a:18:84:81:a1:0d (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
             bat49    0.570s   (174)             bat59 [     
wlan2]:             bat51 (  4)             bat52 (  9)             
bat55 (  5)             bat54 (149)             bat53 (140)             
bat67 (156)             bat60 ( 95)             bat59 (174)             
bat49 (  0)
             bat59    0.990s   (245)             bat59 [     
wlan2]:             bat55 (  8)             bat51 (  3)             
bat52 (  8)             bat60 (137)             bat53 (186)             
bat67 (217)             bat54 (206)             bat59 (245)

ifconfigs:
root@1043-49:~# ifconfig bat0
bat0      Link encap:Ethernet  HWaddr 9E:90:FC:DC:99:09
           inet addr:192.168.111.49  Bcast:192.168.111.255  
Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:9410 errors:0 dropped:0 overruns:0 frame:0
           TX packets:64693 errors:0 dropped:2560 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:1622914 (1.5 MiB)  TX bytes:13322553 (12.7 MiB)
root@1043-49:~# ifconfig wlan2
wlan2     Link encap:Ethernet  HWaddr 9E:0C:6D:EE:7C:BA
           UP BROADCAST RUNNING MULTICAST  MTU:1528  Metric:1
           RX packets:84071 errors:0 dropped:78 overruns:0 frame:0
           TX packets:112446 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:6693056 (6.3 MiB)  TX bytes:20633620 (19.6 MiB)

root@fon-59:~# ifconfig bat0
bat0      Link encap:Ethernet  HWaddr D6:0F:24:F1:43:3C
           inet addr:192.168.111.59  Bcast:192.168.111.255  
Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:23493 errors:0 dropped:0 overruns:0 frame:0
           TX packets:5078 errors:0 dropped:8 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:4006301 (3.8 MiB)  TX bytes:726585 (709.5 KiB)
root@fon-59:~# ifconfig wlan2
wlan2     Link encap:Ethernet  HWaddr 0A:18:84:80:87:9D
           UP BROADCAST RUNNING MULTICAST  MTU:1528  Metric:1
           RX packets:298487 errors:0 dropped:748 overruns:0 frame:0
           TX packets:176654 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:18665398 (17.7 MiB)  TX bytes:14335354 (13.6 MiB)

root@fon-58:~# ifconfig bat0
bat0      Link encap:Ethernet  HWaddr C2:90:A3:3B:4E:C9
           inet addr:192.168.111.58  Bcast:192.168.111.255  
Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:23159 errors:0 dropped:0 overruns:0 frame:0
           TX packets:7759 errors:0 dropped:2298 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:1115758 (1.0 MiB)  TX bytes:737874 (720.5 KiB)
root@fon-58:~# ifconfig wlan2
wlan2     Link encap:Ethernet  HWaddr 0A:18:84:81:A1:0D
           UP BROADCAST RUNNING MULTICAST  MTU:1528  Metric:1
           RX packets:3475063 errors:0 dropped:1422 overruns:0 frame:0
           TX packets:1601622 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:154462355 (147.3 MiB)  TX bytes:100565468 (95.9 MiB)

this is working:
root@1043-49:~# batctl p bat59
PING bat59 (0a:18:84:80:87:9d) 20(48) bytes of data
20 bytes from bat59 icmp_seq=1 ttl=49 time=6.12 ms

and this:
root@1043-49:~# batctl p bat58
PING bat58 (0a:18:84:81:a1:0d) 20(48) bytes of data
20 bytes from bat58 icmp_seq=1 ttl=48 time=17.61 ms

and this too:
root@1043-49:~# ping 192.168.111.59
PING 192.168.111.59 (192.168.111.59): 56 data bytes
64 bytes from 192.168.111.59: seq=0 ttl=64 time=7.621 ms

this NOT:
root@1043-49:~# ping 192.168.111.58
PING 192.168.111.58 (192.168.111.58): 56 data bytes

the route seems ok:
root@1043-49:~# batctl tr bat58
traceroute to bat58 (0a:18:84:81:a1:0d), 50 hops max, 20 byte packets
  1: bat59 (0a:18:84:80:87:9d)  4.297 ms  31.777 ms  0.938 ms
  2: bat58 (0a:18:84:81:a1:0d)  7.868 ms  4.153 ms  3.352 ms

I see the pings going out on bat49
root@1043-49:~# batctl td wlan2 | grep "ICMP"
13:16:39.026715 BAT bat49 > bat58: UCAST, ttvn 1, ttl 50, IP 
192.168.111.49 > 192.168.111.58: ICMP echo request, id 9467, seq 16, 
length 64

i even see the packet come into bat58:
root@fon-58:~# batctl td wlan2 | grep "ICMP"
13:18:39.715935 BAT bat59 > bat58: UCAST, ttvn 1, ttl 48, IP 
192.168.111.49 > 192.168.111.58: ICMP echo request, id 9467, seq 159, 
length 64

but no reply.

in the bat0-interface i can see the reply:
root@fon-58:~# batctl td bat0 | grep "ICMP"
13:19:15.730081 IP 192.168.111.49 > 192.168.111.58: ICMP echo request, 
id 9467, seq 195, length 64
13:19:15.732864 IP 192.168.111.58 > 192.168.111.49: ICMP echo reply, id 
9467, seq 195, length 64

the arp-table of bat58 looks good:
root@fon-58:~# arp -a
IP address       HW type     Flags       HW address            Mask     
Device
192.168.111.49   0x1         0x2         9e:90:fc:dc:99:09     *        bat0

the other direction does not work either:
root@fon-58:~# ping 192.168.111.49
PING 192.168.111.49 (192.168.111.49): 56 data bytes

the packet go out on bat58 on the bat0 interface
root@fon-58:~# batctl td bat0 | grep "ICMP"
13:54:15.727222 IP 192.168.111.58 > 192.168.111.49: ICMP echo request, 
id 1961, seq 112, length 64

but it its *NOT* visible in the wlan-interface:
root@fon-58:~# batctl td wlan2 | grep "ICMP"

A ping from bat58 to bat59 works:
root@fon-58:~# ping 192.168.111.59
PING 192.168.111.59 (192.168.111.59): 56 data bytes
64 bytes from 192.168.111.59: seq=0 ttl=64 time=15.729 ms

and appears in both dumps:
root@fon-58:~# batctl td wlan2 | grep "ICMP"
14:00:50.522992 BAT bat58 > bat59: UCAST, ttvn 1, ttl 50, IP 
192.168.111.58 > 192.168.111.59: ICMP echo request, id 1997, seq 3, 
length 64
14:00:50.530158 BAT bat59 > bat58: UCAST, ttvn 1, ttl 50, IP 
192.168.111.59 > 192.168.111.58: ICMP echo reply, id 1997, seq 3, length 64

root@fon-58:~# batctl td bat0 | grep "ICMP"
14:01:05.563243 IP 192.168.111.58 > 192.168.111.59: ICMP echo request, 
id 1997, seq 18, length 64
14:01:05.567195 IP 192.168.111.59 > 192.168.111.58: ICMP echo reply, id 
1997, seq 18, length 64

Why is the ICMP-Ping from 58 to 49 not send on the wlan?

Does the "TX-dropped" count in ifconfig mean anything?

I dont't understand the "batctl tg". If i repeat the command it gives me 
different results:

root@fon-58:~# batctl tg |grep "49"
  * 04:11:80:f4:40:c8  (  1) via             bat49     (  1)
root@fon-58:~# batctl tg |grep "49"
  * 0c:6d:ee:7c:ba:01  (  1) via             bat49     (  1)
root@fon-58:~# batctl tg |grep "49"
  * 04:11:80:f4:40:c8  (  1) via             bat49     (  1)
root@fon-58:~# batctl tg |grep "49"
  * 18:84:80:34:51:01  (  1) via             bat49     (  1)
root@fon-58:~# batctl tg |grep "49"
  * 04:30:48:60:6c:dd  (  1) via             bat49     (  1)
root@fon-58:~# batctl tg |grep "49"
  * 04:11:80:f4:40:c8  (  1) via             bat49     (  1)

i have not yet found a device with the mac "04:11:80:f4:40:c8"

if i look in the logs on bat49 it keeps creating and deleting an enrty 
with this address:
root@1043-49:~# batctl l | grep "40:c8"
[      9726] Creating new global tt entry: 04:11:80:f4:40:c8 (via 
0a:18:84:1e:f6:05)
[      9726] Deleting global tt entry 04:11:80:f4:40:c8 (via 
0a:18:84:1e:f6:05): originator time out

The nodes are fixed an not moving. Do i have to specify them as 
non-roaming somehow?

We have problems with the correct / same time on all devices. Is that a 
problem for batman?

Tobias

