Return-Path: <andrew@lunn.ch>
Date: Tue, 2 Feb 2016 03:25:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160202022512.GE12673@lunn.ch>
References: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
 <1453953196-29943-3-git-send-email-andrew@lunn.ch>
 <23082646.VzubcaWY7q@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23082646.VzubcaWY7q@prime>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] alfred: Mount debugfs before
 reducing capabilities
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

On Fri, Jan 29, 2016 at 01:14:53PM +0100, Simon Wunderlich wrote:
> On Thursday 28 January 2016 04:53:15 Andrew Lunn wrote:
> > The debugfs helper code has the ability to mount the debugfs file
> > system if it is not already mounted. However, it cannot do this
> > after the capabilities have been dropped. So perform the mount early.
> > 
> > This is especially important when using network name spaces. Each
> > namespace has its own /sys, so the mount of debugfs in the global
> > namespace is not visible in other namespaces.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/main.c b/main.c
> > index 452d9ae..b1c5ec5 100644
> > --- a/main.c
> > +++ b/main.c
> > @@ -30,6 +30,7 @@
> >  #include <unistd.h>
> >  #endif
> >  #include "alfred.h"
> > +#include "debugfs.h"
> >  #include "packet.h"
> >  #include "list.h"
> > 
> > @@ -160,6 +161,9 @@ static struct globals *alfred_init(int argc, char
> > *argv[]) {NULL,			0,			NULL,	0},
> >  	};
> > 
> > +	/* We need full capabilities to mount debugfs, so do that now */
> > +	debugfs_mount(NULL);
> > +
> >  	ret = reduce_capabilities();
> >  	if (ret < 0)
> >  		return NULL;
> 
> Can't we remove the other calls to debugfs_mount() ? I see 3 more calls in 
> alfred ...

Yes, the other calls within this binary are probably failing, due to
reduced capabilities. I can remove them in a v3 patch.

	Andrew

