Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 30 Dec 2018 17:57:54 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20181230165754.GC4150@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207135846.6152-2-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 01/19] batman-adv: Move common genl doit
 code pre/post hooks
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

On Fri, Dec 07, 2018 at 02:58:28PM +0100, Sven Eckelmann wrote:
> +/**
> + * batadv_get_softif_from_info() - Retrieve soft interface from genl attributes
> + * @net: the applicable net namespace
> + * @info: receiver information
> + *
> + * Return: Pointer to soft interface on success, error pointer on error
> + */
> +static struct batadv_priv *
> +batadv_get_softif_from_info(struct net *net, struct genl_info *info)

Since this returns a batadv_priv, shouldn't it better be called
batadv_get_batpriv_from_info() or batadv_get_bat_priv_from_info() maybe?

> +{
> +	struct net_device *soft_iface;
> +	int ifindex;
> +
> +	if (!info->attrs[BATADV_ATTR_MESH_IFINDEX])
> +		return ERR_PTR(-EINVAL);
> +
> +	ifindex = nla_get_u32(info->attrs[BATADV_ATTR_MESH_IFINDEX]);
> +
> +	soft_iface = dev_get_by_index(net, ifindex);
> +	if (!soft_iface)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!batadv_softif_is_valid(soft_iface))
> +		goto err_put_softif;
> +
> +	return netdev_priv(soft_iface);
> +
> +err_put_softif:
> +	dev_put(soft_iface);
> +
> +	return ERR_PTR(-EINVAL);
> +}

Is holding a reference to bat_priv->soft_iface really
necessary (and releasing it in batadv_post_doit() )?
If we are able to retrieve a valid bat_priv then this bat_priv
itself should hold a reference to to soft_iface, shouldn't it?

> +
> +/**
> + * batadv_pre_doit() - Prepare batman-adv genl doit request
> + * @ops: requested netlink operation
> + * @skb: Netlink message with request data
> + * @info: receiver information
> + *
> + * Return: 0 on success or negative error number in case of failure
> + */
> +static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
> +			   struct genl_info *info)
> +{
> +	struct batadv_priv *bat_priv;
> +
> +	if (ops->internal_flags & BATADV_FLAG_NEED_MESH) {
> +		bat_priv = batadv_get_softif_from_info(genl_info_net(info),
> +						       info);

Would it look nicer to store genl_info_net(info) in a temporary variable
so that its shorter and the newline for the second parameter could
be avoided?

> +		if (IS_ERR(bat_priv))
> +			return PTR_ERR(bat_priv);
> +
> +		info->user_ptr[0] = bat_priv;

Would it make sense to wrap this private data access into
something somehow? Conceptually similar to what we do not with skb private
data already for instance. There we use BATADV_SKB_CB() for instance.

> +	}
> +
> +	return 0;
> +}
