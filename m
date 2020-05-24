Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
 <4485194.d5W8GeZ6RB@sven-edge>
In-Reply-To: <4485194.d5W8GeZ6RB@sven-edge>
From: Alexey Ermakov <axel101@gmail.com>
Date: Sun, 24 May 2020 17:43:55 +0300
Message-ID: <CAOVt3fE8-U73oJV2XjnxFzWc35LAMeXeaNsTUUgPaLqvchv-Cw@mail.gmail.com>
Subject: Re: Batman-adv packet retranslation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

Sorry, I didn't provided full information about experiment conditions.
I could reproduce issue on virtual machines.
I started 3 nodes with virtual interfaces eth0 which linked to host
bridge interface br0.
Network traffic between node 1 and node 3 drops by nft as described
Sven Eckelmann above.
At start moment br0 is down.
After virtual machines had booted I configured them by following steps:
1) insmod /usr/batman-adv.ko
2) ifconfig eth0 up
3) batctl ra BATMAN_V
4 batctl if add eth0
5) ifconfig bat0 192.168.1.<n> up      NOTE: 'n' is node numer: 1, 2 or 3
6) batctl hardif eth0 to 100                NOTE: If sklip this step,
all works fine!

After this I started host bridge interface br0. NOTE: if bridge had
started before batman configured all works fine

After these steps I have following results:
---
NODE 1:
(none)# ip -o link show dev eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
master bat0 state UP mode DEFAULT group default qlen 1000\
link/ether 00:04:23:dc:3b:01 brd ff:ff:ff:ff
:ff:ff
(none)# ip -o link show dev bat0
17: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UNKNOWN mode DEFAULT group default qlen 1000\    link/ether
62:7f:0f:87:43:78 brd ff:ff:ff:ff:ff:ff
(none)# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/00:04:23:dc:3b:01
(bat0/62:7f:0f:87:43:78 BATMAN_V)]
  Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
* 00:04:23:dc:3b:10    0.580s (        0.1)  00:04:23:dc:3b:10 [      eth0]

---
NODE 2:
(none)# ip -o link show dev eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
master bat0 state UP mode DEFAULT group default qlen 1000\
link/ether 00:04:23:dc:3b:10 brd ff:ff:ff:ff
:ff:ff
(none)# ip -o link show dev bat0
17: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UNKNOWN mode DEFAULT group default qlen 1000\    link/ether
22:86:ba:4e:9c:5c brd ff:ff:ff:ff:ff:ff
(none)# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/00:04:23:dc:3b:10
(bat0/22:86:ba:4e:9c:5c BATMAN_V)]
  Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
* 00:04:23:dc:3b:01    0.960s (        0.1)  00:04:23:dc:3b:01 [      eth0]
* 00:04:23:dc:3b:1f    0.450s (        0.1)  00:04:23:dc:3b:1f [      eth0]

---
NODE 3:
(none)# ip -o link show dev eth0
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast
master bat0 state UP mode DEFAULT group default qlen 1000\
link/ether 00:04:23:dc:3b:1f brd ff:ff:ff:ff
:ff:ff
(none)# ip -o link show dev bat0
17: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UNKNOWN mode DEFAULT group default qlen 1000\    link/ether
42:d8:87:c3:7e:6e brd ff:ff:ff:ff:ff:ff
(none)# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/00:04:23:dc:3b:1f
(bat0/42:d8:87:c3:7e:6e BATMAN_V)]
  Originator        last-seen ( throughput)  Nexthop           [outgoingIF]
* 00:04:23:dc:3b:10    0.330s (        0.1)  00:04:23:dc:3b:10 [      eth0]

---
I didn't provided ping result because it's oblivious.
In my case eth0 not actualy ethernet connection between nodes, it is
connection to radio modem which configured as bridge and it can be
configured for a long time. Therefore, there is no guarantee that the
channel will be available at the batman setup time (but eth0 link is
UP).

=D0=BF=D1=82, 22 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 09:25, Sven Eckelma=
nn <sven@narfation.org>:
>
> On Thursday, 21 May 2020 19:13:18 CEST Alexey Ermakov wrote:
> [...]
> > I have 3 stations, st1, st2 and st3 with one active network interface.
> > This interface is configured so that st1 and st3 can see only st2.
> [...]
> > This works fine if I selecting B.A.T.M.A.N. IV algorithm, but doesn't
> > work in B.A.T.M.A.N.V.
>
> That's not a lot to work with. I am rather sure that the B.A.T.M.A.N. V
> developers will not be able to figure out what is going on with this
> information.
>
> I have just tried it out in my documented setup [1,2] and following
> test-init.sh::
>
>     #! /bin/sh
>
>     set -e
>     export PATH=3D"/host/batctl/:$PATH"
>
>     insmod /host/batman-adv/net/batman-adv/batman-adv.ko
>     batctl routing_algo BATMAN_V
>     /host/batctl/batctl if add enp0s1
>     ip link set up dev enp0s1
>     ip link set up dev bat0
>
>     MAC_PART=3D"$(ip link show enp0s1 | awk "/ether/ {print \$2}"| sed -e=
 "s/.*://" -e "s/[\\n\\ ].*//"|awk "{print (\"0x\"\$1)*1 }")"
>     IP_PART=3D"$(echo $MAC_PART|awk "{ print \$1 }")"
>     ip addr replace 192.168.55.${IP_PART}/24 dev bat0
>
> The used kernel version is next-20200521 and batman-adv 2020.1.
>
> These are the neighbor and originator tables of the devices + ping test
> results:
>
> * node1
>
>   - neighbor::
>
>       [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:01 (bat=
0/12:99:c8:a5:1e:27 BATMAN_V)]
>       IF             Neighbor              last-seen
>       02:ba:de:af:fe:02    0.528s (        1.0) [    enp0s1]
>
>   - originator::
>
>       [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:01 (bat=
0/12:99:c8:a5:1e:27 BATMAN_V)]
>          Originator        last-seen ( throughput)  Nexthop           [ou=
tgoingIF]
>        * 02:ba:de:af:fe:03    0.704s (        0.8)  02:ba:de:af:fe:02 [  =
  enp0s1]
>        * 02:ba:de:af:fe:02    0.704s (        1.0)  02:ba:de:af:fe:02 [  =
  enp0s1]
>
>   - bat0 ping::
>
>       $ for i in $(seq 1 3); do ping -q -c 3 192.168.55.$i; done
>       PING 192.168.55.1 (192.168.55.1) 56(84) bytes of data.
>
>       --- 192.168.55.1 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 28ms
>       rtt min/avg/max/mdev =3D 0.482/0.539/0.613/0.060 ms
>       PING 192.168.55.2 (192.168.55.2) 56(84) bytes of data.
>
>       --- 192.168.55.2 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 8ms
>       rtt min/avg/max/mdev =3D 1.797/1.940/2.060/0.114 ms
>       PING 192.168.55.3 (192.168.55.3) 56(84) bytes of data.
>
>       --- 192.168.55.3 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 10ms
>       rtt min/avg/max/mdev =3D 2.105/3.021/3.962/0.760 ms
>
>   - enp1s0 ping::
>
>       $ for i in $(seq 1 3); do ping -q -c 3 192.168.251.5$i; done
>       PING 192.168.251.51 (192.168.251.51) 56(84) bytes of data.
>
>       --- 192.168.251.51 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 36ms
>       rtt min/avg/max/mdev =3D 0.170/0.396/0.510/0.160 ms
>       PING 192.168.251.52 (192.168.251.52) 56(84) bytes of data.
>
>       --- 192.168.251.52 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 8ms
>       rtt min/avg/max/mdev =3D 1.572/2.353/3.192/0.664 ms
>       PING 192.168.251.53 (192.168.251.53) 56(84) bytes of data.
>
>       --- 192.168.251.53 ping statistics ---
>       3 packets transmitted, 0 received, +3 errors, 100% packet loss, tim=
e 41ms
>
> * node2
>
>   - neighbor::
>
>       [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:02 (bat=
0/32:a0:63:19:b4:44 BATMAN_V)]
>       IF             Neighbor              last-seen
>       02:ba:de:af:fe:03    0.208s (        1.0) [    enp0s1]
>       02:ba:de:af:fe:01    0.344s (        1.0) [    enp0s1]
>
>   - originator::
>
>       [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:02 (bat=
0/32:a0:63:19:b4:44 BATMAN_V)]
>          Originator        last-seen ( throughput)  Nexthop           [ou=
tgoingIF]
>        * 02:ba:de:af:fe:03    0.188s (        1.0)  02:ba:de:af:fe:03 [  =
  enp0s1]
>        * 02:ba:de:af:fe:01    0.016s (        1.0)  02:ba:de:af:fe:01 [  =
  enp0s1]
>
>   - bat0 ping::
>
>       $ for i in $(seq 1 3); do ping -q -c 3 192.168.55.$i; done
>       PING 192.168.55.1 (192.168.55.1) 56(84) bytes of data.
>
>       --- 192.168.55.1 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 7ms
>       rtt min/avg/max/mdev =3D 1.961/2.510/3.484/0.691 ms
>       PING 192.168.55.2 (192.168.55.2) 56(84) bytes of data.
>
>       --- 192.168.55.2 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 38ms
>       rtt min/avg/max/mdev =3D 0.287/0.481/0.606/0.140 ms
>       PING 192.168.55.3 (192.168.55.3) 56(84) bytes of data.
>
>       --- 192.168.55.3 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 9ms
>       rtt min/avg/max/mdev =3D 1.215/1.737/2.038/0.370 ms
>
>   - enp1s0 ping::
>
>       $ for i in $(seq 1 3); do ping -q -c 3 192.168.251.5$i; done
>       PING 192.168.251.51 (192.168.251.51) 56(84) bytes of data.
>
>       --- 192.168.251.51 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 10ms
>       rtt min/avg/max/mdev =3D 1.114/1.698/2.107/0.425 ms
>       PING 192.168.251.52 (192.168.251.52) 56(84) bytes of data.
>
>       --- 192.168.251.52 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 14ms
>       rtt min/avg/max/mdev =3D 0.360/0.747/1.270/0.384 ms
>       PING 192.168.251.53 (192.168.251.53) 56(84) bytes of data.
>
>       --- 192.168.251.53 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 7ms
>       rtt min/avg/max/mdev =3D 1.909/2.427/2.692/0.371 ms
>
> * node3
>
>   - neighbor::
>
>       [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:03 (bat=
0/7a:f4:94:ef:b6:6d BATMAN_V)]
>       IF             Neighbor              last-seen
>       02:ba:de:af:fe:02    0.072s (        1.0) [    enp0s1]
>
>   - originator::
>
>       [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: enp0s1/02:ba:de:af:fe:03 (bat=
0/7a:f4:94:ef:b6:6d BATMAN_V)]
>          Originator        last-seen ( throughput)  Nexthop           [ou=
tgoingIF]
>        * 02:ba:de:af:fe:01    0.764s (        0.8)  02:ba:de:af:fe:02 [  =
  enp0s1]
>        * 02:ba:de:af:fe:02    0.148s (        1.0)  02:ba:de:af:fe:02 [  =
  enp0s1]
>
>   - bat0 ping::
>
>       $ for i in $(seq 1 3); do ping -q -c 3 192.168.55.$i; done
>       PING 192.168.55.1 (192.168.55.1) 56(84) bytes of data.
>
>       --- 192.168.55.1 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 10ms
>       rtt min/avg/max/mdev =3D 1.736/2.948/3.925/0.910 ms
>       PING 192.168.55.2 (192.168.55.2) 56(84) bytes of data.
>
>       --- 192.168.55.2 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 11ms
>       rtt min/avg/max/mdev =3D 2.081/2.175/2.361/0.136 ms
>       PING 192.168.55.3 (192.168.55.3) 56(84) bytes of data.
>
>       --- 192.168.55.3 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 27ms
>       rtt min/avg/max/mdev =3D 0.278/0.489/0.649/0.156 ms
>
>   - enp1s0 ping::
>
>       $ for i in $(seq 1 3); do ping -q -c 3 192.168.251.5$i; done
>       PING 192.168.251.51 (192.168.251.51) 56(84) bytes of data.
>
>       --- 192.168.251.51 ping statistics ---
>       3 packets transmitted, 0 received, +3 errors, 100% packet loss, tim=
e 43ms
>       pipe 3
>       PING 192.168.251.52 (192.168.251.52) 56(84) bytes of data.
>
>       --- 192.168.251.52 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 10ms
>       rtt min/avg/max/mdev =3D 1.025/1.569/1.997/0.405 ms
>       PING 192.168.251.53 (192.168.251.53) 56(84) bytes of data.
>
>       --- 192.168.251.53 ping statistics ---
>       3 packets transmitted, 3 received, 0% packet loss, time 61ms
>       rtt min/avg/max/mdev =3D 0.214/0.376/0.480/0.117 ms
>
>
> And it seems I can communicate with all nodes perfectly fine. And the
> communication between node1 and node3 seems to be blocked as expected on
> enp1s0 (the slave device of bat0).
>
> Kind regards,
>         Sven
>
> [1] https://www.open-mesh.org/projects/open-mesh/wiki/Kernel_hacking_Debi=
an_image
> [2] https://www.open-mesh.org/projects/open-mesh/wiki/Advanced_Bridge_vir=
tual_network#Allow-communication-between-specific-nodes



--=20
=D0=95=D1=80=D0=BC=D0=B0=D0=BA=D0=BE=D0=B2 =D0=90=D0=BB=D0=B5=D0=BA=D1=81=
=D0=B5=D0=B9 =D0=95=D0=B2=D0=B3=D0=B5=D0=BD=D1=8C=D0=B5=D0=B2=D0=B8=D1=87.
