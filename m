Message-ID: <8c906fa50809120528g269e7831s979246af74b29427@mail.gmail.com>
Date: Fri, 12 Sep 2008 09:28:34 -0300
From: "Gustavo Lindberg" <gus.lindberg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27037_18921268.1221222514545"
Subject: [B.A.T.M.A.N.] Batmand dies
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
To: b.a.t.m.a.n@open-mesh.net

------=_Part_27037_18921268.1221222514545
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I just tried the last openwrt-kamikaze trunk with the svn v1109 of batman on
ubnt NS2. Batmand die as follows:

 root@OpenWrt:~# batmand -d 4 -g 5000 ath2
WARNING: You are using the unstable batman branch. If you are interested in
*using* batman get the latest stable release !
Interface activated: ath2
Using interface ath2 with address 5.0.0.1 and broadcast address
5.255.255.255
B.A.T.M.A.N. 0.3-beta (compatibility version 5)
[        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
address
[        80] Error - can't set IFFLAGS for gate0: Cannot assign requested
address


dmesg output:

Atheros HAL provided by OpenWrt, DD-WRT and MakSat Technologies
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps
24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
ath_ahb: wifi0: Atheros 2315 WiSoC: mem=0xb0000000, irq=3
gpio-buttons driver version 0.1.1
batgat: [batgat_ioctl:224] name gate0 index 7
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
batgat: [batgat_ioctl:224] name gate0 index 8
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
batgat: [batgat_ioctl:224] name gate0 index 9
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
batgat: [batgat_ioctl:224] name gate0 index 10
batgat: [batgat_ioctl:244] disconnect daemon
batgat: [packet_recv_thread:508] thread stop
batgat: [batgat_ioctl:256] thread shutdown
batgat: [batgat_ioctl:263] gate shutdown
batgat: [batgat_ioctl:277] device unregistered successfully
root@OpenWrt:~#

No iptables rules at all. All policy ACCEPT.

BATGAT dont crash anymore,



Greetings.
Gustavo.

------=_Part_27037_18921268.1221222514545
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><p>I just tried the last openwrt-kamikaze trunk with the svn v1109 of batman on ubnt NS2. Batmand die as follows:<br>&nbsp;<br>&nbsp;<a href="mailto:root@OpenWrt">root@OpenWrt</a>:~# batmand -d 4 -g 5000 ath2<br>WARNING: You are using the unstable batman branch. If you are interested in *using* batman get the latest stable release !<br>
Interface activated: ath2<br>Using interface ath2 with address <a href="http://5.0.0.1">5.0.0.1</a> and broadcast address <a href="http://5.255.255.255">5.255.255.255</a><br>B.A.T.M.A.N. 0.3-beta (compatibility version 5)<br>
[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80] Error - can&#39;t set IFFLAGS for gate0: Cannot assign requested address<br>[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80] Error - can&#39;t set IFFLAGS for gate0: Cannot assign requested address<br>&nbsp;<br>&nbsp;<br>dmesg output:<br>&nbsp;<br>Atheros HAL provided by OpenWrt, DD-WRT and MakSat Technologies<br>
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps<br>wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps<br>wifi0: H/W encryption support: WEP AES AES_CCM TKIP<br>ath_ahb: wifi0: Atheros 2315 WiSoC: mem=0xb0000000, irq=3<br>
gpio-buttons driver version 0.1.1<br>batgat: [batgat_ioctl:224] name gate0 index 7<br>batgat: [batgat_ioctl:244] disconnect daemon<br>batgat: [packet_recv_thread:508] thread stop<br>batgat: [batgat_ioctl:256] thread shutdown<br>
batgat: [batgat_ioctl:263] gate shutdown<br>batgat: [batgat_ioctl:277] device unregistered successfully<br>batgat: [batgat_ioctl:224] name gate0 index 8<br>batgat: [batgat_ioctl:244] disconnect daemon<br>batgat: [packet_recv_thread:508] thread stop<br>
batgat: [batgat_ioctl:256] thread shutdown<br>batgat: [batgat_ioctl:263] gate shutdown<br>batgat: [batgat_ioctl:277] device unregistered successfully<br>batgat: [batgat_ioctl:224] name gate0 index 9<br>batgat: [batgat_ioctl:244] disconnect daemon<br>
batgat: [packet_recv_thread:508] thread stop<br>batgat: [batgat_ioctl:256] thread shutdown<br>batgat: [batgat_ioctl:263] gate shutdown<br>batgat: [batgat_ioctl:277] device unregistered successfully<br>batgat: [batgat_ioctl:224] name gate0 index 10<br>
batgat: [batgat_ioctl:244] disconnect daemon<br>batgat: [packet_recv_thread:508] thread stop<br>batgat: [batgat_ioctl:256] thread shutdown<br>batgat: [batgat_ioctl:263] gate shutdown<br>batgat: [batgat_ioctl:277] device unregistered successfully<br>
<a href="mailto:root@OpenWrt">root@OpenWrt</a>:~#&nbsp;&nbsp; </p>
<p>No iptables rules at all. All policy ACCEPT.<br>&nbsp;<br>BATGAT dont crash anymore,&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>Greetings.<br>Gustavo.</p></div>

------=_Part_27037_18921268.1221222514545--
