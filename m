Return-Path: <Jochen.Jaegers@riedel-at.de>
From: Jochen =?ISO-8859-1?Q?J=E4gers?= <jochen.jaegers@riedel-at.de>
Date: Mon, 14 May 2012 17:53:27 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <1337010808.2814.70.camel@E-PC-JJ>
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Some problems with batman-adv
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

Hello,

i try to set up a ad-hoc-mesh network with batman-adv.

There are three test-nodes with following configuration:

Nvidia Tegra 2 Dual Core ARM-Cortex A9 Processor with Linux 2.6.36.2
USB-Wifi Dongle with Ralink 5370 Chipset
Ralink rt5370sta driver kernel module
batman-adv 2012.1.0 (also tried with 2012.0.0)

I've set up the ad-hoc network with WPA-Encryption. This is working
fine. I can access all nodes if i configure the ra0 (ralink wifi)
interface with static ip addresses. I've done this for testing purpose
only. Normally only the bat0 interface has an ip address.

After wireless connection is established I activate the batman-adv
interface.

Example from first node:
modprobe batman-adv
batctl if add ra0                                                  =20
ifconfig bat0 up                                                     =20
ifconfig bat0 192.168.50.1 netmask 255.255.255.0
ifconfig bat0 mtu 1472

After booting up all nodes "batctl o" returns:
# batctl o
[B.A.T.M.A.N. adv 2012.1.0, MainIF/MAC: ra0/80:1f:02:38:7a:bf (bat0)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
00:0f:c9:22:00:17    0.020s   (248) 00:0f:c9:22:00:17 [       ra0]:
00:0f:c9:22:11:78 (245) 00:0f:c9:22:00:17 (248)
00:0f:c9:22:11:78    0.560s   (255) 00:0f:c9:22:11:78 [       ra0]:
00:0f:c9:22:00:17 (230) 00:0f:c9:22:11:78 (255)

So far everything looks fine. But if i try to connect to the other nodes
i mostly get no answers. No ping reply, no ssh or http connection. But
sometimes it works for a couple of minutes.
I also tried to ping with batctl but got unstable results:
first time everything looks good:

# batctl ping 00:0f:c9:22:00:17
PING 00:0f:c9:22:00:17 (00:0f:c9:22:00:17) 20(48) bytes of data
20 bytes from 00:0f:c9:22:00:17 icmp_seq=3D1 ttl=3D50 time=3D6.37 ms
20 bytes from 00:0f:c9:22:00:17 icmp_seq=3D2 ttl=3D50 time=3D13.22 ms
20 bytes from 00:0f:c9:22:00:17 icmp_seq=3D3 ttl=3D50 time=3D9.08 ms
^C--- 00:0f:c9:22:00:17 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss
rtt min/avg/max/mdev =3D 6.373/9.560/13.225/2.818 ms


another try a few moments later did not work:
# batctl ping 00:0f:c9:22:00:17
PING 00:0f:c9:22:00:17 (00:0f:c9:22:00:17) 20(48) bytes of data
Reply from host 00:0f:c9:22:00:17 timed out
Reply from host 00:0f:c9:22:00:17 timed out
Reply from host 00:0f:c9:22:00:17 timed out
Reply from host 00:0f:c9:22:00:17 timed out
^C--- 00:0f:c9:22:00:17 ping statistics ---
4 packets transmitted, 0 received, 100% packet loss
rtt min/avg/max/mdev =3D 0.000/0.000/0.000/0.000 ms

i tried many different things (changing MTU, Wifi channel, encryption
SSID, batman-adv version,...) but the result was the same everytime.

Some further information:
# iwconfig=20
lo        no wireless extensions.
dummy0    no wireless extensions.
usb0      no wireless extensions.
eth0      no wireless extensions.
ra0       Ralink STA  ESSID:"ceR{)|n$v#pp|fJX"  Nickname:"RT2870STA"
          Mode:Ad-Hoc  Frequency=3D2.442 GHz  Cell: DE:BB:8C:08:B8:EC  =20
          Bit Rate=3D36 Mb/s  =20
          RTS thr:off   Fragment thr:off
          Encryption key:D83E-521A-8B9F-7C95-3ACE-D477-****-****
Security mode:open
          Link Quality=3D52/100  Signal level:-71 dBm  Noise level:-71 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0
bat0      no wireless extensions.

#ifconfig ra0
ra0       Link encap:Ethernet  HWaddr 80:1F:02:38:7A:BF =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:11 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:258771 (252.7 KiB)  TX bytes:13544 (13.2 KiB)

#ifconfig bat0
bat0      Link encap:Ethernet  HWaddr 02:DA:94:22:E1:67 =20
          inet addr:192.168.50.60  Bcast:192.168.50.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1472  Metric:1
          RX packets:5 errors:0 dropped:0 overruns:0 frame:0
          TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:434 (434.0 B)  TX bytes:686 (686.0 B)




Do you have any ideas what I can try to solve my problem or where to
search for a solution?

Thanks for any response.

Greetings,
--=20
Jochen J=C3=A4gers

Dr. Riedel Automatisierungstechnik GmbH
Greifswalder Str. 4
10405 Berlin

Tel. 030/428431-48
Fax. 030/428431-99

http://www.riedel-at.de/

Gesch=C3=A4ftsf=C3=BChrer: Dr. Manfred Riedel
Amtsgericht Berlin Charlottenburg, HRB 39094
Umsatzsteuer-Identifikationsnummer DE 137 196 925



