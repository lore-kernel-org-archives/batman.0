From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 27 May 2009 19:13:03 +0200
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<4313f3060905270921p31ea2a10m21d1b9bf61170132@mail.gmail.com>
	<4313f3060905270935ub7f69fct239833a3bcaf742c@mail.gmail.com>
In-Reply-To: <4313f3060905270935ub7f69fct239833a3bcaf742c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1523002.IuSlAnIH5M";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200905271913.09013.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Debug Malloc Problem
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
To: Nathan Wharton <naw@greptar.com>
Cc: b.a.t.m.a.n@open-mesh.net

--nextPart1523002.IuSlAnIH5M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 27 May 2009 18:35:42 Nathan Wharton wrote:
> On Wed, May 27, 2009 at 11:21 AM, Nathan Wharton <naw@greptar.com> wrote:
> > On Wed, May 27, 2009 at 11:16 AM, Sven Eckelmann <sven.eckelmann@gmx.de=
>=20
wrote:
> >> Thanks. This is completely unexpecting for a kernel with alignment tra=
p.
> >> The expected result is  "Value: 12389ab 89abcdef". Can you check the
> >> value of /proc/cpu/alignment ? I will look further at it this evening.
> >>
> >> Regards,
> >>        Sven
> >
> > User:  0
> > System:  0
> > Skipped: 0
> > Half:  0
> > Word:  0
> > DWord:  0
> > Multi:  0
> > User faults: 0 (ignored)
Thanks.

> I do get the correct result after echo 2 > /proc/cpu/alignment
Ok, so 100% sure that it is a alignment problem. The kernel fixup is always=
=20
activated and shouldn't create such problems as the page faults you mention=
ed=20
in your first post. Maybe some communication between kernelland and userlan=
d=20
has gone wrong. Can you test batmand with batgat and activated alignment=20
fixup?

Best regards,
	Sven

(Thanks for the link - it is a real nice overview).

--nextPart1523002.IuSlAnIH5M
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKHXSgAAoJEF2HCgfBJntGiMMP/0b4FEd48XqSmbPOdxXrAKzE
HhMa6t8wTXxjsIJchwYrXtXmif73wUda8UQ7MI+oPs/g3I3ZY9cB6gvkoPsdDCOu
qe7t1ZM78eWKt4MexsQ7eS2AJvFSlDTerPAdhlVzU0slKIsJ4vlMEpC6sFoiLOPJ
lTWAlWoNwLT9A3k53R0MZryFk+RhyNIawWikMYHwmNSQs/eDSYhM8YHONpX5g29X
lpBCAIcRESAwzxTzNt3Gi0jfJh2d/bTQZU3oLIb9S0+WWrdWkEUj7j8o+A2dS8B1
GIE0qhPOnIZyi4rzA+Gv/cxmpAggWnQiReSkk8lfZd6bVc+UGgVairPcNmQw6yZv
apQEDNk9ztpXQKUQNPE5dAnlOV8ccdrosKfqemTmvuOP8eId3+8RbXuVz/Htu/NI
lMqrV9kO4zm4+JIiuSodCetStwYELNYHlyKQstev3dRGQF5xBw84E3tuwjRFZYKG
7euRy98Gn7Yaq6QuGxLOZ0hTE8j29hpJAgDDW+NzHTz/ai271ZbztdutL4LMMB75
xsd7M3B0oR1dywesC22ZkmjfxO8bK5r4WEFDVtzaGxTFNJ0Y0zPf5fJUjW83m4K4
KTYS9ynQNsOf7YkddmP2bullbwzmieBceGMiytcG6hXHZIXMKow4d/U6RGTMdy7a
UtXOjPEo8P4vF/X+Bsbb
=G6KT
-----END PGP SIGNATURE-----

--nextPart1523002.IuSlAnIH5M--
