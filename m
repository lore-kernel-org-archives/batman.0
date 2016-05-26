Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 26 May 2016 06:39:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160526043914.GJ3453@otheros>
References: <1464019185-8381-1-git-send-email-sw@simonwunderlich.de>
 <1464019185-8381-6-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1464019185-8381-6-git-send-email-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v8 05/14] batman-adv: netlink: add
 translation table query
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

On Mon, May 23, 2016 at 05:59:36PM +0200, Simon Wunderlich wrote:
> +static int
> +batadv_tt_local_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
> +			   struct batadv_priv *bat_priv,
> +			   struct batadv_tt_common_entry *common)
> +{
[...]
> +	if (!(common->flags & BATADV_TT_CLIENT_NOPURGE)) {
> +		if (nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS,
> +				last_seen_msecs))
> +			goto nla_put_failure;
> +	}

Unnecessary brackets here, maybe use '&&' to skip a layer of
indention?


> +int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
> +{
> +	struct net *net = sock_net(cb->skb->sk);
> +	struct net_device *soft_iface = NULL;

No need to set soft_iface to NULL.


> +static int
> +batadv_tt_global_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
> +			    struct batadv_priv *bat_priv,
> +			    struct batadv_tt_common_entry *common, int *sub_s)
> +{
> +	struct batadv_tt_orig_list_entry *orig_entry, *best_entry;
> +	struct batadv_tt_global_entry *global;
> +	struct hlist_head *head;
> +	int sub = 0;
> +	bool best;
> +
> +	global = container_of(common, struct batadv_tt_global_entry, common);
> +	best_entry = batadv_transtable_best_orig(bat_priv, global);
> +	head = &global->orig_list;
> +
> +	hlist_for_each_entry_rcu(orig_entry, head, list) {

Either add an explicit rcu-lock or keep to the doc style to add a
line in the kerneldoc about caller needing to hold it?


> +int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
> +{
> +	struct net *net = sock_net(cb->skb->sk);
> +	struct net_device *soft_iface = NULL;

No need to set soft_iface to NULL.
