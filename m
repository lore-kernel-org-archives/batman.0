Return-Path: <ordex@autistici.org>
Date: Wed, 17 Oct 2012 15:36:40 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121017133640.GR7023@ritirata.org>
References: <1350479255-904-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="22hJjvOmZW2O/jbw"
Content-Disposition: inline
In-Reply-To: <1350479255-904-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Do not add multicast MAC
 addresses to translation table
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


--22hJjvOmZW2O/jbw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2012 at 03:07:35PM +0200, Linus L=C3=BCssing wrote:
> The current translation table mechanism is not suitable for multicast
> addresses and we are currently flooding such frames anyway.
>=20
> Therefore this patch prevents multicast MAC addresses being added to the
> translation table.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>
> ---
>  soft-interface.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/soft-interface.c b/soft-interface.c
> index 2d1f895..9955319 100644
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -180,7 +180,8 @@ static int batadv_interface_tx(struct sk_buff *skb,
>  		goto dropped;
> =20
>  	/* Register the client MAC in the transtable */
> -	batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);
> +	if (!is_multicast_ether_addr(ethhdr->h_source))
> +		batadv_tt_local_add(soft_iface, ethhdr->h_source, skb->skb_iif);

How can the source address be multicast? Usually multicast addresses are fo=
und
in the destination field...

Is there any scenario where this is possible? I am wondering whether we sho=
uld
directly drop packet having mcast address as source..

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--22hJjvOmZW2O/jbw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlB+tGcACgkQpGgxIkP9cweiLQCdHFXp/WYKIMXmIbDlWvOWLZp/
460AnRGfukVxBwUWAZVXnfrUXycXrC6h
=RiO5
-----END PGP SIGNATURE-----

--22hJjvOmZW2O/jbw--
