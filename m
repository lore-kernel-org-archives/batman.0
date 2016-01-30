Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 30 Jan 2016 12:35:33 +0800
Message-ID: <1947926.p5gVdyYhcU@voltaire>
In-Reply-To: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
References: <1453296735-8319-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4753356.tdscampV7A";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: move and restructure
	batadv_v_ogm_forward
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

--nextPart4753356.tdscampV7A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, January 20, 2016 14:32:14 Simon Wunderlich wrote:
>  /**
> - * batadv_v_ogm_forward - forward an OGM to the given outgoing interface
> + * batadv_v_ogm_forward - check conditions and forward an OGM to the given
> + *  outgoing interface
>   * @bat_priv: the bat priv with all the soft interface information
>   * @ogm_received: previously received OGM to be forwarded
> - * @throughput: throughput to announce, may vary per outgoing interface
> + * @neigh_node: the neigh_node through with the OGM has been received
>   * @if_incoming: the interface on which this OGM was received on
>   * @if_outgoing: the interface to which the OGM has to be forwarded to
>   *
> @@ -359,28 +360,55 @@ static u32 batadv_v_forward_penalty(struct batadv_priv
> *bat_priv, */
>  static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
>  				 const struct batadv_ogm2_packet *ogm_received,
> -				 u32 throughput,
> +				 struct batadv_neigh_node *neigh_node,
>  				 struct batadv_hard_iface *if_incoming,
>  				 struct batadv_hard_iface *if_outgoing)
>  {
> +	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
> +	struct batadv_orig_ifinfo *orig_ifinfo = NULL;
> +	struct batadv_neigh_node *router = NULL;
>  	struct batadv_ogm2_packet *ogm_forward;
>  	unsigned char *skb_buff;
>  	struct sk_buff *skb;
>  	size_t packet_len;
>  	u16 tvlv_len;
> 
> +	/* only forward for specific interfaces, not for the default one. */
> +	if (if_outgoing != BATADV_IF_DEFAULT)
> +		goto out;
> +
> +	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);

The variable 'orig_node' isn't defined anywhere in the context of this 
function. It was passed as an argument to batadv_v_ogm_route_update().

Please recompile with 'make CONFIG_BATMAN_ADV_BATMAN_V=y' and fix all errors 
and warnings.  :-)


> +	if (!orig_ifinfo)
> +		goto out;
> +	/* acquire possibly updated router */
> +	router = batadv_orig_router_get(orig_node, if_outgoing);

A new line between the goto and the comment would be nice to have.

Cheers,
Marek

--nextPart4753356.tdscampV7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWrD2VAAoJEFNVTo/uthzARAIH/jP+5I1wMdJLHKwCWyiJJlqq
OmCJKdZDAArImWhP8+f7fRq/rzawmsCkl5ujhvRdnknX8V8AK6K2An+VUqru68El
qV/LJzdvfI1zoRrqI4uYGT2mRCcd4jQj57pfraJC9wnx2i/7xGeOByT8LlaoQ2Is
d7ml9Bs9k7pAkrTsgGZONWAsUEJ5OJ72x11ojF/BQR5bIhJBXzEF4bjNJhCfZLbG
ht9M9O7SZ+xH/nBQxeg4p/XLWPEYt6xBF4oP//028X4rO0V+NeOvGhZxomtjGKI6
WZGrGUQXr8fJzSVGX0AWEPr5onKEDcR8+i4XGiZvi/2M542z5GvkA0qbiWuyleE=
=5PaL
-----END PGP SIGNATURE-----

--nextPart4753356.tdscampV7A--

