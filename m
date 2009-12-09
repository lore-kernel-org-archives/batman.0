Return-Path: <gosand1982@yahoo.com>
Message-ID: <618743.16485.qm@web111609.mail.gq1.yahoo.com>
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
	<20091209063411.GJ29768@lunn.ch>
Date: Wed, 9 Dec 2009 12:35:24 -0800 (PST)
From: George Sanders <gosand1982@yahoo.com>
In-Reply-To: <20091209063411.GJ29768@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hello,


> > My question is:
> > 
> > Who provides IP addresses in a truly ad-hoc, truly "peer only" mesh network ?
> 
> One option is IPv6 and link local addresses. These are derived from
> the MAC address, plus duplicate address detection, to ensure the IP
> address is unique. http://tools.ietf.org/html/rfc4862
> 
> Another option is zeroconf, http://en.wikipedia.org/wiki/Zeroconf, 
> http://tools.ietf.org/html/rfc3927.
> 
> Another option is statically configure all the boxes with a unique IP
> address from a well know subnet. It is often worth remembering that a
> truly ad-hoc, truly "peer only" mesh network is used within some sort
> of organization. The organization can impose management rules.



Yes, I do agree that many real world ad-hoc networks will be deployed by an organized
group and that we can speak of pre-existing arrangements, or rules, but I am exploring
the extreme cases where individuals randomly congregate and have nothing but a
common toolset, and there are no server "roles" being played.

Thank you for the pointer to zeroconf, as it is right along the lines of what I was thinking
about.

Out of curiousity, what does the freifunk network use for assigning IPs ?


      

