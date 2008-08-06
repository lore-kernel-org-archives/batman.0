From: Axel Neumann <axel@open-mesh.net>
Date: Wed, 6 Aug 2008 15:20:59 +0200
References: <7itzdzzero.fsf@lanthane.pps.jussieu.fr>
In-Reply-To: <7itzdzzero.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808061520.59927.axel@open-mesh.net>
Subject: [B.A.T.M.A.N.] Re: A few comments on the BATMAN routing protocol
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
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Cc: elektra@open-mesh.net, b.a.t.m.a.n@open-mesh.net, siwu@hrz.tu-chemnitz.de, olsr-users@lists.olsr.org, babel-users@lists.alioth.debian.org, lindner_marek@yahoo.de, Roman Steiner <roman@steinerweb.at>

Hello!

I also want to thank you a lot for your good comments.
And by the way add my two cents (mostly inline) :-)
I also want to point out that the draft does not represent the latest state of 
our implementations. When we started to write the draft we had to start with 
something well tested and understood. So we decided to to take the protocol 
as implemented in batman-0.2 as a basis. Some time has passed since then...

On Dienstag 05 August 2008, Juliusz Chroboczek wrote:
> Dear all,
>
> For some time now, I've been wanting to comment on the BATMAN
> protocol.  The following are my conclusions from a careful reading of
> the BATMAN draft dated 7 April 2008, as well as a number of
> enlightening conversions with Aaron Kaplan and Roman Steiner, to both
> of whom many thanks.
>
> BATMAN is an eminently original protocol, and one that contains
> a number of very interesting ideas.  However, it is my opinion that in
> its current state, BATMAN has a number of flaws that are serious
> enough to warrant a redesign.
>
> The above statement must be taken with a pinch of salt, for at least
> two reasons.  First, there are a number of subtle points in BATMAN
> that I do not fully understand, so my assessment may be wrong.
> Second, it is not clear to me to what extent the BATMAN implementation
> corresponds to the draft; it may be the case that the implementation
> fixes some of the issues outlined below in ways that are not described
> in the draft.
>
>
> Summary
> *******
>
> The following are the issues I see with BATMAN, in roughly decreasing
> order of importance:
>
> 1. BATMAN's convergence is exponential in the diameter of the network
>    in the presence of packet loss.

I agree! In case of packet loss, there is the issue with the exponentially 
decreasing probability for an OGM to make it up to the nth hop. And in fact, 
this problem is faced by every other IP packet as well. 
Usually you dont want to use a tcp session to a distant node over multiple 
lossy links because chances for you TCP/IP packets to reach its final 
destination exponentially decrease with every hop. This way, there could be a 
natural mechanism to not maintain routes to nodes which you do not want to 
communicate with anyway. 
Unfortunately, the exponents of these two exponential decreasing examples are  
different. The reason for the different exponent is that the 802.11 stack 
usually retransmits unacknowledged unicast packets several times before 
giving up. BatMan-eXperimental (BMX) aims to approximate the real exponent by 
also sending OGMs multiple times in independent broadcast datagrams. If 
packet aggregation is enabled (see later on) the additional protocol-traffic 
overhead does not hurt to much because the second OGM transmissions can 
simply be attached to the next independent OGM aggregation send by this node.

>
> 2. BATMAN does not contain any loop avoidance mechanisms; in the
>    presence of so-called ``optimistic routing'', BATMAN may exhibit
>    persistent routing loops.  Even without optimistic routing, BATMAN
>    will exhibit transitory routing loops.

Here I completely agree with what Simon Wunderlich said. Personally, I am not 
aware of any scenario that can lead to transient routing loops, not even to a 
dead node! You might know better, then pleas let me know :-)

Each batman node is only supposed to rebroadcast an OGM which it has received 
from the neighbor which it has configured itself as its best nexthop to the 
destination. Therefore, the OGM itself must have travelled a valid path with 
all traversed nodes having a loop free route configured towards the 
originator of the OGM. Of course, the configured end-to-end route might break 
down somewhere along the path just after an OGM has been received. This will 
cause a temporary dead route. But not a loop. Later on, only a newer OGM 
(with a larger sequence number), and which once again must have traversed a 
functional and configured path, can reconfigure any node receiving this OGM.

Another remark:
The batmand-0.2 implementation is not doing this completely correct and thus 
can cause temporary routing loops. The reason is, that it also reconfigures 
its best nexthop due to new OGMs which were not received via its currently 
*best-known* nexthop.

>
> 3. The metric used by BATMAN is not realistic, and will cause it to
>    strongly favour long hops over multiple short ones and to favour
>    asymmetric links taken ``the wrong way''.

There has been a lot of discussion about this shortcomings of batmand-0.2 
during the WCW2007 in Graz [1,2,3] and the WCW2008 in Berlin. 
The MARK IV algorithms and 0.3 implementations consider this shortcoming. 

>
> 4. Since BATMAN does not perform any aggregation of messages into
>    packets, it is inefficient on link technologies with an important
>    per-frame overhead (such as IEEE 802.11).

Two week ago I had the chance to look around in the Leipzig Freifunk net. They 
have recently integrated batman-experimental with packet aggregation by 
default into the leipzig freifunk firmware (the aggregation wraps upto 25 OGM 
into a sigle 300 bytes packet).  By that date the randomly examined nodes 
showed about 150 other batman nodes in their routing table (but there were 
more batman nodes beyond the individual horizon of the examined nodes). The 
firmware also collects statistics about routing protocol-traffic overhead. 
The statistics  showed a pretty much similar traffic overhead to olsr. In 
dense areas the overhead of bmx (with an originator interval of 1 second) 
seemed even a bit less than that of olsr while at the edges of the mesh it 
was the other way around.

>
> 5. Jitter is not compulsory, which may lead to persistent series of
>    collisions.

It is indeed a problem in hidden node scenarios where 802.11 jitter does not 
help ([4] might be interesting). But when packet aggregation is enabled OGMs 
are hold back before being aggregated and rebroadcasted. So you have an 
inherent jitter anyway.

ciao,
axel


[1] WCW2007 Graz 
http://open-mesh.net/batman/experience/WCWGraz2007/batman_Graz_WCW_2007.pdf

[2] Tradeoff: Long versus short but poor-link paths:
http://downloads.open-mesh.net/batman/development/sources/batmand-exp_0.3-alpha-current_sources/doc/bmx/bmx.html#SECTION10044000000000000000

[3] The impact of asymmetric links:
http://downloads.open-mesh.net/batman/development/sources/batmand-exp_0.3-alpha-current_sources/doc/bmx/bmx.html#SECTION10045000000000000000

[4] Re-broadcast delay:
http://downloads.open-mesh.net/batman/development/sources/batmand-exp_0.3-alpha-current_sources/doc/bmx/bmx.html#SECTION10043000000000000000











>
>
> 1. Exponential convergence
> --------------------------
>
> Consider the following network topology, where all links have a 40%
> packet loss rate:
>
>      A1---A2---A3---A4
>     /                 \
>    /                   \
>   S                     C
>    \                    |
>     \                   |
>      B1---B2---B3---B4--B5
>
> Assume an OGM broadcast interval of 1, C will receive one OGM from
> S every 13 seconds through the A route, and one OGM from S through the
> B route every 21 seconds.
>
> Suppose now that A1 crashes.  Then C has no indication that the
> B route is better than the A route until the next OGM from S through
> B, which will happen after roughly 10 seconds on average.
>
> More generally, the time for C to switch to the fallback route is
> proportional to (1-a)^-k, where a is the per-link loss rate, and k is
> the number of hops on the fallback route.
>
>
> 2. Persistent loops
> -------------------
>
> BATMAN does not contain any loop avoidance mechanisms, nor any for
> loop detection.  Because of that, BATMAN will cause routing loops in
> some cases which will last up to PURGE_TIMEOUT seconds (256 seconds by
> default).
>
> Indeed, consider the following topology:
>
>                 A
>              l1/|
>               / |
>              S  |l3
>               \ |
>              l2\|
>                 B
>
> Suppose also that l2 is a very lossy link, so that B has selected A as
> its next hop for S.
>
> S crashes, and A switches to B as its next hop for S.  At this point,
> B is still using A as its next hop, so we have a temporary routing loop.
>
> After one window time, both A and B are performing opportunistic
> routing (Section 6.3.1 of the draft) and hence form a routing loop.
> I may be missing something, but as far as I can tell, the loop will
> only be eliminated after a PURGE_TIMEOUT.
>
> Due to the convergence issues outlined in point (1) above, BATMAN
> needs the opportunistic routing mechanism.  However, even in the
> absence of opportunistic routing, transient loop will arise for up to
> one window time.
>
>
> 3. Unrealistic metric
> ---------------------
>
> BATMAN does not explicitly use a metric, it ranks routes according to
> the OGM success probability.  Since OGM propagation requires
> correlated successes over all the links of a route, the resulting
> metric is
>
>   1/product(a_i)
>
> where a_i are the loss probabilities of all the links in the route.
>
> This metric does not accurately reflect the cost of a route for two
> reasons:
>
>   (i) it assumes there is no link-layer ARQ, which is not the case in
> 802.11; (ii) it only reflects probability in the backward direction.
>
> Point (i) will cause BATMAN to favour long hops over multiple short
> ones.  Point (ii) will cause BATMAN to take asymmetric links in the
> wrong direction.
>
>
> 4. No message aggregation
> -------------------------
>
> Most routing protocols send their routing tables as a short sequence
> of large packets.  For example, Babel sends up to 100 routing updates
> in a single full-size packet; similar techniques are used in OLSR,
> where the link-state database is sent in as few packets as possible.
>
> BATMAN sends each OGM in its own packet.  This will cause a signi-
> ficant supplementary cost on link-layer technologies on which
> per-frame overhead is siginificant, such as IEEE 802.11 (with no
> 802.11e frame bursting).
>
>
> 5. Jitter is optional
> ---------------------
>
> Section 5.1 of the draft says that ``jitter may be applied to avoid
> collisions''.  Since collisions in the absence of jitter tend to cause
> global synchronisation and persistent series of collisions, I believe
> that this should be a MUST.
>
>
> Acknowledgements
> ****************
>
> Thanks to Aaron Kaplan and Roman Steiner for discussing a number of
> the points above with me.
>
>
>                                         Juliusz Chroboczek


