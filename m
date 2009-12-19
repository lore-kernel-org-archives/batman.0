Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 19 Dec 2009 01:44:43 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091219004443.GA26489@pandem0nium>
References: <94CAE17FD1DB4640BF8FF28D61FDFA8A22C241@RESQNAOEX01.qnao.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <94CAE17FD1DB4640BF8FF28D61FDFA8A22C241@RESQNAOEX01.qnao.net>
Subject: Re: [B.A.T.M.A.N.] wireless adapter and linux kernel version
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric,

there are a lot of wifi cards and drivers which don't support ad-hoc mode.
I had bad experience with RTL based wifi cards. More info about drivers and
supported modes can be found here:

http://linuxwireless.org/en/users/Drivers

Try to use Atheros based cards, most of them support Ad-Hoc mode.

best regards,
	Simon

On Fri, Dec 18, 2009 at 04:45:50PM -0500, Conner, Eric wrote:
> I have been trying to get my wireless network to establish an ad-hoc
> network and I just can't seem to do it.  It appears the linux 2.6.31
> kernel does not support the RealTek 8185L (Encore ENLWI-G2) wireless
> card I have.  The drivers it does install are older and seem to not
> support Ad-Hoc networking. =20
>=20
> =20
>=20
> Can anyone recommend a wireless card and/or a linux distro that easily
> supports ad-hoc networking?  I have the tried latest openSuse and Ubuntu
> distros.=20
>=20
> =20
>=20
> Is this a common problem with Linux?  I have set up wireless ad-hoc
> networks before in windows and never really had a problem.
>=20
> =20
>=20
> Or better yet - does anyone have patches to the realtek 8185L drivers to
> use the net_device_ops struct as opposed to the deprecated net_device
> struct?
>=20
> =20
>=20
> Thanks
>=20
> Eric
>=20

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkssIfsACgkQrzg/fFk7axaMgACeODNzgJWBIx/LJO33DRxaT1Eu
ezkAn2D7cFaCEDQ+G3VyVMmqb7MOppFN
=m/SP
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
