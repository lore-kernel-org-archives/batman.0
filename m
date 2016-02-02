Return-Path: <andrew@lunn.ch>
Date: Tue, 2 Feb 2016 03:22:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160202022238.GD12673@lunn.ch>
References: <1453953196-29943-1-git-send-email-andrew@lunn.ch>
 <1453953196-29943-2-git-send-email-andrew@lunn.ch>
 <3299385.slEDhCLINf@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3299385.slEDhCLINf@prime>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] alfred: Add support for network
 namespaces
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

On Fri, Jan 29, 2016 at 01:18:13PM +0100, Simon Wunderlich wrote:
> On Thursday 28 January 2016 04:53:14 Andrew Lunn wrote:
> > When running within a network namespace, access to files within
> > debugfs have to take into account the network name space. Each
> > namespace has its own directory under
> > /sys/kernel/debug/batman_adv/netns.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  batadv_query.c |  2 +-
> >  debugfs.c      | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  vis/vis.h      |  2 +-
> >  3 files changed, 50 insertions(+), 3 deletions(-)
> > 
> > diff --git a/batadv_query.c b/batadv_query.c
> > index c289b80..fe7c007 100644
> > --- a/batadv_query.c
> > +++ b/batadv_query.c
> > @@ -31,7 +31,7 @@
> >  #include <sys/types.h>
> >  #include "debugfs.h"
> > 
> > -#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s"
> > +#define DEBUG_BATIF_PATH_FMT "%s/batman_adv/%s%s"
> >  #define DEBUG_TRANSTABLE_GLOBAL "transtable_global"
> >  #define DEBUG_ORIGINATORS "originators"
> > 
> > diff --git a/debugfs.c b/debugfs.c
> > index fc39322..35c1bdf 100644
> > --- a/debugfs.c
> > +++ b/debugfs.c
> > @@ -20,11 +20,15 @@
> > 
> >  #include "debugfs.h"
> >  #include <errno.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> >  #include <stdio.h>
> >  #include <string.h>
> >  #include <sys/mount.h>
> >  #include <sys/stat.h>
> >  #include <sys/statfs.h>
> > +#include <sys/types.h>
> > +#include <unistd.h>
> > 
> >  #ifndef DEBUGFS_MAGIC
> >  #define DEBUGFS_MAGIC          0x64626720
> > @@ -42,16 +46,59 @@ static const char *debugfs_known_mountpoints[] = {
> >  	NULL,
> >  };
> > 
> > +/* Return the current net namespace number. 0 is never a valid
> > + * namespace, so use it to return that there is no name space
> > + * support.
> > + */
> > +
> > +static unsigned int debugfs_get_netns_inum(void)
> > +{
> > +	char net_path[] = "/proc/self/ns/net";
> > +	struct stat netst;
> > +	int netns;
> > +
> > +	netns = open(net_path, O_RDONLY);
> > +	if (netns < 0) {
> > +		if (errno == ENOENT)
> > +			/* Probably means no netns support in the kernel */
> > +			return 0;
> > +
> > +		fprintf(stderr,
> > +			"Error - can't open /proc/self/ns/net for read: %s\n",
> > +			strerror(errno));
> > +		return 0;
> > +	}
> > +
> > +	if (fstat(netns, &netst) < 0) {
> > +		fprintf(stderr, "Stat of netns failed: %s\n",
> > +			strerror(errno));
> > +		return 0;
> 
> Aren't we leaking the netns file descriptor here?

Yes, it is leaking. I will fix that in a v2.

Thanks
     Andrew

