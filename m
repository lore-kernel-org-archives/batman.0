Return-Path: <ordex@autistici.org>
Date: Thu, 15 Mar 2012 18:21:58 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120315172157.GE2990@ritirata.org>
References: <1331830115-16407-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <1331830115-16407-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add BAT_UNICAST_4ADDR
 handler in the packet-handlers array
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


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 05:48:35PM +0100, Antonio Quartulli wrote:
> Commit 1887248c268928ebb434edab611978f51e2a4b8f introduced the packet-han=
dlers
> array but it forgot to set a proper handler for the BAT_UNICAST_4ADDR pac=
ket
> type. This patch fixes it.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Sorry, but I forgot to say that this bug has been:

Reported-By: Martin Hundeb=C3=B8ll <martin@hundeboll.net>

> ---
>  main.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/main.c b/main.c
> index 75938fb..0757c2d 100644
> --- a/main.c
> +++ b/main.c
> @@ -265,6 +265,8 @@ static void recv_handler_init(void)
> =20
>  	/* batman icmp packet */
>  	recv_packet_handler[BAT_ICMP] =3D recv_icmp_packet;
> +	/* unicast with 4 addresses packet */
> +	recv_packet_handler[BAT_UNICAST_4ADDR] =3D recv_unicast_packet;
>  	/* unicast packet */
>  	recv_packet_handler[BAT_UNICAST] =3D recv_unicast_packet;
>  	/* fragmented unicast packet */
> --=20
> 1.7.3.4
>=20

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPYiU1AAoJEFMQTLzJFOZFIVQH/3Um2+3l7DxxQPuNNeD2Vkcc
18cTHvLWRHqsfpdaosWcfmXrEe/mX/tu92zO8NipiTssEMMHkyVEBjUNvaxniCoB
00xMKdNuY+W/ABsT/kEOgbREDNL54/MDIuhEOPOdWpepaU/yKwhMsfyZ5UfyldFO
Qyob2s8TkCojjP9+6Gl4IFqTX+q3TimtVyONEu5LVaAOo/SpCtD1Z9+gyUag+PAM
rr1SjFOXJ58le08Bsy4OFQ5z0EKvtXqN+HZNIjX1ArckV8fNiljuE7FQcHhY9TzA
Slo42SnS3mvJBLolKlZVFxMT49hbNJxudk6BhsXJMVPRcn8UvF+iPa0gudhlW1A=
=Yy+a
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
