References: <7ifxp3v86m.fsf@lanthane.pps.jussieu.fr>
	<200808210742.53261.axel@open-mesh.net>
From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Date: Wed, 27 Aug 2008 18:26:11 +0200
In-Reply-To: <200808210742.53261.axel@open-mesh.net> (Axel Neumann's message
	of "Thu\, 21 Aug 2008 07\:42\:53 +0200")
Message-ID: <7id4juo258.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] Re: [Babel-users] A few more comments on the BATMAN
	routing protocol
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
To: Axel Neumann <axel@open-mesh.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>, olsr-users@lists.olsr.org, babel-users@lists.alioth.debian.org

>> My claim that there exist topologies in which average-case convergence
>> of BATMAN is exponential in the number of hops has been confirmed by
>> two of the BATMAN developers.  I still believe this to be a very
>> significant flaw of BATMAN.

> Packet loss increases also the count of OGMs that trigger a route switch 
> decreases.

I realise that.  The trouble is that the time needed to reconverge is
proportional to the product of the link qualities, and not to the sum
of the link qualities, as is the case in Babel and in OLSR.

> Now let's come to the worst case. Again two paths that are 
> non-overlapping. One is terrible, 99% loss. The other is perfect, no 
> loss.

As I mentioned in my point 3, the packet loss, as measured by BATMAN,
is not realistic in the presence of link-layer AQM.  As you know,
IEEE 802.11 does perform link-layer AQM for unicast packets.

A 10-hop route with each link having 20% loss will be measured by
BATMAN as a route with 90% loss.  However, with 7-persistent per-hop
AQM (the IEEE 802.11 default), such a route has an effective loss rate
of roughly 10^-4, and is therefore quite usable by standard transport-layer
protocols such as TCP.  (In case this is not clear to you -- this is
brilliantly exposed in the original ETX paper.)

Hence, my claim that BATMAN converges in exponential time stands, even
if you restrict yourself to routes usable by TCP.

> All versions of Batman benefit from the fact that they don't produce 
> much protocol overhead (small amount of data that needs to be 
> communicated, OGM flooding is only flooded exclusively via the best 
> routing path to a destination).

Given a network with n nodes and e edges, BATMAN sends O(n^2) packets
per unit of time, Babel sends O(n^2) messages, and OLSR sends between
O(e) and O(e.n) depending on the MPR redundancy.

I fail to see how that relates to the fact that BATMAN converges in
exponential time in the network diameter.

                                        Juliusz
