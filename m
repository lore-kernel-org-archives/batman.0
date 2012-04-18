Return-Path: <martin@hundeboll.net>
Message-ID: <4F8E7C5E.9010301@hundeboll.net>
Date: Wed, 18 Apr 2012 10:33:34 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-3-git-send-email-ordex@autistici.org>
In-Reply-To: <1334701645-25862-3-git-send-email-ordex@autistici.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: clear ADD+DEL (and
 viceversa) events in the same orig-interval
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

Hi Antonio,

On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
> During an OGM-interval (time between two different OGM sendings) the same client
> could roam away and then roam back to us. In this case the node would add two
> events to the events list (that is going to be sent appended to the next OGM). A
> DEL one and an ADD one. Obviously they will only increase the overhead (either in
> the air and on the receiver side) and eventually trigger wrong states/events
> without producing any real effect.
>
> For this reason we can safely delete any ADD event with its related DEL one.
>
> Signed-off-by: Antonio Quartulli<ordex@autistici.org>
> ---
>   translation-table.c |   35 ++++++++++++++++++++++++++++++-----
>   1 file changed, 30 insertions(+), 5 deletions(-)
>
> diff --git a/translation-table.c b/translation-table.c
> index 88e4c8e..e02fa90 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -154,23 +154,48 @@ static void tt_orig_list_entry_free_ref(struct tt_orig_list_entry *orig_entry)
>   static void tt_local_event(struct bat_priv *bat_priv, const uint8_t *addr,
>   			   uint8_t flags)
>   {
> -	struct tt_change_node *tt_change_node;
> +	struct tt_change_node *tt_change_node, *entry, *safe;
> +	bool event_removed = false;
>
>   	tt_change_node = kmalloc(sizeof(*tt_change_node), GFP_ATOMIC);
> -
>   	if (!tt_change_node)
>   		return;
> -
>   	tt_change_node->change.flags = flags;
>   	memcpy(tt_change_node->change.addr, addr, ETH_ALEN);
>
> +	/* check for ADD+DEL or DEL+ADD events */
>   	spin_lock_bh(&bat_priv->tt_changes_list_lock);
> +	list_for_each_entry_safe(entry, safe,&bat_priv->tt_changes_list,
> +				 list) {
> +		if (!compare_eth(entry->change.addr, addr))
> +			continue;

Please add an empty line here.

> +		if (!(!(flags&  TT_CLIENT_DEL)&&  /* ADD op */
> +		      entry->change.flags&  TT_CLIENT_DEL)&&
> +		    !(flags&  TT_CLIENT_DEL&&
> +		      !(entry->change.flags&  TT_CLIENT_DEL))) /* ADD op */
> +			continue;

This is messy and hard to unerstand. Couldn't you use some tmp vars like this:

int local_del = (flags & TT_CLIENT_DEL) == TT_CLIENT_DEL;
int change_del = (entry->change.flags & TT_CLIENT_DEL) == TT_CLIENT_DEL;

if (local_del == change_del)
	continue;

I'm not 100% sure I understood the original if correctly, but that just proofs the need to rework it :)

> +		/* DEL+ADD in the same orig interval have no effect and can be
> +		 * removed to avoid silly behaviour on the receiver side. The
> +		 * other way around (ADD+DEL) can happen in case of roaming of
> +		 * a client still in the NEW state. Roaming of NEW clients is
> +		 * now possible due to automatically recognition of "temporary"
> +		 * clients */

Remember newline for */ :)

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
