Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:32:00 +0200
References: <201005221616.46785.sven.eckelmann@gmx.de>
	<201005221708.45102.sven.eckelmann@gmx.de>
	<20100522152712.GA4671@suse.de>
In-Reply-To: <20100522152712.GA4671@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2575994.4rSjqjeBOc";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005221732.01710.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv
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
To: Greg KH <gregkh@suse.de>
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart2575994.4rSjqjeBOc
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
[...]
> > The merge window is already closed? v2.6.34 was released 6 days ago. Or
> > do you mean that your merge window for staging is closed?
>=20
> The merge window is for the subsystem maintainers to send stuff to
> Linus.  That stuff must have already been in the linux-next tree for a
> bit to test it out and ensure that it doesn't break anyone.
>=20
> So that means that you need to get things to the subsystem maintainers a
> week or so before the merge window opens up if you want to see it go
> into the next kernel release.
>=20
> And yes, this means the merge window for the staging tree for new
> features is now closed.  Only bugfixes will be accepted for .35 from now
> on, but I can easily queue up stuff for .36, I just have to wait until
> .35-rc1 is out before I can add it to my public tree for inclusion in
> the linux-next tree.
>=20
> Hope this explains things a bit better.

Yes, helped a lot :)

thanks,
	Sven

--nextPart2575994.4rSjqjeBOc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9/jxAAoJEF2HCgfBJntGu/0P/0b/+liE7t6C4UvrLAgXz8Fm
b7wLz5L/OES0N/wnVg2i7cxRUQ6rKeLKSUrRooW4UmN76wYqPWkaBWpOPPIuDmHY
m9xNPF5ig++G1OCj5nrptTgA+rcDQeGjN7BbyMjyJnS4sV87JBr6VAAnylqsRZWu
sGe8wh9r8j4rQnFpl/Ka3/x6fQyP+hvVb4X4VYDoAh+za5+97jeu02t8G672d5WE
2Fu31nuWJmTUSScwG+mzynXwLU0kdE2eAdUjI2dEhTRoWYZ3fN6M8EGTu1E0UiIv
N2/fOEJsVCe/qJSWoeYoAHN+J3k1Mesgw+NmgiFZ35qZP38AV7eLEQiwetmA4+fe
He/SpPtbB30WxhVhTHA6FklTh3zK41j1JVz5TCrcH4TedPWd5D+iBO/Yz040+Kx1
KAbO14FNbTfnXjeEfW5QXbusVzObNCInwm7HArn6zwfWit39EWaD+E4AL4iZqkx5
ZKjARDqgDQCIfnDutzkkz1JcseIK+TZAcA4A+2S5YEBMbbOhsv9VfcUZGcO2dXbQ
C63Cwhb9aDhY8YDKJUMJt4t/9aWyNbmgKozLTtcr1y0ksbr5wueuqx4f8wY6zQ8x
VK/p6GDOTYHRPHmie5AONfyTdHrF9YGWu+bVHubkZBYGQs53lsQyk4sHTOU8C0fF
gjJbigRdw8EWQEUq1vjr
=nBNJ
-----END PGP SIGNATURE-----

--nextPart2575994.4rSjqjeBOc--
