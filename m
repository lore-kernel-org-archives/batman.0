From: Vojislav Marinkovic <vojislav@kth.se>
Date: Fri, 1 May 2009 12:51:30 +0200
Message-ID: <209743CECB91EB4F84169A51F300410D1F3137C403@MAIL02.ug.kth.se>
References: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>,
	<200904291059.45857.lindner_marek@yahoo.de>
In-Reply-To: <200904291059.45857.lindner_marek@yahoo.de>
Content-Language: sv-SE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Masters thesis
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello!

I have about 20 weeks to do the master thesis. This time includes: getting =
familiar with the protocol, gathering other information needed for the task=
, analysis, report writing, coding, presentation preparation and probably s=
ome more stuff that I can't remember right now.

Based on this list i would say that the tasks which could fit me are IPv6 s=
upport (the other tasks in this group seem to be more development towards t=
he OS) and "Improve Batman with regards to protocol overhead and convergenc=
e speed" (with a risk that it would only result in a report). Maybe IPv6 wo=
uld be more interesting to you guys since you would get something in return=
 for helping me out.

Another idea that came to my mind is building a B.A.T.M.A.N. module for ns2=
, and I have seen it being discussed here the last couple of days.

The easiest task for me would be IPv6 support. It would also give me the op=
portunity to get some in-depth knowledge about IPv6 and some hands-on exper=
ience with it. But I would need to check if my professor would accept this =
topic. Otherwise, I'm not a fastidious (I just learned a new word in Englis=
h :) ) person, so it wouldn't be a problem for me to do any of the tasks me=
ntioned above.

The next step is choosing one task and then making a thesis proposal, inclu=
ding a rough time-plan.

Any comments or suggestions?

Vojislav Marinkovic

________________________________________

one afternoon of work (at maximum):
*  Modify Batman-0.3.X code so we have an option to compile it without
policy routing support
*  Modify the way that Batman-Advanced (Layer 2) deals with
broadcast/multicast payload packages (on multihop wireless routes there
is always packet loss, protocols like DHCP use broadcast or multicast
messages which are not send redundantly and not acknowledged, so these
protocols which are not designed to deal with a high level of packetloss
have difficulties to work on a Layer 2 mesh as the number of hops and
packet loss on the media increases)

several weeks of coding effort (including tests):
*  Modify Batman-0.3.X  in order to support IPv6
*  Get support for other operating systems working (so far it only works
with Linux) -> depends on your knowledge of "other" systems
* merge batman adv userspace & kernelland code to reduce the maintenance
overhead
* automatic interface bonding for better throughput (layer 2)

requires in depth knowlegde about batman:
*  Improve Batman with regards to protocol overhead and convergence speed

mt. everest:
*  Implement a minimalistic and power saving Batman client version for
embedded mobile devices (requires extensive knowledge of 802.11 power savin=
g
mechanisms and how to bring them into the mesh)
* multipath routing (as it always appears over and over again:
http://en.wikipedia.org/wiki/Multipath_routing)
_______________________________________________
