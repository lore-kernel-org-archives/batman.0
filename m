Return-Path: <ordex@autistici.org>
Date: Wed, 7 Mar 2012 12:00:06 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120307110005.GB9675@ritirata.org>
References: <1331078299-2984-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <1331078299-2984-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix PENDING flag behaviour
 in case of multiple roamings
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


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please,

drop this patch. I realised there is a missing piece.

Cheers,

On Wed, Mar 07, 2012 at 12:58:19AM +0100, Antonio Quartulli wrote:
> In case of multiple romaings always between the same two nodes (going bac=
k and
> forth from one to the other) within the same originator interval (this is=
 much
> more suitable in setups where the orig_interval last longer than one sec)=
, the
> flags should not be messed up and should eventually converge to a correct
> status. In particular, if we marked a LOCAL client as PENDING due to the
> roaming, if the client comes back to us we have to simply reset the PENDI=
NG flag
> and remove the DEL event from the sending queue. This is possible because=
 the
> DEL operation has not been committed and advertised yet.
>=20
> If we don't do that, the client is deleted and then re-added, this can cr=
eate
> connection problems to the client and would also create useless noise in =
the
> network due to the advertisement overhead.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  translation-table.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
>=20
> diff --git a/translation-table.c b/translation-table.c
> index 9f4d706..4bd9490 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -206,6 +206,15 @@ void tt_local_add(struct net_device *soft_iface, con=
st uint8_t *addr,
> =20
>  	if (tt_local_entry) {
>  		tt_local_entry->last_seen =3D jiffies;
> +
> +		/* in case of multiple roaming in the same orig interval we
> +		 * should correctly handle the client flags: a client which was
> +		 * marked as pending can now be unmarked because it came back */
> +		if (tt_local_entry->common.flags & TT_CLIENT_PENDING) {
> +			tt_local_entry->common.flags &=3D ~TT_CLIENT_PENDING;
> +			goto reinsertion;
> +		}
> +
>  		goto out;
>  	}
> =20
> @@ -242,7 +251,7 @@ void tt_local_add(struct net_device *soft_iface, cons=
t uint8_t *addr,
>  		tt_local_entry_free_ref(tt_local_entry);
>  		goto out;
>  	}
> -
> +reinsertion:
>  	tt_local_event(bat_priv, addr, tt_local_entry->common.flags);
> =20
>  	/* remove address from global hash if present */
> --=20
> 1.7.3.4
>=20

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPVz+1AAoJEFMQTLzJFOZFHgsH/i8NOpgb/SYPc8eXDUZnIRd5
n0Kdpt2r6O/ivWg0Uv5eeBCcytDZJqxMXP+II51m5xED8NGQYHRtRXLkbvFC+0A8
jlQUlI8GGuCs5s0IqoXsk5sYXVhNWDTrcfD74x5FGkGZQHiAzu9Kd2LvjlztLqUR
SKGUVGGfQY3U0YJq/d6rCJ7jOz+nMl0bw/dFZhWx1NMorpsQQUZzxXPIFPZ9LwTV
7Kztk2p6gd5ftDXLPsP79i6LK6156QEQzvg08QWsnkG71lhxJ2OHoIeSRftPE8on
wIpzR+/ZlC2CIZsyZDFDQtyT94a/oXzHUANcULhsLpSb3hvjLIUhh9PjlTKaHJQ=
=VN6f
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
