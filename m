Return-Path: <andrew@lunn.ch>
Date: Mon, 7 Mar 2016 15:31:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160307143130.GB15541@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-4-git-send-email-andrew@lunn.ch>
 <121426826.jDACy89axc@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121426826.jDACy89axc@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
 interfaces in a different netns
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
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

On Fri, Mar 04, 2016 at 01:35:01PM +0100, Sven Eckelmann wrote:
> On Tuesday 01 March 2016 22:19:07 Andrew Lunn wrote:
> > batman-adv tries to prevent the user from placing a batX soft
> > interface into another batman mesh as a hard interface. It does this
> > by walking up the devices list of parents and ensures they are all
> > none batX interfaces. iflink can point to an interface in a different
> > namespace, so also retrieve the parents name space when finding the
> > parent and use it when doing the comparison.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Antonio Quartulli <a@untable.cc>
> > ---
> >  net/batman-adv/hard-interface.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> Include missing in net/batman-adv/hard-interface.c
> 
>     #include <net/rtnetlink.h>

Hi Sven

How are you determining this? It compiled fine for me, which is my
usual test.

> 
> Does anyone (not only Andrew) have a proposal regarding the compat code?
> Patch 1+2 should be unproblematic (maybe these can already be applied?).

I've not much history with netns. One thing which might be interesting
it know, is when did it become mature enough to the usable? Maybe for
kernels older than v4.0, deny that netns exists, and find a way for
functions like get_link_net() to return the default net.
compat.h could contain

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0))
#if IS_ENABLED(CONFIG_NET_NS)
#error Network Namespaces not support with this vintage of kernel. Please disable
#endif
#endif

You then know everything is going to be in the default namespace for
these old kernels.

> This patch here is the first problematic one because it uses get_link_net
> which was first introduced in v4.0 with d37512a277df ("rtnl: add link netns
> id to interface messages"). I personally see some function substractions
> coming at us. But then it would be better to have this code in a smaller
> function to make "patching" easier (but I don't have a complete solution
> right now):
> 
>    dev_parent_net = default_net;
> 	if (dev->rtnl_link_ops && dev->rtnl_link_ops->get_link_net)
> 		dev_parent_net = dev->rtnl_link_ops->get_link_net(dev);

Horrible, and i have no idea if it actually works, but how about

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0))
#define dev->rtnl_link_ops->get_link_net true
#define dev->rtnl_link_ops->get_link_net(dev) init_net
#endif

so we get the default namespace.

> The next problematic part in regards of compat stuff is the patch 4.
> linux/ns_common.h is missing (can be added without a problem in
> compat-includes). More problematic is the net::ns substruct (to be more
> precise the net::ns.inum) which was first introduced in 3.19 with
> 435d5f4bb2cc ("common object embedded into various struct ....ns") and
> was previously called net::proc_inum (3.8-3.18) and did not exist
> before v3.8 98f842e675f9 ("proc: Usable inode numbers for the
> namespace file descriptors.").

How about something along the lines of

#if (LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0))
#define init_net.ns.inum 42
#define net->ns.inum 42
#endif

	Andrew
