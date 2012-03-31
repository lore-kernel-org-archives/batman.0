Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
Date: Sat, 31 Mar 2012 16:22:06 -0600
Message-ID: <CAA_JP8UrWSzLYoUEhrzbT1fjeedp28B0dr7dMB_TizLkr+4RNg@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] any throughput mechanism or plans?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I can't see anything in my reading on this.

Is there a mechanism to identify throughput between two nodes? or
between a client and a destination for the purpose of routing through
the highest throughput path?

For instance, track the maximum throughput on each interface over
time. Compare it to the current throughput on the interface and send
what is leftover as 'available throughput' with the TQ each node.  Now
instead of adding up the numbers as with TQ, just take the min.  Take
the lowest throughput along the path and have a node be able to
utilize the highest throughput path that has acceptable TQ.  As a
node's interface gets loaded up (vs observed maximum) it will inform
it's neighbors in the same way it informs them of the TQ of each
interface and then the neighbors can choose to route around if there
is a good alternate path.

Basically, I'm thinking that TQ isn't the only or most optimal way to
route simply because available throughput should be considered
somehow.  As far as I can tell, a 56k link with .001% packet loss is
better than a 54Mb link with .1% packet loss, though both are solid
interfaces and the 54Mb link should be prefered heavily over the 56k
link.  The 56k link probably will start dropping packets once it is
saturated, but one client might run up against slow ACKs keeping the
remote server from sending enough data to saturate the connection so
the client could be getting a very slow connection while a 54Mb link
sits virtually unused.
