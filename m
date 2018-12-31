Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 31 Dec 2018 12:59:36 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20181231115936.GE4150@otheros>
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
> The BATADV_CMD_GET_HARDIFS (or short version BATADV_CMD_GET_HARDIF) is
> reused as get command because it already allow to dump the content of other
> information from the slave/hard-interface which are not yet configuration
> specific.

"already allow" -> "already allows"

[...]
> @@ -76,6 +77,13 @@ enum batadv_genl_ops_flags {
>  	 *  safed in info->user_ptr[0]
>  	 */
>  	BATADV_FLAG_NEED_MESH = BIT(0),
> +
> +	/**
> +	 * @BATADV_FLAG_NEED_HARDIF: request requires valid hard interface in
> +	 *  attribute BATADV_ATTR_HARD_IFINDEX and expects a pointer to it to be
> +	 *  safed in info->user_ptr[1]
> +	 */
> +	BATADV_FLAG_NEED_HARDIF = BIT(1),

safed -> saved
(and same in the previous patch)

[...]
>  /**
>   * batadv_pre_doit() - Prepare batman-adv genl doit request
>   * @ops: requested netlink operation
> @@ -592,7 +738,16 @@ batadv_get_softif_from_info(struct net *net, struct genl_info *info)
>  static int batadv_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
>  			   struct genl_info *info)
>  {
> -	struct batadv_priv *bat_priv;
> +	struct batadv_hard_iface *hard_iface;
> +	struct batadv_priv *bat_priv = NULL;
> +	int ret;
> +
> +	if (WARN_ON(ops->internal_flags & BATADV_FLAG_NEED_HARDIF))
> +		return -EINVAL;
> +
> +	if (WARN_ON((ops->internal_flags & BATADV_FLAG_NEED_HARDIF) &&
> +		    (~ops->internal_flags & BATADV_FLAG_NEED_MESH)))
> +		return -EINVAL;

Seems like the second part is unreachable code. If
BATADV_FLAG_NEED_HARDIF is set then the function returns with the first
if-clause already.
