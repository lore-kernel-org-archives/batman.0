Return-Path: <andrew@lunn.ch>
Date: Sun, 13 Dec 2009 17:14:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091213161415.GX29768@lunn.ch>
References: <20091130211445.GN4150@lunn.ch>
	<20091211225835.GA17140@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091211225835.GA17140@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] /proc vis rework
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

> And I wanted to ask, what do you think about unifying the specific
> help output? For instance having this "Usage: ..."-header and the
> alignment for the following items the same way as it is done for
> other batctl commands as well.

I thought about that. However the architecture allows different
formats to be easily added. Different formats might need different
optional arguments. It just seems easier the way it is at the moment.

	 Andrew

