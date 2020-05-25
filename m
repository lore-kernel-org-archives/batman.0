Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
 <2164745.TYCVdmGlQZ@sven-edge> <CAOVt3fG9AbAEMP+uKLy8Hsnub6=hAJG2Ekg3vrC__AqVJAdZHw@mail.gmail.com>
 <4309595.MtDqpTPQ1e@rousseau>
In-Reply-To: <4309595.MtDqpTPQ1e@rousseau>
From: Alexey Ermakov <axel101@gmail.com>
Date: Mon, 25 May 2020 17:59:23 +0300
Message-ID: <CAOVt3fEbtq-9aR-p-uEhukb+sdWduay3WfZi6GpwtdVdZpe=vQ@mail.gmail.com>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> To give advice on what to change, please provide the batman-adv routing t=
ables
> which allow us to understand how batman-adv sees your network. Please ref=
er to
> Sven's email with various examples.

Below I provide ethernet MAC addresses, tables with throughput overrid
to 100kbit/s and tables without output override.
Note that in case without override batman detects throughput about
100mbit/s. This is not quiet correct, because as I say before, nodes
connects to modems and throughput from node to modem is 100mbit/s, but
actual speed of modem is 145 kbit/s=D0=B1 therefore I should set throughput
override



eth0 interface MAC adresses:

Node 1:

node1# ip -o link show dev eth0
31: eth0@eth2: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master
bat0 state UP mode DEFAULT group default qlen 1000\    link/ether
fe:00:00:c3:5b:13 brd ff:ff:ff:ff:ff:ff


Node 2:

node2# ip -o link show dev eth0
31: eth0@eth2: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master
bat0 state UP mode DEFAULT group default qlen 1000\    link/ether
fe:00:00:3b:9b:13 brd ff:ff:ff:ff:ff:ff

---

Node 3:

node3# ip -o link show dev eth0
31: eth0@eth2: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master
bat0 state UP mode DEFAULT group default qlen 1000\    link/ether
fe:00:00:31:ed:13 brd ff:ff:ff:ff:ff:ff

Tables with throughput overrid to 100kbit/s:

 -- Node 1 tables --

node1# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:c3:5b:13
(bat0/fe:ee:f9:fe:00:68 BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF=
]
 * fe:00:00:3b:9b:13    0.750s (        0.1)  fe:00:00:3b:9b:13 [    eth0]
node1# batctl n
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:c3:5b:13
(bat0/fe:ee:f9:fe:00:68 BATMAN_V)]
IF             Neighbor              last-seen
fe:00:00:3b:9b:13    0.410s (        0.1) [    eth0]

 -- Node 2 tables --

node2# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:3b:9b:13
(bat0/6a:53:d2:c1:6f:2e BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF=
]
 * fe:00:00:31:ed:13    0.190s (        0.1)  fe:00:00:31:ed:13 [    eth0]
 * fe:00:00:c3:5b:13    0.210s (        0.1)  fe:00:00:c3:5b:13 [    eth0]
node2# batctl n
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:3b:9b:13
(bat0/6a:53:d2:c1:6f:2e BATMAN_V)]
IF             Neighbor              last-seen
fe:00:00:31:ed:13    0.320s (        0.1) [    eth0]
fe:00:00:c3:5b:13    0.120s (        0.1) [    eth0]

 -- Node 3 tables --

node3# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:31:ed:13
(bat0/fa:be:fa:e6:5b:7a BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF=
]
 * fe:00:00:3b:9b:13    0.650s (        0.1)  fe:00:00:3b:9b:13 [    eth0]
node3# batctl n
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:31:ed:13
(bat0/fa:be:fa:e6:5b:7a BATMAN_V)]
IF             Neighbor              last-seen
fe:00:00:3b:9b:13    0.500s (        0.1) [    eth0]

-----------------------------------------

Tables without throughput override:

-- Node 1 tables --

node1# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:c3:5b:13
(bat0/26:f5:9a:68:f5:2d BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF=
]
 * fe:00:00:3b:9b:13    0.090s (      100.0)  fe:00:00:3b:9b:13 [    eth0]
 * fe:00:00:31:ed:13    0.350s (       88.2)  fe:00:00:3b:9b:13 [    eth0]
 * fe:00:00:c3:5b:13    1.330s (       88.2)  fe:00:00:3b:9b:13 [    eth0]
node1# batctl n
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:c3:5b:13
(bat0/26:f5:9a:68:f5:2d BATMAN_V)]
IF             Neighbor              last-seen
fe:00:00:3b:9b:13    0.010s (      100.0) [    eth0]

-- Node 2 tables --

node2# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:3b:9b:13
(bat0/6a:5d:4e:09:dc:f4 BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF=
]
 * fe:00:00:31:ed:13    0.150s (      100.0)  fe:00:00:31:ed:13 [    eth0]
 * fe:00:00:c3:5b:13    0.080s (      100.0)  fe:00:00:c3:5b:13 [    eth0]
node2# batctl n
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:3b:9b:13
(bat0/6a:5d:4e:09:dc:f4 BATMAN_V)]
IF             Neighbor              last-seen
fe:00:00:31:ed:13    0.440s (      100.0) [    eth0]
fe:00:00:c3:5b:13    0.060s (      100.0) [    eth0]

-- Node 3 tables --

node3# batctl o
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:31:ed:13
(bat0/12:a7:e0:9e:f3:b6 BATMAN_V)]
   Originator        last-seen ( throughput)  Nexthop           [outgoingIF=
]
 * fe:00:00:3b:9b:13    0.100s (      100.0)  fe:00:00:3b:9b:13 [    eth0]
 * fe:00:00:c3:5b:13    0.200s (       88.2)  fe:00:00:3b:9b:13 [    eth0]
node3# batctl n
[B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/fe:00:00:31:ed:13
(bat0/12:a7:e0:9e:f3:b6 BATMAN_V)]
IF             Neighbor              last-seen
fe:00:00:3b:9b:13    0.300s (      100.0) [    eth0]
