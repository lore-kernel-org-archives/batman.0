Return-Path: <linus.luessing@web.de>
Date: Tue, 1 Jul 2014 10:50:28 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140701085027.GA2341@Linus-Debian>
References: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHxBzxWTprWsPASmNNGXQqj58LRuAHUkNVtXcWHc1PdoD_4+KA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Roaming issues in basic network
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Simon,

On Mon, Jun 30, 2014 at 07:22:51PM -0700, Simon Wong wrote:
> Let there be 2 wifi clients, client 1 and 2. Initially, both clients
> are wirelessly attached to node A. Client 2 can ping 1 and the nodes.
> Client 2 can also Telnet into node A and B, so all is fine.
> 
> I take client 2 and roam to node B. Client 2 can no longer ping client
> 1 and that is the issue.

At the Wireless Battle Mesh a few months ago we've been discussing
just such a (until now?) hypothetical problem. Maybe it applies here,
maybe it doesn't:

It could be a problem with a not yet updated MAC address table in
the bridge, therefore the bridge on node A not forwarding ICMP
requests from client 1 towards client 2.

Questions: Are your clients using IPv4, IPv6 or both? Are your
clients issuing gratuitous ARP replies or ICMPv6 unsolicited
Neighbor Advertisements upon roaming? Is this a permanent problem
or are clients 1 and 2 able to reach each other again after a
while? In your tests, did client 1 ping client 2 or the other way
round?

What you could try to check whether it is a problem with the
learning of the bridge is transforming them to stupid hubs on node
A and node B:

$ brctl setageing br0 0


Cheers, Linus
