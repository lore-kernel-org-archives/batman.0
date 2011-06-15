Return-Path: <dbeberman@gmail.com>
MIME-Version: 1.0
Date: Wed, 15 Jun 2011 18:04:41 -0400
Message-ID: <BANLkTi=HCdWDjTQER8uOP48RW-XsZ6ehaQ@mail.gmail.com>
From: David Beberman <dbeberman@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] tangentially driver related question on broadcasts
	with batman-adv
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

Hi,
I'm using batman-adv in two different ways.
The first is what it is meant for, mesh routing.=A0 Apologies if that
is not the correct technical term.

The second way I'm using it is to take advantage of broadcasting
as a simply floodfill algorithm.=A0 All of my nodes transmit to all other n=
odes
on a periodic basis.=A0 This is an IPv6 local multicast.=A0 I believe this
translates to 802.11 MAC FF:FF:FF:FF:FF:FF broadcast address, and
everything works.

What I noticed with a network sniffer is that all of the broadcasts were se=
nt
with 1 Mbps data rate.=A0 For some of my systems, I was able to force
the rate to a fixed value:=A0 iwconfig wlan0 rate 5.5M
for example.

For other systems, the command is accepted but the broadcast rate
stays at 1Mbps.
The systems that show this are laptops running Intel iwlagn drivers,
as well as external USB Linksys (USB600N) devices with Ralink drivers.
I tried both the ubuntu kernel 2.6.32-29-generic and also upgraded
it to 2.6.39 downloaded directly from kernel.org.
I thought that perhaps the ad-hoc fixed rate behavior might not be
implemented in the mac80211/cfg80211 in the earlier kernel versions.

I'm running the batman-adv 2011.1.0 release.

What I would really want is some way to flood packets to all of my
nodes from all of my nodes on a periodic basis.=A0 That is, this is a
full mesh connection situation.
I would somehow like to still take advantage of higher data rates when
nodes are closer to each other.=A0 Unfortunately, broadcasts do not have
full CSMA/CA, only CSMA, so no feedback to do data rate management (I
think).

Does anyone have experience with using the wireless extensions
(iwconfig, wpa_supplicant, wpa_cli, etc.), or the newer "iw" commands
to get broadcasts to occur at different data rates in ad-hoc mode?

Also:
I have tried using unicast packets one for each connected pair and let
the batman-adv next-hop routing forward the packets.=A0 This does work
in a reasonably stable system.=A0 The problem is that my nodes have a
fairly short data transmit period on the order of 1 second.
The nodes are moving around relative to each other also on the order
of a few seconds.
The routing resolution based on link quality works on the order of 30+
seconds.=A0 Thus there can be loss of traffic for a significant period
relative to 1 second periods.
I did up the OGM rate, 100 msec and even 10 msec just to experiment.
This actually seemed to reduce the next-hop decisions, based on the
batctl ping results.
From what I can tell reading the algorithms written in the
documentation, all next hop decisions are based on link quality. Link
quality using
roundtrip metrics of broadcast packets.
Broadcast packets are transmitted at 1Mbps in my systems, thus the
link quality for 2 nodes at a distance that uses 1 Mbps data rate is
the same as the link quality for 2 nodes that could use much higher
data rates.
Since my objective is to deliver the same packet from each source node
to all other nodes, using next-hop routing, I end up with my data
rates dropping to the minimum to reach the maximum operational
distance nodes, even if there are a bunch of nodes in between.

When I broadcast, the data rate stays constant and as long as a node
can hear at least one other node, it gets all the periodic data from
all other nodes.

If this makes sense to someone, or I'm missing something obvious,
please feel free to clue me in.

My next step is to getting into the transmit control flow in the WLAN
device drivers for each piece of
hardware and see if I can hard code the transmit data rate for
broadcast packets.=A0 Usually there is
a control header for each transmit frame sent to the
hardware/firmware.=A0 Finding it, and understanding it
without documentation is a challenge I've been hoping to avoid.

Any help would be appreciated.
The only help I can offer in return is that I figured out how to
change the operating channel on the Broadcom bcm4329 driver for the
HTC Desire in
ad-hoc mode. There are a couple of minor errors in the wireless
extension handling code.
Someone might find that useful.

Regards,
David Beberman
