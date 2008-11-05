From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Use device_create instead of
	device_create_drvdata in linux modules
Date: Wed, 5 Nov 2008 16:37:43 +0100
References: <20081105144838.GA30895@sven-desktop.lazhur.ath.cx>
In-Reply-To: <20081105144838.GA30895@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4887933.kjpF4D9xj4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200811051637.46836.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart4887933.kjpF4D9xj4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 November 2008 15:48:38 Sven Eckelmann wrote:
> The function device_create_drvdata was renamed to device_create in linux
> v2.6.26-5782-g4e10673. Until v2.6.27-4446-g7fb6b5d there was a
> compatibility define in include/linux/device.h which is removed in linux
> 2.6.28-rc1.
Sry, the conditions for the compat*.h stuff are obvious wrong. A revised pa=
tch=20
was send to the ml.

Best regards,
	Sven Eckelmann


--nextPart4887933.kjpF4D9xj4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkRvcgACgkQqQGwKVlMoDuKegCeKeuNdRbOP1rBkMPdRGe/Vtfj
PggAn0wDznDl+485vj2Jx4gB20aMGmy/
=fmEF
-----END PGP SIGNATURE-----

--nextPart4887933.kjpF4D9xj4--
