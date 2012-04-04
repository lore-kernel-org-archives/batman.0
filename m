Return-Path: <ordex@autistici.org>
Date: Wed, 4 Apr 2012 12:09:55 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120404100954.GB31398@ritirata.org>
References: <1333489822-27692-1-git-send-email-ordex@autistici.org>
	<1333489822-27692-3-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <1333489822-27692-3-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: clear the PENDING flag
 in case of client re-addition
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


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 11:50:19 +0200, Antonio Quartulli wrote:
> During an OGM interval (time between two successive OGM sendings) a client
> could be deleted (e.g. due to roaming) and then be re-added immediately a=
fter.
> After the deletion, the client is marked with the TT_CLIENT_PENDING flag.
> Therefore, in case of re-addition, the latter flag has to be reset
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
> +	/* if the client is marked as PENDING means that it has been marked for
> +	 * deletion during THIS OGM interval and the event has not been
> +	 * announced yet. Therefore we can simply unset the flag. The event from
> +	 * the event queue will be automatically be removed from the queue.
> +	 * Otherwise we can set the NEW flag */
> +	 if (tt_local_entry->common.flags & TT_CLIENT_PENDING)
> +		tt_local_entry->common.flags &=3D ~TT_CLIENT_PENDING;
>=20

mh..When I wrote this patch "batman-adv: unset the TT_CLIENT_PENDING flag if
the new local entry already exists" was not applied yet, therefore this pat=
ch
must be reviewed.

Please wait before considering committing this patchset.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPfB3yAAoJEFMQTLzJFOZF2HUIALOH+sX4EFLrCkT9eATly9LC
l0NQ+Uu5NeNkaLQI0R+PAn+2REK+sRKhsAUPqzZ7PYHjxVVEEkDIkAE+U9oq22At
2qq4DhnzNcP4Jb22Wu87pdlPtoz/Zc6EYpTHJbfuvsaM2Lx4hI3YKOeuoPIT28hp
UmFBn2I2YXL3z1gTXWs/7cgxiS/0V0E1FcbetGiMUmWbrJtvFp73IqkLbL2AVeta
DzRALAcdh9NTx3yYZN808M1K240ZIW42pGL/9HrOeFnTaUIB8R9V0VFcF8mYs14j
4EA6DJz/o402e1AoP1oyxYPWgPwUb4uXHX2zxpJ51hx0urh1f0Q4ZuNx/1uDfP0=
=bphs
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
