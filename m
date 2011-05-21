Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2011 09:00:31 +0200
References: <1305934387-25000-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1305934387-25000-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1369084.vdeRpptAVQ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105210900.32787.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use
	is_broadcast_ether_addr() instead of compare_eth(.., brd_addr)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1369084.vdeRpptAVQ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli wrote:
> Instead of comparing mac addresses with the broadcast address by means
> of compare_eth(), the is_broadcast_ether_addr() kernel function has to be
> used.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Acked-by: Sven Eckelmann <sven@narfation.org>

> ---
>  routing.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/routing.c b/routing.c
> index 07f23ba..90ae6f0 100644
> --- a/routing.c
> +++ b/routing.c
> @@ -661,7 +661,7 @@ void receive_bat_packet(const struct ethhdr *ethhdr,
>  				hard_iface->net_dev->dev_addr))
>  			is_my_oldorig =3D 1;
>=20
> -		if (compare_eth(ethhdr->h_source, broadcast_addr))
> +		if (is_broadcast_ether_addr(ethhdr->h_source))
>  			is_broadcast =3D 1;
>  	}
>  	rcu_read_unlock();

--nextPart1369084.vdeRpptAVQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN12MPAAoJEF2HCgfBJntGP1sP/jFjZf8jjXyFped1ryRf9Usb
KHEv3vdcdu9hQlPv4djlPWTd4t3fG7i/fqaUHMTgk9ZgF+j5mF9npUYifpn9dMI/
1sN3sTey0DGQJIUhQnCi/AzzgjJcU9R2tbzmLMxGKirBR+BIwRPEk6RhTRAi3OoK
nUvQXvpNMdTvj1MoLyYRPsoJ1GBWOVn271yhDILEIi3j8irCwpk40RCcpvKAuX8x
N743QcfDcdkPY6lu1WXjr2Bdg9SRs0gPrVgjMrWA42vlr3mjtyCF1hZLGOZmV2ho
8cxU7mfXm3QuBU8gwGxx+8A+BY/BrkbJxsH33FV/EJlTr1/Vz0/H2GQ29l3XtAjn
K9oW0QdrE7CmRZzcDJsN7ETXigPDldf7E+4ag+sUz+goArC1oTB3ssVB1lD3ZZfV
HEOGXQTUjKMLcSN2u4WhJNpDv+cGYWXTAk1v4VyZdCWbB+oSJYYekLFjMCoHZ8Ze
dSpoN6bMeNsxrNfpRXSVyZqh6KtMTkHHC3v1zjM3ioAwjW9U5GjIWSBswyrvAGzQ
+eTybq0Ks+3kP4zx74xwx+cVWzocGL4IPlJP4jp6Xx1PKi2h+dLmtR+6gQC/zMcw
Ix/rPZAFoDgZ5Yw8A4M4pErC1IWyrAvxvZTMzB9sgAsNp069EC3dEaV3XktqhwIx
8YM7EeW1FdtfmO+i2/NM
=0m7s
-----END PGP SIGNATURE-----

--nextPart1369084.vdeRpptAVQ--
