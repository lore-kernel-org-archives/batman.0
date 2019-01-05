Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 5 Jan 2019 21:41:17 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190105204117.GS21623@otheros>
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
 <2744691.dbA1SKQ1ei@lafayette> <20180625172919.GA2433@otheros>
 <1778848.TvDNe92q0N@rousseau>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1778848.TvDNe92q0N@rousseau>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped
 DAT entry purge timeout in DHT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Marek,

Sorry for the very late reply, but here it comes.

On Fri, Jul 20, 2018 at 12:06:14PM +0800, Marek Lindner wrote:
> On Tuesday, 26 June 2018 01:29:19 HKT Linus Lüssing wrote:
> > 1) Host (A) joins the network and has the IP_X / MAC_a
> >    statically assigned.
> > 2) Some ARP Requests reaches this host, it issues an ARP Reply
> >    which populates the DHT.
> > 3) The host leaves the network.
> > 3) Another host (B) joins the network with IP_X / MAC_b
> >    statically assigned.
> 
> Let's distinguish the problems we're trying to solve:
> 
>  * Cache consistency during updates: A local DAT cache which is not updated 
> during a cache update event, thus needs to time out faster and a global DAT 
> cache receiving regular updates with less need to update.
> 
>  * Timely cache update: The global cache shall be updated as soon as the 
> information is available.
> 
> My previous email focused on the former while your response is about the 
> latter. Is that your assessment too ?
> 
> Both problems require solving to fully support this dynamic environment you 
> are describing whilst reducing ARP traffic overhead.
> 
> Would you mind commenting on the cache consistency issue ? Antonio will 
> respond to your 'snoop outgoing ARP Requests' question separately.


Sure. Actually, I think the example given has something to do with
"cache consistency" (unless I'm misunderstanding "cache consistency"?), too:

> and a global DAT cache receiving regular updates with less need to update.

If this "less" is too less then we would go into ARP Request broadcast
fallback less often. Which could lead to a temporary inconsistency between
the DAT cache and the actual host using an IP address, as
explained with the example with statically assigned addresses.

And that would result in the cache not being timely updated,
right. In that regard, that's your second point.

> A local DAT cache which is not updated
> during a cache update event, thus needs to time out faster

What you are trying to point out here, is it that the local DAT cache
needs to time out frequently as we would potentially miss updates
otherwise, as updates are generally only ensured to the global DAT
cache / the three DAT candidates?

Hm, if that's your point good point. Haven't thought about it that
way. Would that mean that we would need to keep querying the global
DAT every 5min. after the local DAT timeout even if we are likely
a DAT candidate for the specific address ourselves? I'm currently
trying to wrap my head around what that implies.


The "needs to time out faster" is interesting, too. Right,
assuming no DHCP-DAT snooping (or a high DHCP lease timeout) if a
local DAT Cache entry times out then it will currently likely have
timed out in the global DAT Cache at about the same time. Because
ARP Requests were previously answered locally by the local DAT
Cache, resulting in no global DAT cache updates through ARP Replies
from the genuine host.

And if every 5min. both the local and global DAT cache times out
then this results in the ARP Request broadcast fallback. Rendering
the unicast queries to the global DAT cache meaningless.

Does that make sense? Is that what you were alluding to?


Anyway, I'll update this patch to go for the initial idea. And
will add a push to the global DAT cache upon ARP Request the
source MAC/IP snooping as Antonio and no one else seemed to have
any objections. Which will hopefully also help with the potential
problem of statically assigned addresses not being updated timely.


Thanks for your feedback, Marek and Antonio!

Regards, Linus
