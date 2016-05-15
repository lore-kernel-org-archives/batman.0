Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2016 14:53:38 +0200
Message-ID: <3203929.qiFO0UqUVO@sven-edge>
In-Reply-To: <20160515123733.GH4375@otheros>
References: <20160514145129.GD4375@otheros> <22866212.dooYpi8Uhz@sven-edge>
 <20160515123733.GH4375@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3076118.MKdMp4bofo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
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

--nextPart3076118.MKdMp4bofo
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 15 May 2016 14:37:33 Linus L=FCssing wrote:
> On Sun, May 15, 2016 at 02:15:01PM +0200, Sven Eckelmann wrote:
> > On Sunday 15 May 2016 14:06:26 Linus L=FCssing wrote:
> > [...]
> >=20
> > > [0]
> > > https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linu=
s/kmem-
> > > cac
> > > he
> >=20
> > This patchset has a bad bug. It still uses kfree for tt_local objec=
ts
> > allocated via kmem_cache_(z)alloc.
>=20
> Where?

Search for kfree( in my patch [1]

Kind regards,
=09Sven

[1] https://git.open-mesh.org/batman-adv.git/blob/60ebd7bc66140380c5931=
e8d8d2c36e17cc9d338:/net/batman-adv/translation-table.c#l706

--nextPart3076118.MKdMp4bofo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOHFSAAoJEF2HCgfBJntG+40P+wVUQquieTPe0lvYepWhhEHE
1jpE/cMK5VwkR8naTWTP7Rh/gYLsxOMMhSagh42kYSmQKNefdEvXBppcWG/pviAS
KrL6PmtreyXNsxDK4ul05tLwNske88KOlRaScc4a/jIyXbTQ5GXC9Qc6j6pTs2g4
gCfRaiR+OASDNBFag7qKVOTdXvUgE5792fVCkHT461oeF3UIolwPmU2a6YO3gRB2
wXMfgr2tJFQWh37t29lOphZJp1b6eHsbASbgMzYw+mRizk2k4jnoh1cu4jwKW5KE
w/ZQt5wE7c0tUEHiQBWr85zHvBdoNoahlBOJapBjNs0MN10BmysbCJpsUl+GKDWJ
5wyLlB7GGkAXlVX0Esu1RdM04/t3bu5MAB2KiiMqJ+YP9ROF+/DVPfwlQBhI8qlN
IADw97l1TdAxjtGvyCiOeh1fZxySU3M4b0OMTNCCLYxOGdMicHY/FXCo8aAV7D91
SGbYGgYzEOn2AbSjmUiaxnFf5kOWLcgcBRT6ZIZnCyA2xPVHgmZgsQYi6yxi+15Z
Z6vVfriAHBQbXJWTJbcT2hv7CgxFtKeZv17Zwq+6rOElVRQG9AC93MI2DRgc0Yyf
rux6bs218BmLkd9iYK+Zp5eKbs7ehXOVocNWlE4QRiujBrqsEn9XSRQZ8ZWDFoRb
hku4oJVzLbXbgXGHL0Fp
=UlPo
-----END PGP SIGNATURE-----

--nextPart3076118.MKdMp4bofo--

