From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Error " LibG3D-WARNING **: no handler for file "
	with meshs3d
Date: Mon, 16 Jun 2008 15:08:22 +0200
References: <e58370e60806160527y7536a733la99c827ba944211f@mail.gmail.com>
In-Reply-To: <e58370e60806160527y7536a733la99c827ba944211f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3821476.3ZFQKdkIP9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200806161508.27511.sven.eckelmann@gmx.de>
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

--nextPart3821476.3ZFQKdkIP9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

You wrote:
> I
> received the same error just when I'm not root or when another meshs3d
> process is running, but ever the symbols are appeared.
Can you rewrite this sentence? I am not able to understand when something=20
(not?) happens.

> ldd of meshs3d recognize libg3d library. What do you exactly mean with
> those 3ds plugins? where can we found them or realize if we've got them
> installed?
libg3d has its own plugin infrastructure and you cannot detect dependencies=
=20
with running ldd on meshs3d. If you have installed the debian package for=20
libg3d then you should have another one with the name libg3d-plugins which=
=20
also must be installed. (Yes, the package description is wrong and the next=
=20
debian package release should have it marked as recommended for libg3d).
To check if you have the plugin installed, search for imp_3ds.so in /usr (i=
f=20
you have installed libg3d there).

find /usr/lib -name "imp_3ds.so"

Please check file permissions if find is successful.

Best Regards,
	Sven

--nextPart3821476.3ZFQKdkIP9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhWZcYACgkQqQGwKVlMoDvseQCdFbj6sQ7M/PPzOkUX4dUbiTK1
gF4AoI7ECf6fjeefjLZHTwSMukk5r6DD
=fV08
-----END PGP SIGNATURE-----

--nextPart3821476.3ZFQKdkIP9--
