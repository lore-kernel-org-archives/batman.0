Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 3 Dec 2009 14:21:14 +0100
References: <20091129200950.GA19275@pandem0nium>
	<1259842422-2566-1-git-send-email-simon.wunderlich@s2003.tu-chemnitz.de>
	<20091203131150.GA7795@lunn.ch>
In-Reply-To: <20091203131150.GA7795@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart180001353.7drWN3p5IV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200912031421.28772.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] [batman-adv] Removing the big batman
	lock
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart180001353.7drWN3p5IV
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> > It seems to deadlock according to
> >=20
> > https://lists.open-mesh.net/pipermail/b.a.t.m.a.n/2009-December/001938.=
ht
> >ml
> >
> > Patch was modified by Sven Eckelmann <sven.eckelmann@gmx.de> to apply
> > cleanly against r1490.
>=20
> Is this just modification so that it cleanly applies? Or does it also
> fix the deadlock?
No, deadlock isn't fixed yet. Just was nerved that it didn't apply when I=20
wanted to test it. :)

And to the lockdep stuff. It is a real nice feature (I used it partly when=
=20
debugging another kernel module), but as I noticed the mathematical=20
correctness check is disabled on uml and cannot be enabled due to some=20
dependency problems. :(

It is real a problem because uml is a preemption-less uniprocessor kernel a=
nd=20
thus the spinlocks are just NOPs - so it is quite useless for any debugging=
 of=20
them. So back to the "lets crash my working machine" and/or qemu-based test=
s.

Best regards,
	Sven

--nextPart180001353.7drWN3p5IV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLF7tKAAoJEF2HCgfBJntGw9sP/i20G+QYFhmo7i4JvufOXqUH
T3+tQCmbnIcFo2TagDC2PtOClJ7ChKffmUYesuYRMaxQHZ+/5VnRjM0ub34WiXjt
On6SV0WGtVBAs61BUE0/VVEs2pnLrNyXTx1rp2/BaSJEgTOuRHAND4vihORI2Ob1
gN3GTaJAcfG7hYUjBIHf21+wovUWyIY231bsiI2X3XtqNT0FCWl+OYDkKy/5g85o
7Ho50pFHBDq80ZtBuWymdOumqpP5T4W2x6LzqUtHz7W4x6CjUNJW/hdKmgOZ7Zx0
ceHZfGC8vF9IK4ReC6NfKBsi3J/gYfxMqNNnbvwLUVDx5U9VlmT/kHWbhrr8R6dB
syOAaDfjUA+a/T88z2gYIbwOQk6c7NJge+L7mcuQL8+XnnyC9FefApIhjVU6qdUG
gdbXYNG3nyQnp5HwBJl6CqMfLuA89LhQoZU0J0h5eYsH22TIlOJYwzfj5fjvc3cT
yVzdjB4RnV5on+aK2zbVjonvWdxzQqqzdVsN3hYo//BZMjxN9Zgc/gZLIOe/WJzC
/jiuzL66tN8E7g0MG0fyRObzHMCHYqjHyra65sHeDTsnHYV5Pm+itE2Lj6ua+eex
suemQLIgZc9Xnq+vaz3URRy8eFQ5xzLAqxAg8c8Q4OgheAgKwLwD6Jz3HrtY2B2g
4IVh9RdPyOADsDRRQChQ
=z/qF
-----END PGP SIGNATURE-----

--nextPart180001353.7drWN3p5IV--
