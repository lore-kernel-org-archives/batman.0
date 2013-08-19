Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 19 Aug 2013 22:20:28 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130819202028.GB18020@pandem0nium>
References: <1376595170-506-1-git-send-email-ordex@autistici.org>
 <1376600755-544-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <1376600755-544-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: check if a softif_vlan
 already exists
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


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Antonio,

Thanks, that solves the problem on my ancient kernel! :)

I don't see a problem with -EEXIST (at least there is no error
whatsoever), so I think we can leave it at that.

Tested-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>

Just one thing ...

On Thu, Aug 15, 2013 at 11:05:55PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Before creating a new softif_vlan it is better to check if
> that does already exist.
> If so batman-adv should refuse to create a new structure
> otherwise this would lead to an inconsistent state.
>=20
> Normally this is not a problem because the operating system
> will prevent from creating the same vlan twice, but some
> ancient kernels exhibited an improper behaviour that led to
> a bug.

You might want to skip that when sending upstream? They might not
care about older kernels. Duno. :)

Thanks!
	Simon

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlISfgwACgkQrzg/fFk7axaaFACZAcDep2LDJNsXyp0iNVRUlTWZ
jfgAn01Y1+7nwZVtrxO2m6nPEyWe4IYQ
=gLnB
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
