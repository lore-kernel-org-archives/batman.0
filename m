Return-Path: <APouliot@c2t3.ca>
From: =?iso-8859-1?Q?Andr=E9_Pouliot?= <APouliot@c2t3.ca>
Date: Thu, 14 Jan 2016 16:31:08 +0000
Message-ID: <ff54fe803c7c44eda0b860c69983c5d5@W2K1204EX.c2t3.local>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Need help bridging Regular AP to Batman
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

I'm trying to do a mesh network using the RaspberryPi and Batman.=20

My problem is I'm using 2 wifi card on one raspberrypi one for batman and t=
he other one for connecting to my wireless access point.

I already made my mesh network I can ping on layer 2 or 3 between 2 raspber=
rypi. When connecting the Ethernet cable(on the raspberry with 2 wifi dongl=
e) I can use the bridge to ping toward the internet. But when I disconnect =
the cable I can't ping internet anymore.

I already verified my batman interface and my bridge both seem to work

The AP is connected on wlan1, wlan1 doesn't have an IP address assigned to =
it. The AP is configured with WPA2. When trying to assign a address using d=
hclient to the bridge interface the system can't seem to find a way and the=
 command is waiting.

If I want to connected my batman network to a standard wifi AP do I need to=
 use a bridge or the functionality exist with batman?=20

If it's with the bridge how can it work?

I'm putting the output of a few command at the end of the email. If you wan=
t anything else It will be my pleasure to send it.

Andr=E9 Pouliot

-----
root@raspberrypi:/home/pi# ifconfig
bat0      Link encap:Ethernet  HWaddr 72:4c:12:42:f2:d4
          inet6 addr: fe80::704c:12ff:fe42:f2d4/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:354 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5857 errors:0 dropped:791 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:19536 (19.0 KiB)  TX bytes:821562 (802.3 KiB)

eth0      Link encap:Ethernet  HWaddr b8:27:eb:06:21:f3
          inet addr:172.17.94.48  Bcast:172.17.95.255  Mask:255.255.240.0
          inet6 addr: fe80::ba27:ebff:fe06:21f3/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9628 errors:0 dropped:5 overruns:0 frame:0
          TX packets:3273 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1054143 (1.0 MiB)  TX bytes:380009 (371.1 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:216 errors:0 dropped:0 overruns:0 frame:0
          TX packets:216 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:22172 (21.6 KiB)  TX bytes:22172 (21.6 KiB)

mesh-bridge Link encap:Ethernet  HWaddr 00:0f:60:04:03:a6
          inet addr:172.17.94.29  Bcast:172.17.95.255  Mask:255.255.240.0
          inet6 addr: fe80::20f:60ff:fe04:3a6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:9123 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2856 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:963896 (941.3 KiB)  TX bytes:316106 (308.6 KiB)

wlan0     Link encap:Ethernet  HWaddr 40:a5:ef:01:23:c8
          inet6 addr: fe80::42a5:efff:fe01:23c8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1532  Metric:1
          RX packets:22070 errors:0 dropped:0 overruns:0 frame:0
          TX packets:29900 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2408956 (2.2 MiB)  TX bytes:4165384 (3.9 MiB)

wlan1     Link encap:Ethernet  HWaddr 00:0f:60:04:03:a6
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:2195 errors:0 dropped:1 overruns:0 frame:0
          TX packets:11 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:276922 (270.4 KiB)  TX bytes:3110 (3.0 KiB)

root@raspberrypi:/home/pi# brctl show
bridge name     bridge id               STP enabled     interfaces
mesh-bridge             8000.000f600403a6       no              bat0
                                                        eth0
                                                        wlan1


root@raspberrypi:/home/pi# batctl o
[B.A.T.M.A.N. adv 2015.0, MainIF/MAC: wlan0/40:a5:ef:01:23:c8 (bat0 BATMAN_=
IV)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   Poten=
tial nexthops ...
40:a5:ef:01:2f:58    0.010s   (255) 40:a5:ef:01:2f:58 [     wlan0]: 40:a5:e=
f:01:2f:58 (255)
 =20

root@raspberrypi:/home/pi# iw dev wlan1 link

Connected to 00:24:01:65:e4:6d (on wlan1)
        SSID: C2T3-Prod
        freq: 2437
        RX: 16265 bytes (149 packets)
        TX: 180 bytes (3 packets)
        signal: -43 dBm
        tx bitrate: 6.5 MBit/s MCS 0

        bss flags:      short-preamble short-slot-time
        dtim period:    1
        beacon int:     100


