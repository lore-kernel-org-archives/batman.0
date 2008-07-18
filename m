From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman and Kernel 2.6.26-rc8&rc9
Date: Fri, 18 Jul 2008 10:25:18 +0200
References: <1216040292.12178.3.camel@mkellyDell>
	<20080714154944.GA16555@hrz.tu-chemnitz.de>
	<1216345707.2919.1.camel@mkellyDell>
In-Reply-To: <1216345707.2919.1.camel@mkellyDell>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2198457.AK60Cm75rD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200807181025.22999.sven.eckelmann@gmx.de>
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

--nextPart2198457.AK60Cm75rD
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 18 July 2008 03:48:27 Mark Kelly wrote:
> I just got around to trying this again on 2.6.26 final and I'm still
> getting a fail error on the gateway module, and I've tried it using
> r1099 and r1100 under openwrt on an ixp4xx board.
Please look at device.c on line 88 till 92. There should be a #if section w=
ith=20
should definitly use device_create_drvdata instead of class_device_create.=
=20
Please check if it is there... your debug output looks like it isn't there=
=20
(which sounds like a broken svn checkout). I think that it is that because=
=20
your line numbers in your build log are different.

If it is correct, please check the version numbers in our linux toplevel=20
Makefile (should be VERSION =3D 2, PATCHLEVEL =3D 6 and SUBLEVEL =3D 26).

I tried it now with vanilla 2.6.29-rc9 and it worked fine for me. I will tr=
y it=20
on openwrt later

regards,
	Sven


--nextPart2198457.AK60Cm75rD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiAU24ACgkQqQGwKVlMoDvgQgCff6W1uoZEjxKdXKaQJd48ofl8
2+0AoIyQTuXZNLu37pnS5eSGI8xRHjhx
=b+aB
-----END PGP SIGNATURE-----

--nextPart2198457.AK60Cm75rD--
