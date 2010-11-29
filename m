Return-Path: <clang@gateworks.com>
From: Chris Lang <clang@gateworks.com>
In-Reply-To: <AANLkTikZJn5T7gEc_REH_vyEwhKhTcsqLRdq8tX0OdF8@mail.gmail.com>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTimR7VU95r3C-=C9rn5ftZahKkNTu3-cU-Vft+VZ@mail.gmail.com>
	<AANLkTikZJn5T7gEc_REH_vyEwhKhTcsqLRdq8tX0OdF8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 29 Nov 2010 14:31:50 -0800
Message-Id: <1291069910.7886.69.camel@chris-desktop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Fwd: BATMAN routing
Reply-To: clang@gateworks.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

All,

I figured I would throw out some stuff that I/we have been working on as
possibly some ideas that may help improve the routing algorithm, some of
these ideas are off subject of the current thread, and I apologize for
that, but all of the ideas are about the routing algorithm.

All of these implementations apply to batman advanced (layer 2, kernel
module).

First a little history, here at "Gateworks" I/we have been tasked with
implementing a MANET that is very mobile and has a host of different
types of configurations all under an "Open Source" license. We have
picked BATMAN as our base for implementation. One of the configurations
has 16 so called "tower" nodes that have a board with 4 radio's in it,
using 2 radio's as backhaul's and 2 radios connected to sectors to
distribute to so called "mobile" nodes. These mobile(32) nodes will have
either 1 or 2 radio's in them and will be either mounted on vehicles or
men. The other side of things is that we had to have this mesh network
work with any kind of network traffic including multicast (typically
video/audio traffic).

We have done a tremendous amount of testing in this type of
configuration with both unicast and multicast traffic and have made some
modifications that improve the scenario we are working with and the work
we have implemented is as follows, any comments, ideas, criticism, etc
are welcome:

- Implement RSSI into the routing decisions
This is accomplished by adding an rssi_penalty into each of the
orig_nodes that an OGM is received from, along with adding an rssi field
into the OGM. We grab the rssi value from the wireless interface
(currently through an ugly module dependency between madwifi and batman,
but could be done through wireless extensions) on a regular interval for
each mac address that the wireless device sees and and store this rssi
value in the orig table. We store this as a value between 0 and 40 with
0 being the highest quality and not adding any penalty to the OGM. Thus
the value stored in the orig table is really 40 - rssi. Then when a OGM
is sent out, it contains on rssi value of 0, when it is received by a
node, the rssi_penalty is read from the orig table for the node that
sent the OGM if it is greater then the rssi value stored in the batman
packet, it overwrites the value with the new rssi_penalty. Thus, on a
multiple hop link, the batman packet contains the rssi_penalty of the
weakest link. This value is then applied to the tq similar to how the
hop_penalty is applied when processing the OGM.

- Don't send multicast packets as broadcast packets
In the current implementation of BATMAN, multicast packets are sent as
broadcast packets and broadcast packets are sent 3 times. There are
inherent issues with this when sending a large amount of multicast
traffic. The other issue that came into play is that wireless devices
send broadcast/multicast traffic at 1MB by default, which can be
overcome by setting the multicast rate to a higher value, but is not an
acceptable solution in a mobile environment because the best rate is not
known and cannot be fixed. Now, just as an example, if we consider a 4
node mesh network where each node can route to each other and the nodes
occupy the same general RF space, then if a single multicast packet is
transmitted, it will really be sent 12 times (3 times by each node)
which will quickly create to much interference when using a large amount
of multicast. The idea was then to transmit the multicast as unicast
packets but to only transmit them done any given route one time. In the
example case I gave, this would reduce the total number of transmissions
of the packet to 3. This will also allow the packet to be transmitted at
a higher wireless rate due to it being unicast, and also helps to ensure
that the delivery of the packet is successful (not 100% obviously as
only link layer acks are being used and no network layer acks). In order
to determine where the packets should be sent, a new table is created
both for the batman interface (for new packets) and in each entry in the
orig table (for forwarded packets). A mcast_discovery packet is then
sent to each node on the given route to describe to whom they should
then forward the multicast traffic. Then a multicast packet is sent
along this same route. The route is updated periodically through the
mcast_discovery packets. Also, the mcast_discovery packets are not sent
out unless there is actual multicast traffic. The multicast still uses
seqno's and TTL in order to reduce duplicates. I won't go into further
detail unless requested to do so as it will just make this too long.
Further work is in process to also add IGMP snooping to only forward
packets to nodes that have joined the multicast group.

- Don't send out HNA's in OGM's, instead use multicast trasmission above
In order to reduce the size of OGM's, we have utilized the multicast
transmission described above to send out HNA's. This allow the
broadcasted OGM packets to be very small and use less RF space.

- Prod the routing algorithm to change routes when RSSI is dropping
We have added a starvation flag to the OGM's and we send out an OGM when
the RSSI of a link begins to be reduced with this starvation flag set.
When the OGM is received it is weighed heavier in order to encourage the
routing algorithm to make a different decision on how to route packets.

I apologize for the length of this email, but am trying to give a clear
picture of the implementations without going into too much detail.

We have all of the above working in a real world environment with a lot
of testing being completed, and with a lot more testing going to be done
in the coming weeks ( a lot more!!! ). I have patches (against r1828)
for all of the above but none in the quality that they need to be for
inclusion, and also I rely on some very ugly module dependencies that
are un-acceptable along with some modifications to the madwifi driver
(that are not neccessary for the above, but in the current code are
being used). But if there is interest in the work that we have done
above, I will begin to cleanup the code into a usable state.


Thanks for your time,

-- 
Chris Lang
Gateworks Corporation
3026 S. Higuera, San Luis Obispo, CA 93401
Ph: 805-781-2000 Fax: 805-781-2001
Email: clang@gateworks.com
Web: www.gateworks.com

> 
> > First we say the recently received OGMs will give a clear indication
> on
> the
> > reliability on the link, so we give the recently received OGMs from
> the
> > sliding window a priority in deciding the best next hop link towards
> a
> > destination. We want to count and add the indexes were an OGM was
> recorded
> > in an interval (seconds), (hence the recently received OGM will have
> more
> > weight). At the end the link with more recent OGMs will have more
> weight
> > and hence become the current best link.
> 
> This is a good idea. We are in the process of redesigning the current
> protocol
> and welcome any input. Giving older OGMs less "weight" was also one of
> the
> ideas we had. Would you mind explaining your concept in greater
> detail ?
> 
> 
> > I went through the source code so many times and I got few questions
> about
> > this:
> 
> Are we talking about the batman daemon source code or the batman-adv
> kernel
> module ? All my answers will refer to the kernel module as this is the
> place
> where most of the development is going on at the moment.
> 
> 
> > 1. What structure is used to keep track of the sliding window?  If
> its the
> > has how does it get updated based on the sliding packet range?
> 
> Each "struct orig_node" has a bitarray to keep track of its own seqnos
> repeated by its neighbors (bcast_own) and each "struct neigh_node"
> having a
> bitarray for its own OGMs (real_bits).
> 
> 
> > 2. How are the OGM's recorded, is in a form of binary where 1 will
> > represent the received OGM and 0 otherwise?
> 
> Correct.
> 
> 
> > 3. I looked in the source and still not sure of where the ranking
> decisions
> > are made, can you enlighten me on that?
> 
> You mean which function changes the route when a better neighbor was
> found ?
> That would be update_orig() in routing.c.
> 
> 
> > On the second approach we want to use mac layer stats to estimate
> the
> > signal strength and probably the congestion rate of the top N ranked
> links.
> > We acknowledge the fact that usually links with lower signal
> strength will
> > loose more OGM's which results in an automatic low rank, however in
> a
> > frequently changing topology, current signal strength is crucial. We
> plan
> > to use SNR or RSSI in this case.
> 
> The concept is known since a while but nobody has implemented it so
> far
> because its implementation is fairly complex. Do you have an idea how
> it
> should work in the end ?
> 
> 
> > 1. How can i get the RSSI/LQI of th neighbor links?
> 
> I don't get this question. You intend to use RSSI but you don't know
> how ?
> 
> 
> > I would really appreciate your opinions and advices in this regard
> more
> > specially how to go about implementing changes in BATMAN protocol.
> 
> This is a little abstract. Usually, we discuss specific concepts /
> ideas in
> our
> IRC channel or on the mailing list long before starting to implement
> them.
> The
> past has shown it is often better to let other people dive into your
> ideas
> and
> comment because routing is a rather complex subject.
> 
> As I mentioned above: We are in a redesign phase right now and welcome
> anyone
> interested to join. As the next step we envisioned a collection of
> routing
> scenarios in which the current implementation behaves poorly. All
> routing
> protocol changes have to go through this collection of scenarios to
> estimate
> its impact. What do you think about this idea ?
> 
> Regards,
> Marek


