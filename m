Return-Path: <andrew@lunn.ch>
Date: Fri, 29 Apr 2016 14:27:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160429122753.GC4053@lunn.ch>
References: <1461876897-12677-1-git-send-email-andrew@lunn.ch>
 <1461876897-12677-3-git-send-email-andrew@lunn.ch>
 <6222779.RWVmag3jgT@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6222779.RWVmag3jgT@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Use netlink when available,
 rather than debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Fri, Apr 29, 2016 at 08:12:47AM +0200, Sven Eckelmann wrote:
> On Thursday 28 April 2016 22:54:57 Andrew Lunn wrote:
> > The kernel has gained support for exporting information via netlink.
> > Use this when available, rather than debugfs. Netlink has the
> > advantage of being network name space aware, where as debugfs is not.
> > 
> > If netlink is not available, batctl will fall back to debugfs, so
> > should be backwards compatible with older kernel versions.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  Makefile    |  20 +-
> >  debug.c     |  19 +-
> >  debug.h     |   4 +-
> >  functions.c |  11 +
> >  functions.h |   1 +
> >  main.h      |   1 +
> >  netlink.c   | 810
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 7 files
> > changed, 862 insertions(+), 4 deletions(-)
> >  create mode 100644 netlink.c
> 
> It looks like this patch currently only adds the printing of netlink 
> information in a way that looks similar to the output from the legacy debugfs 
> files. This is ok but I find it weird that it claims in the commit message 
> that it uses (for everything?) netlink instead of debugfs when things like 
> translate_mac(...) and ping/traceroute still have to be ported to netlink.

Hi Sven

It never makes the claim it uses it for everything. I converted what i
needed for netns in my setup, and a bit more. I pretty much never use
ping/traceroute/BLA, gateways, etc, in my simulations, so i have no
itch to scratch there.

I would suggest getting the current code in a state it can be
accepted, i.e. add the extra error checking, etc. It is mostly
mechanical work, once you have an example to copy. So it should not be
too hard to finish off the debugfs equivalents by somebody who has a
need for them.

     Andrew
