Return-Path: <dbeberman@gmail.com>
MIME-Version: 1.0
Date: Thu, 23 Jun 2011 11:51:40 -0400
Message-ID: <BANLkTimmgkGAXscfEJHwKYoUgEuLL4Oc=Q@mail.gmail.com>
From: David Beberman <dbeberman@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] previous tangentially related broadcast issue --
	info on MAC80211
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

This is probably well understood by the engineers working on
the Linux Wireless layer and those on the batman-adv project.
I'm just a user trying to figure out what the best use of the
protocol is for my application.  This is a follow up explanation
for the behavior I have been seeing.

I walked through the MAC80211 layer.  There are rate control
algorithms that are loaded as modules.  Currently there seems to be
two of them, but more can be registered.  Each of these appears to
check individually for multicast and broadcast packets.  Each
broadcast packet uses the lowest basic rate available.  The multicast
packets use a basic rate from the BSSBasicRateSet that can be user
defined.
I believe, but have not verified, that batman-adv uses the broadcast
address (FF:FF:FF:FF:FF:FF) for broadcast and multicast packets.  The
MAC80211 layer then uses the lowest basic rate available, which in my
case, with a mixed b/g/n is 1 Mbps.

For what I am trying to do, this is a problem.  However, I would not
call this a problem with batman-adv or MAC80211 in general.
I can obviously do a hack for my own uses that looks into the packet
in the MAC80211 layer to determine if it is a batman-adv broadcast
packet and use a different rate.  Maybe I can change batman-adv to use
a multicast MAC address and pick up the fixed multicast rate that I
can configure in MAC80211.  None of this should be a general change
for either module.

Also, last time I looked through the batman-adv code, it did not have
a multicast implementation from what I could tell.  Seemed like
multicast was mapped onto a general broadcast approach.  Since my
application requires all nodes to send to all other nodes in the
system (full mesh), it seemed like broadcast was the best solution,
and the docs I read said the same thing.

Just thought I'd post a follow up on the broadcast data rate issue in
case anybody reads through an archive on this, and wanted to
see any resolution to the questions.

Also, I saw a question about whether I had turned on aggregation when
I increased the OGM rate from 1000 to 100 msecs.  Apologies, but I do
not remember.  I believe I tried it both ways.
I was hoping for a decision to go to a multi-hop route would occur
faster with a higher OGM rate, when I was using unicast UDP traffic,
and my nodes were moving apart.  Instead, I found that the decision to
go to multi-hop route appeared to take longer.  Could easily have been
configuration and user error on my part.  I was using the batctl ping
with the routing flag to see what the route to look at the behavior.

Regards,
David Beberman
