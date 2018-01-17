Return-Path: <Alex.Linchieh@gd-ms.ca>
From: "Linchieh, Alex" <Alex.Linchieh@gd-ms.ca>
Date: Wed, 17 Jan 2018 23:41:47 +0000
Message-ID: <EAA43A4A33E954458F0C43C14387663A631A4567@ottsvw192.gdcan.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Simple Multicast on Batman-Adv
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

Hello,

I am having some issues getting simple multicast to work under batman-adv (=
2017.4).

I have isolated the system as much as I can to reduce any uncertainties ass=
ociated with wlan. My test environment consists of 4 virtual machines (ubun=
tu server 17.10) that are connected to each other via an internal ethernet =
network. I have been able to get the bat0 interface working over the ethern=
et interface (enp0s3). I am able to get the devices to ping eachother over =
the batman mesh as well as send iperf test data via TCP and UDP unicast mod=
es. However I have not been able to get multicast running properly over the=
 bat0 interface.

The commands I am using to initialize batman-adv on each of the virtual mac=
hines are as follows:

Sudo modprobe batman-adv
Sudo ifconfig enp0s3 up
Sudo batctl if add enp0s3
Sudo ifconfig bat0 192.168.14.x/24	where "x" is replaced with a number depe=
nding on the VM
Sudo route add -host 239.255.10.10 bat0

I am using iperf in order to generate multicast traffic from the iperf clie=
nt (192.168.14.1), and the iperf servers (192.168.2, 3, 4). The client whic=
h generates multicast data is able to "connect" to the multicast address an=
d send data. Iperf also shows that the servers are able to subscribe to the=
 multicast address however this is as far as I can get because the multicas=
t data does not appear to ever reach the subscribers. When I use tcp dump t=
o monitor the bat0 interfaces on these devices, I can see outgoing multicas=
t traffic from the multicast sender, however the bat0 interface on the mult=
icast receivers does not show anything, so it looks like none of the multic=
ast traffic seems to be reaching any of the subscribers (or perhaps the mul=
ticast subscribers aren't able to communicate that they are subscribed to t=
he multicast address).

I have tested this with "batctl mm" set to both enabled and disabled. In ad=
dition, when I try to run "batctl mf" it says that I am not connected to a =
mesh (even though I am).

I have also duplicated this test using just the internal Ethernet network (=
static IP addresses, batman disabled) and muilticast seems to work fine. Th=
is leads me to believe that there is something with batman-adv that I am ov=
erlooking.

If anyone could shed some light on enabling multicast on batman that would =
be greatly appreciated.

Thanks,
Alex


