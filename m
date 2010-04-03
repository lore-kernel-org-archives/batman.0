Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 3 Apr 2010 18:41:40 +0200
References: <4BB70C4B.5000909@nord-west.org>
	<201004031154.19191.sven.eckelmann@gmx.de>
	<4BB73808.8080105@nord-west.org>
In-Reply-To: <4BB73808.8080105@nord-west.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1423333.THiaSMTbqd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004031841.46758.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] running batman-adv in a openvz VE
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

--nextPart1423333.THiaSMTbqd
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Bjoern Franke wrote:
> Hi,
>=20
> thanks for your reply!
>=20
> > I have never used openvz, but adjusted some protocols to deal with open=
vz
> > aware kernels (which means that they used and checked their namespace -
> > so nothing really fancy).
> >
> > What must be done for device drivers to make them work on OpenVZ? Have
> > you tried it and where have found you problems?
>=20
> OpenVZ-Containers use the same kernel as the host system and I can build
> and load the module on the host, but I don't know how to access
> /proc/net/batman-adv from within the container. The container uses a own
> proc-fs.

Ok, that is correct. I wanted to check how to work around such problems and=
=20
how to implement it in the new configuration api/multiple bat-device=20
implementation for 0.3 (or later) - but unfortunately  OpenVZ for 2.6.32 wa=
s=20
only good to crash my system very hard. (but it is at least a known upstrea=
m=20
bug :) )
So it can take a little bit longer until I really checked what we can do he=
re.

Just some small question: Why do you want batman-adv in a VE? batman-adv ru=
ns=20
entirely inside the kernel. This means there is no benefit in running it in=
 a=20
"secure" environment because it doesn't run there. The real hardware used f=
or=20
the mesh is also part of the host and not the ve (unless you do some kind o=
f=20
device sharing with VE_NUMBER.conf - which seems to be a little bit=20
overcomplicated).

To me it sounds easier and more straight forward to use veth inside the ker=
nel=20
and do the configuration outside (it only configures the kernel - so no=20
security or separation benefits). The userspace applications like tinc can =
now=20
run inside the ve with the correct setup in the host.

Best regards,
	Sven

--nextPart1423333.THiaSMTbqd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLt2/FAAoJEF2HCgfBJntGEwYQAMFWhP/ZUfs1PlUdYirGVF7A
jt8rM9Wkw+KrdPbpYjzqz9ko0CFwijvUwjmLwIem+wRNag7Llq3dOuE1tUA+E8Su
KZ2F4WkEDEogutCHdXAqID7u+yax2Gm0E97Q24KrcCL6tjTcrO9IZaRRBNB+C8Ff
5KKPmG9tGH1g/4OysTeZz/XsnrQrzoftnscz7fJT9/ve5Hb4IOe4LMMa25EZmtRo
YANzut0vM//cibYx96aNVNAokNbp174H/cOYpLxOop1+Dcjwaz5sxQ/K+pTGOzOM
fYI+/ZwQZKBEExrVpce4SFDHE3dp595ORJDABJPFhW2F9lAliWB8tbAJURX8Lc02
+u0mop9GHLj3SnHMNi0Nu0IJfFgzwaUXbUZRBvXIW1P+FIvqHS3qxROU7fGZ3xG5
30JW+M47Qikmqvhk3fkOHd5vFkWpmF8lhIo27KUoWOk7sjmDWVn/gfmFeQzv2pHV
yIMCIH0St3DL1Vm1ZXUjXygJVIsz0eBqnpEWRnPoEXEh9pz7lIzHbw5K8yQnzx/X
m5sGpMJgIXdnyHC4/FTfB5HmF5xZLjqE5Ry40W/nt+5tGchW1UtjpI7RHf9bDtLb
QmlEXhNkSvphMpuR8e7qsPshtTl7ZcpREBWzRdTkxfpJ63XFS0ZQOV7FY26b5IBi
JwCiLuebMFiExDvJGiJO
=3wPe
-----END PGP SIGNATURE-----

--nextPart1423333.THiaSMTbqd--
