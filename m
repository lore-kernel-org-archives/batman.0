Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 1 Oct 2012 22:56:19 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121001205619.GA15826@pandem0nium>
References: <1347712461-9031-1-git-send-email-ordex@autistici.org>
 <20120929112757.GB3022@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20120929112757.GB3022@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: recompute mac_len at the
 beginning of the rx path
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


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,

although I agree that it is the better way to get the fix in the kernel ins=
tead of
batman-adv, it would be good to have a workaround in batman-adv for out-of-=
tree
versions.

I've just sent a (pretty dirty) suggestion, another idea would be to get pa=
tches in
the various distributions (openwrt, debian, gentoo, ...) - which would stil=
l leave
the problem open for the next "source" release.

Cheers,
	Simon

On Sat, Sep 29, 2012 at 01:27:57PM +0200, Antonio Quartulli wrote:
> On Sat, Sep 15, 2012 at 02:34:21 +0200, Antonio Quartulli wrote:
> > It is possible that the mac_len is not properly exported because of str=
ange
> > device configuration (this behaviour has been observed when using batma=
n-adv on
> > top of a vlan interface). Therefore it is needed to explicitly recomput=
e it at
> > the very beginning of the rx path
> >=20
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
>=20
> Instead of merging this patch I think that the best approach would be to =
fix the
> problem in VLAN code in the kernel.
> I'll try to send a patch to netdev.
>=20
> Cheers,
>=20
>=20
> --=20
> Antonio Quartulli
>=20
> ..each of us alone is worth nothing..
> Ernesto "Che" Guevara



--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlBqA3MACgkQrzg/fFk7axZvqACgthlTkClqC0KBpQGhY204GvzI
1E8AoJ+RC9siDFxLAuE/VkOz1SuVyX3A
=OI5S
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
