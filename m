Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 4 Jan 2019 01:39:54 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190104003954.GD21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-4-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207135846.6152-4-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 03/19] batman-adv: Prepare framework for
 hardif genl config
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

On Fri, Dec 07, 2018 at 02:58:30PM +0100, Sven Eckelmann wrote:
[...]
> +/**
> + * batadv_get_hardif_from_info() - Retrieve hardif from genl attributes
> + * @bat_priv: the bat priv with all the soft interface information
> + * @net: the applicable net namespace
> + * @info: receiver information
> + *
> + * Return: Pointer to hard interface on success, error pointer on error
> + */
> +static struct batadv_hard_iface *
> +batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *net,
> +			    struct genl_info *info)
> +{
> +	struct batadv_hard_iface *hard_iface;
> +	struct net_device *hard_dev;
> +	unsigned int hardif_index;
> +
> +	if (!info->attrs[BATADV_ATTR_HARD_IFINDEX])
> +		return ERR_PTR(-EINVAL);
> +
> +	hardif_index = nla_get_u32(info->attrs[BATADV_ATTR_HARD_IFINDEX]);
> +
> +	hard_dev = dev_get_by_index(net, hardif_index);
> +	if (!hard_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	hard_iface = batadv_hardif_get_by_netdev(hard_dev);
> +	if (!hard_iface)
> +		goto err_put_harddev;
> +
> +	if (hard_iface->soft_iface != bat_priv->soft_iface)
> +		goto err_put_hardif;

When would this case above happen?

> +
> +	return hard_iface;

It seems unnecessary to keep holding a reference to hard_dev on
successful return here (and releasing it in post_doit). We return
hard_iface and increase its reference count which in turn itself holds
a reference to the according hard_dev already.

The usual pattern for a getter like this would be to increase the
reference count for just the object returned, wouldn't it?

In any case, maybe it would make sense to mention increased
refcounts in the kerneldoc? So that in case someone were reusing
this function that s/he would not miss the decrease. (happens too
often with these net_device reference counters...) Same for
batadv_get_softif_from_info().

> +
> +err_put_hardif:
> +	batadv_hardif_put(hard_iface);
> +err_put_harddev:
> +	dev_put(hard_dev);
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
