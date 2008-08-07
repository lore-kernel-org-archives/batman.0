Message-ID: <489B4666.3020106@gmx.net>
Date: Thu, 07 Aug 2008 21:00:54 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] A few comments on the BATMAN routing protocol
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
To: b.a.t.m.a.n@open-mesh.net

Hi -


somehow the initial posting from Juliusz (jch@pps.jussieu.fr 
Juliusz.Chroboczek@pps.jussieu.fr) got lost.


elektra



Dear all,

For some time now, I've been wanting to comment on the BATMAN
protocol.  The following are my conclusions from a careful reading of
the BATMAN draft dated 7 April 2008, as well as a number of
enlightening conversions with Aaron Kaplan and Roman Steiner, to both
of whom many thanks.

BATMAN is an eminently original protocol, and one that contains
a number of very interesting ideas.  However, it is my opinion that in
its current state, BATMAN has a number of flaws that are serious
enough to warrant a redesign.

The above statement must be taken with a pinch of salt, for at least
two reasons.  First, there are a number of subtle points in BATMAN
that I do not fully understand, so my assessment may be wrong.
Second, it is not clear to me to what extent the BATMAN implementation
corresponds to the draft; it may be the case that the implementation
fixes some of the issues outlined below in ways that are not described
in the draft.


Summary
*******

The following are the issues I see with BATMAN, in roughly decreasing
order of importance:

1. BATMAN's convergence is exponential in the diameter of the network
    in the presence of packet loss.

2. BATMAN does not contain any loop avoidance mechanisms; in the
    presence of so-called ``optimistic routing'', BATMAN may exhibit
    persistent routing loops.  Even without optimistic routing, BATMAN
    will exhibit transitory routing loops.

3. The metric used by BATMAN is not realistic, and will cause it to
    strongly favour long hops over multiple short ones and to favour
    asymmetric links taken ``the wrong way''.

4. Since BATMAN does not perform any aggregation of messages into
    packets, it is inefficient on link technologies with an important
    per-frame overhead (such as IEEE 802.11).

5. Jitter is not compulsory, which may lead to persistent series of
    collisions.


1. Exponential convergence
--------------------------

Consider the following network topology, where all links have a 40%
packet loss rate:

      A1---A2---A3---A4
     /                 \
    /                   \
   S                     C
    \                    |
     \                   |
      B1---B2---B3---B4--B5

Assume an OGM broadcast interval of 1, C will receive one OGM from
S every 13 seconds through the A route, and one OGM from S through the
B route every 21 seconds.

Suppose now that A1 crashes.  Then C has no indication that the
B route is better than the A route until the next OGM from S through
B, which will happen after roughly 10 seconds on average.

More generally, the time for C to switch to the fallback route is
proportional to (1-a)^-k, where a is the per-link loss rate, and k is
the number of hops on the fallback route.


2. Persistent loops
-------------------

BATMAN does not contain any loop avoidance mechanisms, nor any for
loop detection.  Because of that, BATMAN will cause routing loops in
some cases which will last up to PURGE_TIMEOUT seconds (256 seconds by
default).

Indeed, consider the following topology:

                 A
              l1/|
               / |
              S  |l3
               \ |
              l2\|
                 B

Suppose also that l2 is a very lossy link, so that B has selected A as
its next hop for S.

S crashes, and A switches to B as its next hop for S.  At this point,
B is still using A as its next hop, so we have a temporary routing loop.

After one window time, both A and B are performing opportunistic
routing (Section 6.3.1 of the draft) and hence form a routing loop.
I may be missing something, but as far as I can tell, the loop will
only be eliminated after a PURGE_TIMEOUT.

Due to the convergence issues outlined in point (1) above, BATMAN
needs the opportunistic routing mechanism.  However, even in the
absence of opportunistic routing, transient loop will arise for up to
one window time.


3. Unrealistic metric
---------------------

BATMAN does not explicitly use a metric, it ranks routes according to
the OGM success probability.  Since OGM propagation requires
correlated successes over all the links of a route, the resulting
metric is

   1/product(a_i)

where a_i are the loss probabilities of all the links in the route.

This metric does not accurately reflect the cost of a route for two
reasons:

   (i) it assumes there is no link-layer ARQ, which is not the case in 
802.11;
  (ii) it only reflects probability in the backward direction.

Point (i) will cause BATMAN to favour long hops over multiple short
ones.  Point (ii) will cause BATMAN to take asymmetric links in the
wrong direction.


4. No message aggregation
-------------------------

Most routing protocols send their routing tables as a short sequence
of large packets.  For example, Babel sends up to 100 routing updates
in a single full-size packet; similar techniques are used in OLSR,
where the link-state database is sent in as few packets as possible.

BATMAN sends each OGM in its own packet.  This will cause a signi-
ficant supplementary cost on link-layer technologies on which
per-frame overhead is siginificant, such as IEEE 802.11 (with no
802.11e frame bursting).


5. Jitter is optional
---------------------

Section 5.1 of the draft says that ``jitter may be applied to avoid
collisions''.  Since collisions in the absence of jitter tend to cause
global synchronisation and persistent series of collisions, I believe
that this should be a MUST.


Acknowledgements
****************

Thanks to Aaron Kaplan and Roman Steiner for discussing a number of
the points above with me.


                                         Juliusz Chroboczek

