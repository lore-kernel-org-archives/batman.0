Return-Path: <lindner_marek@yahoo.de>
Message-ID: <5079A8C5.4020407@yahoo.de>
Date: Sun, 14 Oct 2012 01:45:41 +0800
From: Marek Lindner <lindner_marek@yahoo.de>
MIME-Version: 1.0
References: <1341782658-10978-1-git-send-email-martin@hundeboll.net>
 <1350149454-809-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1350149454-809-1-git-send-email-martin@hundeboll.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add wrapper to look up
 neighbor and send skb
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>

On 10/14/2012 01:30 AM, Martin Hundebøll wrote:
> +bool batadv_send_skb_to_orig(struct sk_buff *skb,
> +			     struct batadv_orig_node *orig_node,
> +			     struct batadv_hard_iface *recv_if)
> +{
> +	struct batadv_priv *bat_priv = orig_node->bat_priv;
> +	struct batadv_neigh_node *neigh_node;
> +
> +	/* batadv_find_router() increases neigh_nodes refcount if found. */
> +	neigh_node = batadv_find_router(bat_priv, orig_node, recv_if);
> +	if (!neigh_node)
> +		return false;
> +
> +	/* route it */
> +	batadv_send_skb_packet(skb, neigh_node->if_incoming, neigh_node->addr);
> +
> +	batadv_neigh_node_free_ref(neigh_node);
> +
> +	return true;
> +}

Our new quality standards demand proper kernel documentation for each 
new function / struct / define added to the code.
Only 3 months ago this code would have been acceptable.  ;-)

Cheers,
Marek

PS: The version information is missing in the subject of this mail. 
Please help your maintainer from hell to save some time ...  :)

