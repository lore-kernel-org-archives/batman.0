Return-Path: <johnzeng2013@yahoo.com>
Message-ID: <580A3456.5010002@yahoo.com>
Date: Fri, 21 Oct 2016 23:29:26 +0800
From: johnzeng <johnzeng2013@yahoo.com>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] High latency with batman-adv on ethernet
References: <580A26A4.5030005@yahoo.com> <1744565.jjMyA2xSBQ@bentobox>
 <2284104.QWR2gm6sJD@bentobox>
In-Reply-To: <2284104.QWR2gm6sJD@bentobox>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Dear Sven:

this is my config

archlinux 4.4.26-1-ARCH

[root@alarmpi ~]# batctl -v
batctl 2016.2 [batman-adv: 2016.3]


-----------------------------------------------------------------------------------------
hostA

[root@alarmpi ~]# ip link set mtu 1532 dev eth0
[root@alarmpi ~]# batctl if add eth0
[root@alarmpi ~]# ip link set up dev eth0
[root@alarmpi ~]# ip link set up dev bat0

-----------------------------------------------------------------------------------------
bat0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 10.10.130.88  netmask 255.255.255.0  broadcast 10.10.130.255
         inet6 fe80::1c07:c4ff:fe7e:4924  prefixlen 64  scopeid 0x20<link>
         ether 1e:07:c4:7e:49:24  txqueuelen 1000  (Ethernet)
         RX packets 20  bytes 1526 (1.4 KiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 12  bytes 942 (942.0 B)
         TX errors 0  dropped 13 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1532
         inet 192.168.0.169  netmask 255.255.255.0  broadcast 192.168.0.255
         inet6 fe80::ba27:ebff:fefa:73b2  prefixlen 64  scopeid 0x20<link>
         ether b8:27:eb:fa:73:b2  txqueuelen 1000  (Ethernet)
         RX packets 3217  bytes 191526 (187.0 KiB)
         RX errors 0  dropped 2466  overruns 0  frame 0
         TX packets 622  bytes 69243 (67.6 KiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
         inet 127.0.0.1  netmask 255.0.0.0
         inet6 ::1  prefixlen 128  scopeid 0x10<host>
         loop  txqueuelen 1  (Local Loopback)
         RX packets 13  bytes 1101 (1.0 KiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 13  bytes 1101 (1.0 KiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
--------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------------------
hostB

[root@alarmpi ~]# ip link set mtu 1532 dev eth0
[root@alarmpi ~]# batctl if add eth0
[root@alarmpi ~]# ip link set up dev eth0
[root@alarmpi ~]# ip link set up dev bat0

-------------------------------------------------------------------------------------------------------

bat0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 10.10.130.1  netmask 255.255.255.0  broadcast 10.10.130.255
         inet6 fe80::d015:7ec8:fe14:4637  prefixlen 64  scopeid 0x20<link>
         ether 1e:15:7a:b7:08:5a  txqueuelen 1000  (Ethernet)
         RX packets 1657  bytes 83112 (81.1 KiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 421  bytes 94519 (92.3 KiB)
         TX errors 0  dropped 35 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1532
         inet 192.168.0.170  netmask 255.255.255.0  broadcast 192.168.0.255
         inet6 fe80::ba27:ebff:fed8:f2b5  prefixlen 64  scopeid 0x20<link>
         ether b8:27:eb:d8:f2:b5  txqueuelen 1000  (Ethernet)
         RX packets 23332  bytes 3589386 (3.4 MiB)
         RX errors 0  dropped 819  overruns 0  frame 0
         TX packets 26114  bytes 2602362 (2.4 MiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
         inet 127.0.0.1  netmask 255.0.0.0
         inet6 ::1  prefixlen 128  scopeid 0x10<host>
         loop  txqueuelen 1  (Local Loopback)
         RX packets 193  bytes 15397 (15.0 KiB)
         RX errors 0  dropped 0  overruns 0  frame 0
         TX packets 193  bytes 15397 (15.0 KiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
         inet 172.168.0.1  netmask 255.255.255.0  broadcast 172.168.0.255
         inet6 fe80::ca3a:35ff:fec9:ce71  prefixlen 64  scopeid 0x20<link>
         ether c8:3a:35:c9:ce:71  txqueuelen 1000  (Ethernet)
         RX packets 4177  bytes 636431 (621.5 KiB)
         RX errors 0  dropped 13  overruns 0  frame 0
         TX packets 3539  bytes 2661310 (2.5 MiB)
         TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
------------------------------------------------------------------------------------------------------------


----------------------------------------- 
-------------------------------------------------------------------
from hostB 10.10.130.1  ping  hostA 10.10.130.88

------------------------------------------------------------------------------------------------------------
[root@alarmpi ~]# ping 10.10.130.88
PING 10.10.130.88 (10.10.130.88) 56(84) bytes of data.
64 bytes from 10.10.130.88: icmp_seq=1 ttl=64 time=1025 ms
64 bytes from 10.10.130.88: icmp_seq=2 ttl=64 time=1084 ms
64 bytes from 10.10.130.88: icmp_seq=3 ttl=64 time=1056 ms
64 bytes from 10.10.130.88: icmp_seq=4 ttl=64 time=971 ms
64 bytes from 10.10.130.88: icmp_seq=5 ttl=64 time=1052 ms
64 bytes from 10.10.130.88: icmp_seq=6 ttl=64 time=1123 ms
64 bytes from 10.10.130.88: icmp_seq=7 ttl=64 time=1049 ms
64 bytes from 10.10.130.88: icmp_seq=8 ttl=64 time=1112 ms
64 bytes from 10.10.130.88: icmp_seq=9 ttl=64 time=1055 ms
64 bytes from 10.10.130.88: icmp_seq=10 ttl=64 time=1112 ms



----------------------------------------- 
-------------------------------------------------------------------
tcpdump   from  hostA 10.10.130.88


[root@alarmpi ~]# tcpdump -i bat0
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on bat0, link-type EN10MB (Ethernet), capture size 262144 bytes
15:25:02.269833 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:25:12.289863 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:25:22.309866 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:25:32.329843 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:25:42.349854 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:25:52.369883 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:25:52.369889 ARP, Reply 0.0.0.0 is-at b8:27:eb:fa:73:b2 (oui 
Unknown), length 28
15:26:01.899991 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, 
Request from 1e:15:7a:b7:08:5a (oui Unknown), length 350
15:26:02.389841 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:26:12.409835 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:26:17.498686 IP bogon > bogon: ICMP echo request, id 626, seq 1, 
length 64
15:26:18.522626 IP bogon > bogon: ICMP echo reply, id 626, seq 1, length 64
15:26:18.523618 IP bogon > bogon: ICMP echo request, id 626, seq 2, 
length 64
15:26:19.244386 IP bogon > bogon: ICMP echo reply, id 626, seq 2, length 64
15:26:20.876932 IP bogon > bogon: ICMP echo request, id 626, seq 3, 
length 64
15:26:21.931920 IP bogon > bogon: ICMP echo reply, id 626, seq 3, length 64
15:26:21.940098 IP bogon > bogon: ICMP echo request, id 626, seq 4, 
length 64
15:26:22.850412 IP bogon > bogon: ICMP echo reply, id 626, seq 4, length 64
15:26:22.851347 ARP, Request who-has bogon tell bogon, length 28
15:26:22.851890 ARP, Reply bogon is-at 1e:15:7a:b7:08:5a (oui Unknown), 
length 28
15:26:22.879878 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:26:24.097927 IP bogon > bogon: ICMP echo request, id 626, seq 5, 
length 64
15:26:25.149237 IP bogon > bogon: ICMP echo reply, id 626, seq 5, length 64
15:26:25.157413 IP bogon > bogon: ICMP echo request, id 626, seq 6, 
length 64
15:26:25.981228 IP bogon > bogon: ICMP echo reply, id 626, seq 6, length 64
15:26:27.140034 IP bogon > bogon: ICMP echo request, id 626, seq 7, 
length 64
15:26:28.188497 IP bogon > bogon: ICMP echo reply, id 626, seq 7, length 64
15:26:28.189529 IP bogon > bogon: ICMP echo request, id 626, seq 8, 
length 64
15:26:28.910758 IP bogon > bogon: ICMP echo reply, id 626, seq 8, length 64
15:26:30.193020 IP bogon > bogon: ICMP echo request, id 626, seq 9, 
length 64
15:26:31.247332 IP bogon > bogon: ICMP echo reply, id 626, seq 9, length 64
15:26:31.248525 IP bogon > bogon: ICMP echo request, id 626, seq 10, 
length 64
15:26:32.096880 IP bogon > bogon: ICMP echo reply, id 626, seq 10, length 64
15:26:32.909841 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:26:34.052330 IP bogon > bogon: ICMP echo request, id 626, seq 11, 
length 64
15:26:35.088054 IP bogon > bogon: ICMP echo reply, id 626, seq 11, length 64
15:26:35.089050 IP bogon > bogon: ICMP echo request, id 626, seq 12, 
length 64
15:26:35.810244 IP bogon > bogon: ICMP echo reply, id 626, seq 12, length 64
15:26:36.922755 IP bogon > bogon: ICMP echo request, id 626, seq 13, 
length 64
15:26:37.910153 IP bogon > bogon: ICMP echo reply, id 626, seq 13, length 64
15:26:39.006945 IP bogon > bogon: ICMP echo request, id 626, seq 14, 
length 64
15:26:39.964130 IP bogon > bogon: ICMP echo reply, id 626, seq 14, length 64
15:26:41.032390 IP bogon > bogon: ICMP echo request, id 626, seq 15, 
length 64
15:26:42.056430 IP bogon > bogon: ICMP echo reply, id 626, seq 15, length 64
15:26:42.057424 IP bogon > bogon: ICMP echo request, id 626, seq 16, 
length 64
15:26:42.778857 IP bogon > bogon: ICMP echo reply, id 626, seq 16, length 64
15:26:42.929845 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:26:44.027405 IP bogon > bogon: ICMP echo request, id 626, seq 17, 
length 64
15:26:45.014653 IP bogon > bogon: ICMP echo reply, id 626, seq 17, length 64
15:26:46.081391 IP bogon > bogon: ICMP echo request, id 626, seq 18, 
length 64
15:26:47.104540 IP bogon > bogon: ICMP echo reply, id 626, seq 18, length 64
15:26:47.105502 ARP, Request who-has bogon tell bogon, length 28
15:26:47.106049 ARP, Reply bogon is-at 1e:15:7a:b7:08:5a (oui Unknown), 
length 28
15:26:47.106707 IP bogon > bogon: ICMP echo request, id 626, seq 19, 
length 64
15:26:47.827792 IP bogon > bogon: ICMP echo reply, id 626, seq 19, length 64
15:26:48.931955 IP bogon > bogon: ICMP echo request, id 626, seq 20, 
length 64
15:26:49.986791 IP bogon > bogon: ICMP echo reply, id 626, seq 20, length 64
15:26:49.987830 IP bogon > bogon: ICMP echo request, id 626, seq 21, 
length 64
15:26:51.253787 IP bogon > bogon: ICMP echo reply, id 626, seq 21, length 64
15:26:51.254896 IP bogon > bogon: ICMP echo request, id 626, seq 22, 
length 64
15:26:52.140032 IP bogon > bogon: ICMP echo reply, id 626, seq 22, length 64
15:26:52.949924 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:26:52.949930 ARP, Reply 0.0.0.0 is-at b8:27:eb:fa:73:b2 (oui 
Unknown), length 28
15:26:53.074686 IP bogon > bogon: ICMP echo request, id 626, seq 23, 
length 64
15:26:54.105458 IP bogon > bogon: ICMP echo reply, id 626, seq 23, length 64
15:26:54.106787 IP bogon > bogon: ICMP echo request, id 626, seq 24, 
length 64
15:26:54.955005 IP bogon > bogon: ICMP echo reply, id 626, seq 24, length 64
15:26:56.336044 IP bogon > bogon: ICMP echo request, id 626, seq 25, 
length 64
15:26:57.369772 IP bogon > bogon: ICMP echo reply, id 626, seq 25, length 64
15:26:57.370794 IP bogon > bogon: ICMP echo request, id 626, seq 26, 
length 64
15:26:58.219681 IP bogon > bogon: ICMP echo reply, id 626, seq 26, length 64
15:26:59.578372 IP bogon > bogon: ICMP echo request, id 626, seq 27, 
length 64
15:27:00.612175 IP bogon > bogon: ICMP echo reply, id 626, seq 27, length 64
15:27:00.613320 IP bogon > bogon: ICMP echo request, id 626, seq 28, 
length 64
15:27:01.505147 IP bogon > bogon: ICMP echo reply, id 626, seq 28, length 64
15:27:02.441128 IP bogon > bogon: ICMP echo request, id 626, seq 29, 
length 64
15:27:03.487369 IP bogon > bogon: ICMP echo reply, id 626, seq 29, length 64
15:27:03.488559 IP bogon > bogon: ICMP echo request, id 626, seq 30, 
length 64
15:27:04.336996 IP bogon > bogon: ICMP echo reply, id 626, seq 30, length 64
15:27:04.340675 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:27:05.331808 IP bogon > bogon: ICMP echo request, id 626, seq 31, 
length 64
15:27:06.367689 IP bogon > bogon: ICMP echo reply, id 626, seq 31, length 64
15:27:06.368768 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, 
Request from 1e:15:7a:b7:08:5a (oui Unknown), length 350
15:27:06.368773 IP bogon > bogon: ICMP echo request, id 626, seq 32, 
length 64
15:27:07.089593 IP bogon > bogon: ICMP echo reply, id 626, seq 32, length 64
15:27:08.218598 IP bogon > bogon: ICMP echo request, id 626, seq 33, 
length 64
15:27:09.272724 IP bogon > bogon: ICMP echo reply, id 626, seq 33, length 64
15:27:09.273837 IP bogon > bogon: ICMP echo request, id 626, seq 34, 
length 64
15:27:10.287572 IP bogon > bogon: ICMP echo reply, id 626, seq 34, length 64
15:27:11.045960 IP bogon > bogon: ICMP echo request, id 626, seq 35, 
length 64
15:27:12.073985 IP bogon > bogon: ICMP echo reply, id 626, seq 35, length 64
15:27:12.074885 ARP, Request who-has bogon tell bogon, length 28
15:27:12.075465 ARP, Reply bogon is-at 1e:15:7a:b7:08:5a (oui Unknown), 
length 28
15:27:12.076299 IP bogon > bogon: ICMP echo request, id 626, seq 36, 
length 64
15:27:12.923977 IP bogon > bogon: ICMP echo reply, id 626, seq 36, length 64
15:27:13.931779 IP bogon > bogon: ICMP echo request, id 626, seq 37, 
length 64
15:27:14.966326 IP bogon > bogon: ICMP echo reply, id 626, seq 37, length 64
15:27:14.967323 IP bogon > bogon: ICMP echo request, id 626, seq 38, 
length 64
15:27:15.688507 IP bogon > bogon: ICMP echo reply, id 626, seq 38, length 64
15:27:15.690217 ARP, Reply 0.0.0.0 is-at 43:05:43:05:b8:20 (oui 
Unknown), length 28
15:27:16.961136 IP bogon > bogon: ICMP echo request, id 626, seq 39, 
length 64
15:27:17.947857 IP bogon > bogon: ICMP echo reply, id 626, seq 39, length 64
15:27:18.964151 IP bogon > bogon: ICMP echo request, id 626, seq 40, 
length 64
15:27:19.990174 IP bogon > bogon: ICMP echo reply, id 626, seq 40, length 64
15:27:19.991106 IP bogon > bogon: ICMP echo request, id 626, seq 41, 
length 64
15:27:20.712663 IP bogon > bogon: ICMP echo reply, id 626, seq 41, length 64
15:27:21.812959 IP bogon > bogon: ICMP echo request, id 626, seq 42, 
length 64
15:27:22.866807 IP bogon > bogon: ICMP echo reply, id 626, seq 42, length 64
15:27:22.867823 IP bogon > bogon: ICMP echo request, id 626, seq 43, 
length 64
15:27:23.588618 IP bogon > bogon: ICMP echo reply, id 626, seq 43, length 64
15:27:24.718226 IP bogon > bogon: ICMP echo request, id 626, seq 44, 
length 64


------------------------------------------------------------------------------------------------------------







> On Freitag, 21. Oktober 2016 16:43:41 CEST Sven Eckelmann wrote:
> [...]
>>> because i tested between ethernet network port ( i don't test in wifi
>>> port ) , whether it will master reason ?
>> Should not be the "reason". batman-adv doesn't care much about it. It just
>> requires an ethernet compatible device. The re-broadcast is a little bit
>> less aggressive on non-wifi devices but this has nothing to do with your
>> problem.
> Just created a small test setup via ethernet with batman-adv 2016.3 to show
> you how the results are here. They were connected via a single cable:
>
> without batman-adv
> ------------------
>
>      $ ping -c 10 192.168.2.196
>      PING 192.168.2.196 (192.168.2.196) 56(84) bytes of data.
>      64 bytes from 192.168.2.196: icmp_seq=1 ttl=64 time=0.478 ms
>      64 bytes from 192.168.2.196: icmp_seq=2 ttl=64 time=0.682 ms
>      64 bytes from 192.168.2.196: icmp_seq=3 ttl=64 time=0.392 ms
>      64 bytes from 192.168.2.196: icmp_seq=4 ttl=64 time=0.642 ms
>      64 bytes from 192.168.2.196: icmp_seq=5 ttl=64 time=0.574 ms
>      64 bytes from 192.168.2.196: icmp_seq=6 ttl=64 time=0.466 ms
>      64 bytes from 192.168.2.196: icmp_seq=7 ttl=64 time=0.602 ms
>      64 bytes from 192.168.2.196: icmp_seq=8 ttl=64 time=0.619 ms
>      64 bytes from 192.168.2.196: icmp_seq=9 ttl=64 time=0.658 ms
>      64 bytes from 192.168.2.196: icmp_seq=10 ttl=64 time=0.440 ms
>      
>      --- 192.168.2.196 ping statistics ---
>      10 packets transmitted, 10 received, 0% packet loss, time 9000ms
>      rtt min/avg/max/mdev = 0.392/0.555/0.682/0.098 ms
>
> with batman-adv
> ---------------
>
>      $ ping -c 10 10.10.130.66
>      PING 10.10.130.66 (10.10.130.66) 56(84) bytes of data.
>      64 bytes from 10.10.130.66: icmp_seq=1 ttl=64 time=0.489 ms
>      64 bytes from 10.10.130.66: icmp_seq=2 ttl=64 time=0.675 ms
>      64 bytes from 10.10.130.66: icmp_seq=3 ttl=64 time=0.552 ms
>      64 bytes from 10.10.130.66: icmp_seq=4 ttl=64 time=0.562 ms
>      64 bytes from 10.10.130.66: icmp_seq=5 ttl=64 time=0.612 ms
>      64 bytes from 10.10.130.66: icmp_seq=6 ttl=64 time=0.573 ms
>      64 bytes from 10.10.130.66: icmp_seq=7 ttl=64 time=0.534 ms
>      64 bytes from 10.10.130.66: icmp_seq=8 ttl=64 time=0.622 ms
>      64 bytes from 10.10.130.66: icmp_seq=9 ttl=64 time=0.454 ms
>      64 bytes from 10.10.130.66: icmp_seq=10 ttl=64 time=0.468 ms
>      
>      --- 10.10.130.66 ping statistics ---
>      10 packets transmitted, 10 received, 0% packet loss, time 8996ms
>      rtt min/avg/max/mdev = 0.454/0.554/0.675/0.067 ms
>
> Kind regards,
> 	Sven
>
> PS: I've changed the subject because it was extremely unspecific and
> too long.

