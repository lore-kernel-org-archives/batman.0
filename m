Return-Path: <ordex@autistici.org>
Date: Tue, 16 Apr 2013 18:40:01 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130416164001.GC20819@ritirata.org>
References: <1366125995-18034-1-git-send-email-lindner_marek@yahoo.de>
 <1366125995-18034-7-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1366125995-18034-7-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/7] batman-adv: tvlv - convert tt query
 packet to use tvlv unicast packets
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2013 at 11:26:34PM +0800, Marek Lindner wrote:
> Instead of generating TT specific packets the TVLV unicast API is used
> to send translation table data.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

[...]

> -
> -	if (batadv_send_skb_to_orig(skb, dst_orig_node, NULL))
> -		ret =3D 0;
> +	batadv_tvlv_unicast_send(bat_priv, primary_if->net_dev->dev_addr,
> +				 dst_orig_node->orig, BATADV_TVLV_TT, 1,
> +				 (unsigned char *)tvlv_tt_data,
				 ^^^^^^^^^^^^^^^^^
You should remove this cast since the function expects a void *

> +				 sizeof(*tvlv_tt_data));
> +	ret =3D true;
> =20

[...]

> -	if (batadv_send_skb_to_orig(skb, res_dst_orig_node, NULL))
> -		ret =3D true;
> +	batadv_tvlv_unicast_send(bat_priv, req_dst_orig_node->orig,
> +				 req_src, BATADV_TVLV_TT, 1,
> +				 (unsigned char *)tvlv_tt_data,

same here.

> +				 sizeof(*tvlv_tt_data) + tt_len);
> +
> +	ret =3D true;
>  	goto out;

[...]

> -	if (batadv_send_skb_to_orig(skb, orig_node, NULL))
> -		ret =3D true;
> +	batadv_tvlv_unicast_send(bat_priv, primary_if->net_dev->dev_addr,
> +				 req_src, BATADV_TVLV_TT, 1,
> +				 (unsigned char *)tvlv_tt_data,

same here=C2=B2.

> +				 sizeof(*tvlv_tt_data) + tt_len);
> +

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRbX7hAAoJEADl0hg6qKeOuMgQAIFVY+suGdT+YjoChnCno/3A
upf+jYbVNbfcIv0M8p/4s2KaycQYTUK52MEXsghohpzF951e4s6f6FJ5rbYAbvo2
YnstbJqt12Kuc3BjpFAXFGKK3VS3kTVIfMdAUaEb8VYrxA1ow0aPLRJqzIQOR8du
S+03BcGe1dXE8fFuczdyky8Srk5vXVj1O5NUzEUK/6F0EuW/fHd6jhkhq2GQKiwP
EiyTXgKHDNQyzDvRpagTBsZ4LeWyIEZQ3czEis+oazE7ikmGJzHoT3WswIiZhu1y
TLD35pEVsTtyoNQWWSnf+UDiMT7ZfdhG/ANpECVy/oLbvateRMGvaAkv1lLLHRfY
fCd7u25eo6PIngZmk8Doghux24YZvBBa6HuvqPVygfT0vcsJnP4se3k0vIZL2G/P
ghTEUwPQG7l9/BFe77OlzTPqB2JtrzfDutb5dSXsxHdnjV/IW5v0ymrTCgIuZxQ6
NyyhCTGRkcRleumjY4RWqWRQXP819Y3TIfZywH7QmcsJKwEZyXjlQ9/GHdRncZwt
tVuk5mLVMnC1g2tyc425FangrH4niK9l449XTTqslQQFyfcjj2+0VWwWHCDmGR4b
JIdyUINh02svqTH0FMlInfUQM56W7VkPuKbjJLsEa+pG3X5yDqLflUaf9oVV2v6B
QVPaRrxlRaVUL33nrxNN
=OSlK
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
