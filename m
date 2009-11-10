Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 10 Nov 2009 18:34:41 +0800
References: <20091109190206.GA2642@Linus-Debian>
In-Reply-To: <20091109190206.GA2642@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200911101834.41970.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tuesday 10 November 2009 03:02:06 Linus L=FCssing wrote:
> We were trying about 5 random network cards we had available here in
> our cellar and they all were not able to increase the MTU
> (including my laptop's BCM5787M GB-ethernet card). So at the
> moment I'm truely considering to also switch those Dlink routers
> back to an MTU of 1500 for the sake of compatibility at least on
> local area networks.

Sure, as I said: not all cards / drivers support that feature.


> The motivation of using a higher MTU of 1524 at the beginning was
> the rumour, that there might be some client devices (which we
> would get into the network by bridging bat0 wifi wlan0 for
> instance) not able to handle any MTU smaller than 1500. But in
> fact it turned out, that in our days basically all devices are
> able to do both IPv4 and IPv6 PMTU discovery on layer 3. So tests
> showed, that if all BATMAN nodes are using an MTU of 1476 on bat0
> (or the overlaying bridge) everything seems to work fine.

Sorry, I can't follow you here. If the whole network is a switch environmen=
t=20
how could the clients perform a working PMTU ? Sure, all clients are able t=
o=20
do PMTU (I don't think somebody doubted that) but it won't work.  :)
Client sends 1500 bytes -> router receives the frame (no IP!) and drops the=
=20
packet. Where should the "fragmentation needed" packet come from ? That onl=
y=20
works if you route packets instead of switching them.


> Usually you are choosing UDP mode in tinc, any ethernet frame inside of t=
his
> will then be encapsulated in this. But if tinc discovers, that the packet
> will be too big to fit through this link and the PMTU tinc discovered for=
 it,
> it will do TCP encapsulation instead to let the kernel fragment the packet
> automatically.

That is nice but only works because tinc uses IP addresses (unlike batman-
adv). AFAIK you use tinc to connect internet endpoints, hence your packet=20
probably looks like this:=20
[ETHER][IP][UDP/TCP][BATMAN-HDR][PAYLOAD]
whereas the packets sent by batman-adv look like this:
[ETHER][BATMAN-HDR][PAYLOAD]


> As in a mesh network usually not an internet uplink but the wifi
> is very likely being the bottleneck, the extra overhead on the
> internet uplinks created by fragmentation might not be "harmful"
> for the network average bandwidth. And as also the packet loss on
> an internet uplink not running on its bandwidth limit is very,
> very low, latencies shouldn't increase too much.

I think you underestimate the performance impact. AFAIK IPv6 does not suppo=
rt=20
the clasical IPv4 fragmentation anymore (intermediate routers won't fragmen=
t=20
the packets but drop them).

Regards,
Marek
