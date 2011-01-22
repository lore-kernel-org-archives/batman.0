Return-Path: <linus.luessing@web.de>
Date: Sat, 22 Jan 2011 17:16:01 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110122161601.GA18189@Sellars>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N.-Advanced Multicast Optimizations, v2
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

By the way, you can also pull these commits directly from
http://git.open-mesh.org/?p=t_x/batman-adv.git;a=summary
and easily monitor/review new changes here in the "multicast"
branch.

This patchset is tagged as "multicast-v2", obviously.

Cheers, Linus


PS: The NDP patchsets are available there as well.

On Sat, Jan 22, 2011 at 02:21:23AM +0100, Linus Lüssing wrote:
> Hi everyone,
> 
> Here's the next series of patches which should address the comments I got for the
> first one. Thanks for all the feedback!
> 
> Changelog:
>  * rebasing to commit [65e0869478bce153a799c0e774a117ba5fc78025],
>    using new orig_hash methods
>  * putting seqno before ttl, 4 byte aligning mcast_packet [01/20]
>  * adapted compat.h to not use custom lock macros, instead only one macro for
>    netif_addr_lock_bh() in case of older kernel versions
>  * merged spinlock-irqsave-to-bh commit into previous commits [20/20]
>  * moved mcast_may_optimize() to soft-interface.c [18/20], removed inlining
>    (won't optimize much anyway...)
>  * purge_mcast_forw_table, splitted list operations into separate functions
>    [12/20]
>  * use batman_if refcounting to reduce the time of rcu-locking [13/20]
>  * do not create nexthop entry if according batman_if is NULL [13/20]
>  * route_mcast_packet, split into separat functions [13/20]
>  * fix typo "seperate" [13/20]
>  * fix typo "i.g." [08/20]
>  * COMPAT_VERSION to 14 [01/20]
>  * use rcu-locking+refcounting for orig_node, remove orig_hash_lock [07/20],
>    [17/20]
>  * made checkpatch-clean
>  * use __packed instead of __attribute_((packed)) [01/20]
>  * change tracker_packet_for_each_dest macro [07/20]:
>    make a "break" in this macro to behave like usual, export parts from macro
>    into own functions
> 
> TODO:
> * directly prepare mcast-tracker-packet in sk_buff
> * only create methods / variables in patches that need them
> 
> * update mcast-doc
> * upload updated mcast-doc to wiki
> 
> maybe TODO?
> * use hlist instead of list for mcast-table?
> * use rcu-locking / refcounting for mcast_forw_table?
> 
> Cheers, Linus
> 
