Return-Path: <ordex@autistici.org>
Date: Sun, 14 Oct 2012 22:05:02 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121014200502.GF7023@ritirata.org>
References: <1350244981-14026-1-git-send-email-ordex@autistici.org>
 <1350244981-14026-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline
In-Reply-To: <1350244981-14026-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: export compatibility
	version via debugfs
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


--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2012 at 10:03:01PM +0200, Antonio Quartulli wrote:
> Different versions of the batman-adv module may use the same compatibility
> version, but this is not understandable at runtime (the only way is to pa=
rse the
> kernel log and fetch the batman-adv advertisement message on loading). Th=
e user
> may want to know whether two nodes using different versions can communica=
te or
> not. For this purpose the module has to export this value through debugfs.
>=20
> Reported-by: Moritz Warning <moritzwarning@web.de>
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

2/2 intended to be v2 of a patch with the same name sent some days
ago over the ml. This PATCHv2 is based on the array of general attributes
introduced with 1/2.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEUEARECAAYFAlB7Gu4ACgkQpGgxIkP9cwcZdwCfb+xer7xPsdPQht1nXV77qWCc
ntAAlAu7jpb3ZMgQ/rgZw9o1/Uct/dk=
=d17f
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
