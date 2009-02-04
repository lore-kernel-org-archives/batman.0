Date: Wed, 4 Feb 2009 21:56:12 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090204205611.GA13896@pandem0nium>
References: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <2ced936d0902041003g74679247i56b83a29b18e7dd2@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Stable adapters for Ad Hoc networks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Breno,

sounds like the well known ad-hoc cell splitting problem to me. A common
workaround is to fixate the BSSID to some pre-defined value:

iwconfig athX ap 02:CA:FF:EE:BA:BE

hopefully all your drivers support this. :)

best regards,
	Simon

On Wed, Feb 04, 2009 at 03:03:35PM -0300, Breno Jacinto wrote:
> Hello everyone,
>=20
>   I`m running several experiments involving ad hoc networks. I`ve
> selected some well known-to-be-compatible adapters, such as Edimax
> (Ralink shipset), Alfa networks (Realtek) and Atheros (madwifi).
> Atheros is available only as built-in adapter on the equipement or as
> a  PCI board.
>=20
>   So, I'm experiencing some instability regarding the selection of
> the BSSID used by all the nodes. I start the network with a single
> node, then another, then another. Now, for a couple of minutes it
> works, bu then some nodes start losing sight of each and changing
> their BSSIDs to a different value (and they should always use the
> same). I'm really running out of
> explanations of why this is happening, because these nodes are all
> in-range of each other, and should be "pingable" directly. My main
> suspect is the driver instability, but then I dont know of any other
> better alternatives. I've tested the following USB adapters:
>=20
> - Edimax EW-7318USg (rt73 drivers)
> - Alfa AWUS036H-11g
>=20
>   And the builtin adapters:
>=20
> - Atheros chipset AR5007EG
>=20
>=20
> best regards,
>=20
> --=20
> --=20
> :: Breno Jacinto ::
> :: breno - at - gprt.ufpe.br ::
> :: FingerPrint ::
>    2F15 8A61 F566 E442 8581
>    E3C0 EFF4 E202 74B7 7484
> :: Persistir no dif=C3=ADcil =C3=A9 a =C3=BAnica maneira de torn=C3=A1-lo=
 f=C3=A1cil algum dia.  ::
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJigDrrzg/fFk7axYRAk8QAJ9O76YpSsZ7F4YlfGOCdVMzlgxjqQCghJWF
8Do0FGAC4gG9ASicOnh700g=
=paEZ
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
