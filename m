Return-Path: <andrew@lunn.ch>
Date: Wed, 16 Dec 2009 19:43:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091216184344.GK29768@lunn.ch>
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
	<200912092142.07700.onelektra@gmx.net>
	<375210.41936.qm@web111602.mail.gq1.yahoo.com>
	<200912111235.59060.onelektra@gmx.net>
	<4B291367.1050906@linux-migration.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B291367.1050906@linux-migration.net>
Subject: Re: [B.A.T.M.A.N.] general theory question RE: dhcp on a peer only
 mesh
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: jroland@linux-migration.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Wed, Dec 16, 2009 at 11:05:43AM -0600, Jon Roland wrote:
> Our design work needs to contemplate that a single mesh network will
> eventually span the planet (although it may need extra links to get from
> continent to continent)

Why? batman-adv works over wired as well as wireless links. Just use
Ethernet over SONET, or what ever your fiber run under the oceans.

> and involve billions of nodes. We are
> re-creating the Internet without trunk lines.

So you are proposing a flat layer 2 network with billions of
nodes. What do you think will happen to performance when billions of
nodes receive every ARP broadcast?

      Andrew
