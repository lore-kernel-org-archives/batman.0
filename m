Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 19 Apr 2016 04:22:18 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160419022218.GE17647@otheros>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-3-git-send-email-linus.luessing@c0d3.blue>
 <3374405.0Pi9Duaxya@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3374405.0Pi9Duaxya@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 2/4] batman-adv: Add multicast
 optimization support for bridged setups
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, Apr 07, 2016 at 03:50:39PM +0200, Sven Eckelmann wrote:
> On Wednesday 16 March 2016 05:06:43 Linus Lüssing wrote:
> > --- /dev/null
> > +++ b/compat-sources/net/bridge/br_multicast.c
> > @@ -0,0 +1,33 @@
> > +#include <linux/if_bridge.h>
> > +#include <linux/printk.h>
> > +
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 16, 0) || \
> > +    LINUX_VERSION_CODE == KERNEL_VERSION(3, 16, 0) && \
> > +       (!IS_ENABLED(CONFIG_BRIDGE) || \
> > +       !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING))
> > +
> > +int br_multicast_list_adjacent(struct net_device *dev,
> > +                              struct list_head *br_ip_list)
> > +{
> > +       return 0;
> > +}
> > +
> > +bool br_multicast_has_querier_adjacent(struct net_device *dev, int proto)
> > +{
> > +       return false;
> > +}
> > +
> > +#endif /* < KERNEL_VERSION(3, 16, 0) ||
> > +       * !IS_ENABLED(CONFIG_BRIDGE) ||
> > +       * !IS_ENABLED(CONFIG_BRIDGE_IGMP_SNOOPING) */
> > +
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 17, 0)
> > +
> > +bool br_multicast_has_querier_anywhere(struct net_device *dev, int proto)
> > +{
> > +       pr_warn_once("Old kernel detected (< 3.17) - multicast optimizations disabled\n");
> > +
> > +       return false;
> > +}
> > +
> > +#endif /* < KERNEL_VERSION(3, 17, 0) */
> 
> Why must there be a special compat-sources/*.c file for these tiny
> functions?

I think it is necessary because of the missing stubs in 3.16.
3.16 has the function declarations in if_bridge.h but without
function definitions if the kernel is build without bridge
(snooping) support.

Adding simple inline functions in compat-include/linux/if_bridge.h
for these functions would yield a compile-time error for the 3.16
kernel without bridge (snooping) support case: The declaration is
always there in 3.16's if_bridge.h include which would clash
with a self-made inline function in our compat-include's
if_bridge.h.
