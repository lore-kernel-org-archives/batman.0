Return-Path: <andrew@lunn.ch>
Date: Sat, 12 Dec 2009 11:43:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091212104324.GQ29768@lunn.ch>
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

On Fri, Dec 11, 2009 at 11:58:35PM +0100, Linus L??ssing wrote:
> Hi Andrew,
> 
> your patch seems to work pretty well here, tested it with 9
> batman-nodes in the same room. Nevertheless I found a couple of
> smaller bugs in there:
> - batctl segfaults, if "batctl vis" has no following argument
> - batctl now displays the help-page in certain situations where we
>   don't want it to
> - batctl ommits the first TQ tupel
> The attached patch for your patch should fix these issues :).

Thanks for the review. I will try to look at the details today or
tomorrow.

	Andrew
