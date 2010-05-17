Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 17 May 2010 19:51:13 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1724017.QyXWchEjk7";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005171951.21349.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] Converting from /dev to debugfs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1724017.QyXWchEjk7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

we had decided that different files must move from sysfs to debugfs in rece=
nt=20
discussion with gregkh. But their was also the problem that we currently us=
e=20
/dev/batman-adv to send special batman-adv "icmp" packets to the mesh. This=
=20
file is maybe a problem when we want to support different batX interfaces o=
n a=20
single machine.

So we have the problem that we want to move different files to debugfs and =
get=20
support for it in batctl. It seemed to be easier (better readable) for me t=
o=20
first start to get a single file to debugfs and then build on top of the=20
created infrastructure in batctl/batman-adv-kernelland to move more files. =
My=20
choice was /dev/batman-adv as we had some open question how good it works w=
ith=20
debugfs.

Unfortunately I am not able to continue it today, but don't want to stop ot=
her=20
people working on similar things. I will attach v0 (aka works for me, but=20
maybe not perfect/good enough) versions of these patches to support them.=20
Please feel free to discuss the patches.

Best regards,
	Sven

--nextPart1724017.QyXWchEjk7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL8YISAAoJEF2HCgfBJntGMEUQALlqBpA4X4QwxswKSkRQ3G8U
Vo/y1SdGKt9xdG/GZulGMvr0tp+u1BfD9IRzXs9cUbSxTOb/EfO+HUmBbBFW10ft
Oiop+o7OKHDxOagpdNScnAi9qHCU423E9vC1cRTW+N0CeVK6bSBMiy4cpIF1FhYh
ZnZYeNv0UY5TVEs/M1kShKzexI+cS+Ov8lVAA+NWA+JqWaVemMy8omnYkPeajx4h
OoZwBcW7ST8AmHUq0REmzcGCcFIv3Ui3ZNresHGMNlK9fhfekzdrW0zffT1xn7D+
zB9oFIYUObFIWJ8jiNeC0g3gCnBKTst3eFiiTnDiZfjogFP82gAQDJNab942VIqc
BdUGiUN3nPWBlM48P4arMYmoyJ29Yji4NpnRpR0hi/pTMVBtXuBoeUkSa0j86zO+
peTozs51Hffg7VTiJBp2tjkXwjHOzpymdt6TqdCv4JOcd5lFKahb/u7NOeEZFbQI
g4Cwanqx7wQoUFo2/4EJjofXOgwK5X2RhDzjTGEE5xrczQVOpF0Mjg8UOrMnUtHO
q1As/3oMNemwe3J0eez8fVSFWyI8oMCYD5HO1yOovRo33CDcOdOQHOWUgyGb9N4T
n5oHEvDbtP/3xXMiezciu8uhqkWQJEA9Ti/jlGl6VRH7yEH5odIwB5NE8uZxL5En
O1BNJPyJ3rrNQeP4Et/r
=EBbZ
-----END PGP SIGNATURE-----

--nextPart1724017.QyXWchEjk7--
