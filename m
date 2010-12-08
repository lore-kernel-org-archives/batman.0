Return-Path: <andrew@lunn.ch>
Date: Wed, 8 Dec 2010 19:08:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101208180823.GB11267@lunn.ch>
References: <20101207221351.GA19474@Sellars>
	<1291761150-29818-12-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1291761150-29818-12-git-send-email-linus.luessing@saxnet.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 12/20] batman-adv: Purge timeouted
 entries in mcast forw table
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
Cc: Linus L??ssing <linus.luessing@saxnet.de>

On Tue, Dec 07, 2010 at 11:32:22PM +0100, Linus L??ssing wrote:
> With this commit, the multicast forwarding table, which has been
> previously filled up due to multicast tracker packets, will now be
> checked frequently (once per second) for timeouted entries. If so these
> entries get removed from the table.
> 
> Note, that a more frequent check interval is not necessary, as multicast
> data will not only be forwarded if an entry exists, but also if that one
> might not have timeouted yet.
> 
> Signed-off-by: Linus L??ssing <linus.luessing@saxnet.de>
> ---
>  multicast.c  |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  multicast.h  |    1 +
>  originator.c |    2 ++
>  3 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/multicast.c b/multicast.c
> index edfe7e2..2b1bfde 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -821,6 +821,57 @@ out:
>  	rcu_read_unlock();
>  }
>  
> +void purge_mcast_forw_table(struct bat_priv *bat_priv)
> +{
> +	unsigned long flags;
> +	struct mcast_forw_table_entry *table_entry, *tmp_table_entry;
> +	struct mcast_forw_orig_entry *orig_entry, *tmp_orig_entry;
> +	struct mcast_forw_if_entry *if_entry, *tmp_if_entry;
> +	struct mcast_forw_nexthop_entry *nexthop_entry, *tmp_nexthop_entry;
> +
> +	spin_lock_irqsave(&bat_priv->mcast_forw_table_lock, flags);
> +	list_for_each_entry_safe(table_entry, tmp_table_entry,
> +				 &bat_priv->mcast_forw_table, list) {
> +		list_for_each_entry_safe(orig_entry, tmp_orig_entry,
> +					 &table_entry->mcast_orig_list, list) {
> +			list_for_each_entry_safe(if_entry, tmp_if_entry,
> +					    &orig_entry->mcast_if_list, list) {
> +				list_for_each_entry_safe(nexthop_entry,
> +						tmp_nexthop_entry,
> +						&if_entry->mcast_nexthop_list,
> +						list) {


I would probably break this up into four functions.

  Andrew
