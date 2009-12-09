Return-Path: <andrew@lunn.ch>
Date: Wed, 9 Dec 2009 07:34:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091209063411.GJ29768@lunn.ch>
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Tue, Dec 08, 2009 at 08:24:01PM -0800, George Sanders wrote:
> 
> 
> This is not a BATMAN specific question, but I see very clueful chatter here and would appreciate any comments.
> 
> My question is:
> 
> Who provides IP addresses in a truly ad-hoc, truly "peer only" mesh network ?

One option is IPv6 and link local addresses. These are derived from
the MAC address, plus duplicate address detection, to ensure the IP
address is unique. http://tools.ietf.org/html/rfc4862

Another option is zeroconf, http://en.wikipedia.org/wiki/Zeroconf, 
http://tools.ietf.org/html/rfc3927.

Another option is statically configure all the boxes with a unique IP
address from a well know subnet. It is often worth remembering that a
truly ad-hoc, truly "peer only" mesh network is used within some sort
of organization. The organization can impose management rules.

	Andrew
