Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 May 2015 11:42:17 +0200
Message-ID: <16847028.DL9gCQ2dKS@sven-edge>
In-Reply-To: <20150517112732.48476eac@i3.local>
References: <20150517112732.48476eac@i3.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1952424.1pb6xZb47v";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] fixes a uint32 overflow
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1952424.1pb6xZb47v
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 17 May 2015 11:27:32 Ruben Wisniewski wrote:
> Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
> ---
>  net/batman-adv/gateway_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/gateway_client.c
> b/net/batman-adv/gateway_client.c index bb01586..1f50661 100644
> --- a/net/batman-adv/gateway_client.c
> +++ b/net/batman-adv/gateway_client.c
> @@ -153,7 +153,7 @@ batadv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
> struct batadv_neigh_node *router;
>  	struct batadv_neigh_ifinfo *router_ifinfo;
>  	struct batadv_gw_node *gw_node, *curr_gw = NULL;
> -	uint32_t max_gw_factor = 0, tmp_gw_factor = 0;
> +	uint64_t max_gw_factor = 0, tmp_gw_factor = 0;
>  	uint32_t gw_divisor;
>  	uint8_t max_tq = 0;
>  	uint8_t tq_avg;

This patch is not following

 * https://www.open-mesh.org/projects/open-mesh/wiki/Contribute
 * https://www.kernel.org/doc/Documentation/SubmittingPatches
 * https://www.kernel.org/doc/Documentation/CodingStyle

Please add the "batman-adv: " prefix for the Subject.

The summary in the subject itself also needs to be refined. The relevant part 
in SubmittingPatches for the subject can be found under "14) The canonical 
patch format".

An explanation in the commit message why there is an overflow would be nice.

Kind regards,
	Sven
--nextPart1952424.1pb6xZb47v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVWGJ8AAoJEF2HCgfBJntGVTwP/jnUYoFRIo6VcL8xuzm14BIK
7KhlmoIM3K3vxCp6WXrwZGZkfaF2xVH4DtmKfiQ/NqnmC0xWkUQJIkM0lRXsi9VH
CaDrNmKbyONv4BgK7JbXl0S1nDJplnxa4dd80H1c7OEh25wwy/r15fY2xz/tA9RC
M6mbZeExGK/O41mRsw0RZ5LsuqzkdSRlgL8J+rUUi08PqHbM0lkT8USuY3qGY7lF
mKqwnaGdC7ThPY0KU9ANBTI3kw+Elz8VQ5iSRVzkpBlVndEgDO92RjpHl6OuY5EY
GqWKN44nw1Dpk4lqPfIMExLv65aVvs2bSwq/5YQ0cS0RSsuTz9HBsfC01id1DMSJ
bhPC8fAusNlox8qFXEtmCk8Yn3B1kj23J5Two0++yKiwtnJBHrwhukDaRxGngi2R
5D1apFzvNfz6WeeNFLKf7WIyXmsq3fxXOpfgRneXMqEyMdX4HaljJEQrgsgYcyja
/zp0TxFAZcvG8BjVgSi1213aM4F74p+p9PTC73y3GLraAJE2R92O5o9Sd3q1F6o3
N3sir3OxTF3hBJoCe9S8dIIuCDZzZYI4dbdCfqRApJ4n6nqg2McfJsIwta2c8LHu
puno3Bsuyet2Ut3MAsO6X+OQJtD6YbO9W0LunR2ASr0gztPi/nCBOHIYEDvJr6Ta
StrwalUgElWg1RXAATD+
=pz81
-----END PGP SIGNATURE-----

--nextPart1952424.1pb6xZb47v--

