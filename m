Return-Path: <mschiffer@universe-factory.net>
Message-ID: <51017050.7000300@universe-factory.net>
Date: Thu, 24 Jan 2013 18:33:04 +0100
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <20130124151221.GA8211@ritirata.org>
 <1359047907-23522-1-git-send-email-mschiffer@universe-factory.net>
 <463977c0dcf7b3fcc6a2aebbb87add0d2377d3de.1359047612.git.mschiffer@universe-factory.net>
In-Reply-To: <463977c0dcf7b3fcc6a2aebbb87add0d2377d3de.1359047612.git.mschiffer@universe-factory.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2KSOBXODQDFXFDJNTCMKQ"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: filter ARP packets
 with invalid MAC addresses in DAT
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KSOBXODQDFXFDJNTCMKQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/24/2013 06:18 PM, Matthias Schiffer wrote:
> We never want multicast MAC addresses in the Distributed ARP Table, so =
it's
> best to completely ignore ARP packets containing them where we expect u=
nicast
> addresses.
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  distributed-arp-table.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index a35466a..c89a01e 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -738,6 +738,7 @@ static uint16_t batadv_arp_get_type(struct batadv_p=
riv *bat_priv,
>  	struct arphdr *arphdr;
>  	struct ethhdr *ethhdr;
>  	__be32 ip_src, ip_dst;
> +	uint8_t *hw_src, *hw_dst;
>  	uint16_t type =3D 0;
> =20
>  	/* pull the ethernet header */
> @@ -782,6 +783,18 @@ static uint16_t batadv_arp_get_type(struct batadv_=
priv *bat_priv,
>  	    ipv4_is_zeronet(ip_dst) || ipv4_is_lbcast(ip_dst))
>  		goto out;
> =20
> +	hw_src =3D batadv_arp_hw_src(skb, hdr_size);
> +	if (is_zero_ether_addr(hw_src) || is_multicast_ether_addr(hw_src))
> +		goto out;
> +
> +	/* we don't care for the destination MAC address in ARP requests */
Oops, this comment should be "care about" ... if the patch is okay apart
from this, should I make a v3, or can you just fix it when applying the
patch?

> +	if (arphdr->ar_op !=3D htons(ARPOP_REQUEST)) {
> +		hw_dst =3D batadv_arp_hw_dst(skb, hdr_size);
> +		if (is_zero_ether_addr(hw_dst) ||
> +		    is_multicast_ether_addr(hw_dst))
> +			goto out;
> +	}
> +
>  	type =3D ntohs(arphdr->ar_op);
>  out:
>  	return type;
>=20

Matthias


------enig2KSOBXODQDFXFDJNTCMKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEBcFAACgkQq3qIxbiQM9hb6QCZAY4IXnEPbcz4WiAwALCPHs3z
uiEAoI5kCfanQEeB53DzJqfNg6Edu8Dz
=7/us
-----END PGP SIGNATURE-----

------enig2KSOBXODQDFXFDJNTCMKQ--
