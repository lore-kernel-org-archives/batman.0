Return-Path: <a@unstable.cc>
Date: Wed, 14 Sep 2016 15:02:06 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160914070206.GQ10966@prodigo.lan>
References: <1473717621-19067-1-git-send-email-jhaws@sdl.usu.edu>
 <3465008.gDXinMeYCA@sven-desktop>
 <1473770375.4019.0.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qyHYMwAXsHLOQihY"
Content-Disposition: inline
In-Reply-To: <1473770375.4019.0.camel@sdl.usu.edu>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] alfred: Externalized synchronization
 interval
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--qyHYMwAXsHLOQihY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 13, 2016 at 12:39:35PM +0000, Jonathan Haws wrote:
> On Tue, 2016-09-13 at 07:23 +0200, Sven Eckelmann wrote:
> > On Monday, September 12, 2016 4:00:21 PM CEST Jonathan Haws wrote:
> > >=20
> > > ALFRED_INTERVAL is now externalized via the -p option
> > > (synchronization
> > > period).=A0=A0If specified as option, user supplied interval is used,
> > > otherwise the default interval of ALFRED_INTERVAL is used.
> > >=20
> > > Signed-off By; Jonathan Haws <jhaws@sdl.usu.edu>
> > > ---
> > It should be "Signed-off-by:"
>=20
> Shoot! v3 coming...dang fat fingers!

tip: if you create the commit using the "-s" option, git will add the
signed-off-by line for you ;)


cheers,



--=20
Antonio Quartulli

--qyHYMwAXsHLOQihY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX2PXuAAoJEJ4aZjxxc6bKqzIQAIDWg69pXOr+oo6NPeUPFpOh
sdV85yl5tXNTLKI4yhUM0Rib/4Wf1gw32BDnTv4UdGrbzi8wUfHhx1MwLRyvCp5n
kj6q5Y5FmoWdHjj9lsF/8m30cQatLEpbkkonsolT4jVqLETgDFcyNNlBZRM1wmVS
SaGvoTb8g7G16YWOOzmrEPTzOP1QeULCcleEm86gTOmeiBtkgAqGSePVaLqCTly3
LoFdLOEhJoLm2/45Vze9xhiI3g/6Pw4v7tDoBYQ6nCrjWhZMp8a6y89UoZhU4e+m
H05cxfZHt1AVTDLvShae1gTxSjaSnGAswjPdNbJ89gejw+9sr/0t3fAeXJOUN8T7
Msz+TbKmtTKacBXbs9F2+rKtGncCaLCUjCOLUGDAA/5So8EdCzoB5fBO/KSF2a8G
C8ZZBGMEakUAlyfgCHIu61QwMd+KMEHrOXh9Ys7ntkeekCU5tlEeJSTk9q/IExfW
nexqL1ns97797LB0sxpNzgSLOraogPktmbly+/zfguWQJrdKdLs61+Hw1KU+p1sC
7MGS3QzLpOIUp42g3fLSHp58nziaMb4Z3+/QJIxCBbnBNapCF78eq8kZnmtt1xaq
C0YOdt5sclT01lnAy6cHxDUXnLygjZxny4ylZS5WPaPodU6z9Y24+XwiJPbsorMD
0jrhR5XIzmEtkLKW2Hni
=GSuS
-----END PGP SIGNATURE-----

--qyHYMwAXsHLOQihY--
