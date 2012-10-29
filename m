Return-Path: <ordex@autistici.org>
Date: Mon, 29 Oct 2012 16:11:20 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121029151120.GC3142@ritirata.org>
References: <1351523401-9188-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <1351523401-9188-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't free resources when
	DAT is disabled
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


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 29, 2012 at 04:10:01PM +0100, Antonio Quartulli wrote:
> Freeing all the resources when DAT is disabled need a much more complicat=
ed
> locking system to prevent concurrent enable/disable operations to destroy=
 the
> internal state of the component. For now it is safe to avoid such freeing
> operation at all when DAT gets disabled.
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---


This was introduced with ("batman-adv: Distributed ARP Table - add runtime
switch")


Cheers,
--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCOnJgACgkQpGgxIkP9cwcucQCfd40B+ITGRoNY8CL69vXIx+ko
L/0An0nibow8ETXpEGZszREaH11rFXKI
=6M/3
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
