Message-ID: <4672937F.3040208@poelzi.org>
Date: Fri, 15 Jun 2007 15:26:23 +0200
From: poelzi <poelzi@poelzi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Small feature request
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

Hi,

I got a interessting paper forwarded which discussed routing in tcp on
ad-hoc networks (especially tcp vegas). The idea was like that:
If the routing protocol notices the tcp stack that the route has
changed, it can recalculate some of its parameters (here the BaseRTT
value) to optimize speed.

Implementing meshferry, a tcp over udp proxy to surround most of tcp
problems, I can see a lot of usage for this. Because batman doesn't know
the topology itself, i thought about a mechanism to detect route changes
without knowing topology itself.

All batman originator packets would become an additional flag, lets say
uint32. When batman starts, it generates a random uint32 for its
complete runtime.
On a new broadcast message, it sets this new flag to his own random
value. If it rebroadcasts a message, it used the original value XOR its
own. This mechanism detects route changes very likely and even batman
restarts.

If the this new flag changes, the route somewhere in the network has
changed, it can't say where, but it doesn't have to.

The operations are cheap, the overhead is small. And allows analysis if
routes are more static or switching (would be interessting to see).

Long term I was thinking about a socket interface between routing daemon
and transport daemon. For the case of switching routes, batman would
then notify the route to host x has changed somehow, so he can optimize
his parameters.

kindly regards
 daniel
