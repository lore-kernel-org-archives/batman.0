Return-Path: <locborgtus@gmail.com>
MIME-Version: 1.0
Date: Mon, 30 Jun 2014 19:22:51 -0700
Message-ID: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>
From: Simon Wong <locborgtus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Roaming issues in basic network
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hi list,

I'm new to batman-adv, and I'm setting up some basic tests to verify
my use case. I'm running into a roaming issue.

Consider a basic 2 node network running batman-adv 2014.2 with default
settings on OpenWRT AA. Let the routing nodes be A and B. Each node
has 2 wireless interfaces. wlan0 is for the mesh, and wlan0 is AP. The
interfaces are bridged per the batman start guide.

Let there be 2 wifi clients, client 1 and 2. Initially, both clients
are wirelessly attached to node A. Client 2 can ping 1 and the nodes.
Client 2 can also Telnet into node A and B, so all is fine.

I take client 2 and roam to node B. Client 2 can no longer ping client
1 and that is the issue.

If 2 roamed back to A, pings to 1 is good again. A few more
observations while pings are no good:

1) Client 2 can ping the nodes and the Telnet sessions to the nodes are fine.
2) Node B local translation table says 2 is at B, node A local
translation table says 1 is at A. So the local translation tables
check out.
3) Both nodes A and B can ping client 1, so client 1 is still up.
4) Running 'batctl td wlan1' on node 1 shows ICMP requests and
replies, but 'batctl td bat0' shows only requests. So client 1 is
getting the ICMP packets and is responding.
5) If I ran 'iw wlan1 station del <client 2 mac>' on node 1, pings
will work again.

It almost looks like the wifi driver (ath5k) is blocking data for
roamed clients that was once attached to it. So this issue might not
be a batman but a driver thing. Has anyone ran into this problem?

Thanks,

Simon
