Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 10:50:47 +0200
Message-ID: <1502835.FE90zSC5Ao@bentobox>
In-Reply-To: <1465484086-7974-11-git-send-email-sw@simonwunderlich.de>
References: <1465484086-7974-1-git-send-email-sw@simonwunderlich.de>
 <1465484086-7974-11-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2389829.k2lmdsMmS6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v9 10/14] batman-adv: add B.A.T.M.A.N.
	Dump gateways via netlink
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2389829.k2lmdsMmS6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

it looks like this patch is incorrect and has to be rewritten. TQ is only 
available in BATMAN_IV and BATMAN_V will have to use THROUGHPUT. Thus this 
patch should be rewritten on top of the gw patchset from Antonio.

I will therefore mark this patch and all following patches as "changes 
requested". This also affects the batctl patches because they currently 
require TQ in the response.

Kind regards,
	Sven

On Thursday 09 June 2016 16:54:42 Simon Wunderlich wrote:
[...]
>  /**
> + * batadv_gw_dump_entry - Dump a gateway into a message
> + * @msg: Netlink message to dump into
> + * @portid: Port making netlink request
> + * @seq: Sequence number of netlink message
> + * @bat_priv: The bat priv with all the soft interface information
> + * @gw_node: Gateway to be dumped
> + *
> + * Return: Error code, or 0 on success
> + */
> +static int
> +batadv_gw_dump_entry(struct sk_buff *msg, u32 portid, u32 seq,
> +		     struct batadv_priv *bat_priv,
> +		     struct batadv_gw_node *gw_node)
> +{
> +	struct batadv_neigh_ifinfo *router_ifinfo = NULL;
> +	struct batadv_neigh_node *router;
> +	struct batadv_gw_node *curr_gw;
> +	int ret = -EINVAL;
> +	void *hdr;
> +
> +	router = batadv_orig_router_get(gw_node->orig_node, BATADV_IF_DEFAULT);
> +	if (!router)
> +		goto out;
> +
> +	router_ifinfo = batadv_neigh_ifinfo_get(router, BATADV_IF_DEFAULT);
> +	if (!router_ifinfo)
> +		goto out;
> +
> +	curr_gw = batadv_gw_get_selected_gw_node(bat_priv);
> +
> +	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
> +			  NLM_F_MULTI, BATADV_CMD_GET_GATEWAYS);
> +	if (!hdr) {
> +		ret = -ENOBUFS;
> +		goto out;
> +	}
> +
> +	ret = -EMSGSIZE;
> +
> +	if (curr_gw == gw_node)
> +		if (nla_put_flag(msg, BATADV_ATTR_FLAG_BEST)) {
> +			genlmsg_cancel(msg, hdr);
> +			goto out;
> +		}
> +
> +	if (nla_put(msg, BATADV_ATTR_ORIG_ADDRESS, ETH_ALEN,
> +		    gw_node->orig_node->orig) ||
> +	    nla_put_u8(msg, BATADV_ATTR_TQ, router_ifinfo->bat_iv.tq_avg) ||
> +	    nla_put(msg, BATADV_ATTR_ROUTER, ETH_ALEN,
> +		    router->addr) ||
> +	    nla_put_string(msg, BATADV_ATTR_HARD_IFNAME,
> +			   router->if_incoming->net_dev->name) ||
> +	    nla_put_u32(msg, BATADV_ATTR_BANDWIDTH_DOWN,
> +			gw_node->bandwidth_down) ||
> +	    nla_put_u32(msg, BATADV_ATTR_BANDWIDTH_UP,
> +			gw_node->bandwidth_up)) {
> +		genlmsg_cancel(msg, hdr);
> +		goto out;
> +	}
> +
> +	genlmsg_end(msg, hdr);
> +	ret = 0;
> +
> +out:
> +	if (router_ifinfo)
> +		batadv_neigh_ifinfo_put(router_ifinfo);
> +	if (router)
> +		batadv_neigh_node_put(router);
> +	return ret;
> +}

--nextPart2389829.k2lmdsMmS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXXnPnAAoJEF2HCgfBJntGMFkQALeOvYGrtyCRC/OfpTlUB0dx
9sX6MhkIpEGjGL3Q4p10l2sJMkxUjGboXQYgcIz6jTt4n2QjmTSIQar64wqByYUV
qQUwtegFhws9cpUoYReJRWWsZxLlV5zlsnV6TnJJz9AgxJuEOPZclWVfKKZdDFlu
N57tVWoBNnbxYGgSBODo9FEaFe1PkjY9WNCiMB3BnxUmFd0jJzkxII25AzuGgkgG
vqXD3OOtlc6ya/zC3Dq1fRQW2j2aLQSqDd+PjzA6lbWl0oznSpxOD+U+1IAbCsja
z9Dq8dTEC/2tMh8pPFWho/H0VpX8TiUxfY//U+AdZE11ZyNuK3aB60Km0nFitmt1
WH/oJX5rz0BhoeU0hiaPMNFe/9L2dlTRqBK0sGhe61wMHU2JoviZlASkDxKZiDo4
i+fRlx5Z1ZiuI93nG52jDWHSXzlQaTc1Vsdp0i1tt9tEtgg+5+AZw1OdhjqQXsEc
yE21LSc1i/5hTB1X4qRfIrmuasx8ydn0ffrISW9RE4o5+6p251zDvezCeVYmM8ta
4iXVjaVQlllgVwuWYApqqfSgnCIoOru6OjcweehoLGeOk0Xgr8ZHGw6Z/HhdX7fM
jLJ9N7ZFIxnASaLDmnr2oe1L7IbayvCjlpEv0Od5EjkCW9wlf7E+Cd8K4XHOjdbP
XCOmNmRs1d/pXEDJpfln
=NjRf
-----END PGP SIGNATURE-----

--nextPart2389829.k2lmdsMmS6--

