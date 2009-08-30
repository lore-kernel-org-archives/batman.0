Return-Path: <andrew@lunn.ch>
Date: Sun, 30 Aug 2009 09:37:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090830073752.GO16067@lunn.ch>
References: <20090830013647.GA26017@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090830013647.GA26017@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [patch] adding subgraph-feature to vis-output in
 dot-file-format
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

> Cheers, Linus
>
> PPS: I had to introduce a src-field in the vis-packet-struct,
> therefore the compatibility version had to be increased as well.

I'm thinking about linux-mainline here.

Does it make sense to have a version number per message type? Some
things we can do backward compatibility easily, some things not.

I guess it should not be too hard to do backward compatibility
here. If you receive a version 7 do the old way of getting the source
address. If its a version 8 packet, use the new way?

Allowing this sort of backward compatibility also makes deployment
easier. You currently have a real danger of loosing contact to some of
your nodes during software updates. If you do it in the wrong order,
you could end up with a disconnected island.

Also, once in mainline, the vis file becomes part of the well defined
API. It should not just change in ways which are not backward
compatible. I'm guessing this change breaks all my tools for parsing
vis, and it probably breaks other peoples tools. Ideally, we strip out
all graphviz and JSON formatting from the kernel and put it into
userspace, eg batctl. Tools should then use batcl. It then becomes
safer to change the proc vis format. The output of batctl stays the
same, unless you add a command line flag to enable the new feature.

This move to mainline requires some adaptations to the development
ways. We need to discuss this and need to get the basics sorted out
before we do go into mainline. However, it looks like we could be in
mainline very quickly if we wanted.

      Andrew

