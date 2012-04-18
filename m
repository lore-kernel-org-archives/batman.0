Return-Path: <martin@hundeboll.net>
Message-ID: <4F8E80DE.8040102@hundeboll.net>
Date: Wed, 18 Apr 2012 10:52:46 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1334701645-25862-6-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/5] batman-adv: beautify tt_global_add()
 argument list
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

Hi,

On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
> Instead of adding a new bool argument each time it is needed, it is
> better (and simpler) to pass an 8bit flag argument which contains all the
> needed flags
>
> Signed-off-by: Antonio Quartulli<ordex@autistici.org>
> ---
>   routing.c           |    2 +-
>   translation-table.c |   18 ++++++------------
>   translation-table.h |    3 +--
>   3 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/routing.c b/routing.c
> index 2181a91..22d67bb 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -684,7 +684,7 @@ int recv_roam_adv(struct sk_buff *skb, struct hard_iface *recv_if)
>   		roam_adv_packet->src, roam_adv_packet->client);
>
>   	tt_global_add(bat_priv, orig_node, roam_adv_packet->client,
> -		      atomic_read(&orig_node->last_ttvn) + 1, true, false);
> +		      TT_CLIENT_ROAM, atomic_read(&orig_node->last_ttvn) + 1);
>
>   	/* Roaming phase starts: I have new information but the ttvn has not
>   	 * been incremented yet. This flag will make me check all the incoming
> diff --git a/translation-table.c b/translation-table.c
> index ab295ee..00757ea 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -589,8 +589,7 @@ static void tt_global_add_orig_entry(struct tt_global_entry *tt_global_entry,
>
>   /* caller must hold orig_node refcount */
>   int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
> -		  const unsigned char *tt_addr, uint8_t ttvn, bool roaming,
> -		  bool wifi)
> +		  const unsigned char *tt_addr, uint8_t flags, uint8_t ttvn)
>   {
>   	struct tt_global_entry *tt_global_entry = NULL;
>   	struct tt_orig_list_entry *orig_entry;
> @@ -600,14 +599,12 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
>   	tt_global_entry = tt_global_hash_find(bat_priv, tt_addr);
>
>   	if (!tt_global_entry) {
> -		tt_global_entry = kzalloc(sizeof(*tt_global_entry),
> -					  GFP_ATOMIC);
> +		tt_global_entry = kzalloc(sizeof(*tt_global_entry), GFP_ATOMIC);

This trivial style-fix doesn't really belong in this patch, does it? (Not that I mind...)

>   		if (!tt_global_entry)
>   			goto out;
>
>   		memcpy(tt_global_entry->common.addr, tt_addr, ETH_ALEN);
> -
> -		tt_global_entry->common.flags = NO_FLAGS;
> +		tt_global_entry->common.flags = flags;
>   		tt_global_entry->roam_at = 0;
>   		atomic_set(&tt_global_entry->common.refcount, 2);
>
> @@ -654,9 +651,6 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
>   			orig_entry->ttvn = ttvn;
>   	}
>
> -	if (wifi)
> -		tt_global_entry->common.flags |= TT_CLIENT_WIFI;
> -
>   	bat_dbg(DBG_TT, bat_priv,
>   		"Creating new global tt entry: %pM (via %pM)\n",
>   		tt_global_entry->common.addr, orig_node->orig);
> @@ -664,7 +658,7 @@ int tt_global_add(struct bat_priv *bat_priv, struct orig_node *orig_node,
>   out_remove:
>   	/* remove address from local hash if present */
>   	tt_local_remove(bat_priv, tt_global_entry->common.addr,
> -			"global tt received", roaming);
> +			"global tt received", flags&  TT_CLIENT_ROAM);
>   	ret = 1;
>   out:
>   	if (tt_global_entry)
> @@ -1678,9 +1672,9 @@ static void _tt_update_changes(struct bat_priv *bat_priv,
>   				      (tt_change + i)->flags&  TT_CLIENT_ROAM);
>   		else
>   			if (!tt_global_add(bat_priv, orig_node,
> -					   (tt_change + i)->addr, ttvn, false,
> +					   (tt_change + i)->addr,
>   					   (tt_change + i)->flags&
> -							TT_CLIENT_WIFI))
> +							TT_CLIENT_WIFI, ttvn))

If you use a temporary variable for "tt_change + i", you can avoid the last indentation and make the code easier to read...

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
