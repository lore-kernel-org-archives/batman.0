Return-Path: <andrew@lunn.ch>
Date: Mon, 5 Dec 2011 13:13:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111205121342.GD10131@lunn.ch>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<20111205112726.GC10131@lunn.ch>
	<201112051935.06611.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201112051935.06611.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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

On Mon, Dec 05, 2011 at 07:35:06PM +0800, Marek Lindner wrote:
> On Monday, December 05, 2011 19:27:26 Andrew Lunn wrote:
> > If i'm reading the patches correctly, it looks like you can change the
> > algorithm at any time. Rather than making one algorithm deal with what
> > ever state the previous algorithm left behind, would it not be better
> > to only allow algorithm change when the soft interface is down and
> > there is no local state?
> 
> Good point. Alternatively, we could add a cleanup call ?

Hi Marek

Changing routing protocol is something you don't want to accidentally
do. So i think it should be reasonably hard to do, so you don't get
any surprises. I would limit it to when the soft interface is down,
and at other times return EBUSY. EBUSY seems like a reasonable good
way to indicate the mesh is busy.

However, i think a cleanup call probably is needed, since the routing
protocol will probably have its own internal state, memory
allocations, etc which needs freeing when the mesh is going down.

	     Andrew
