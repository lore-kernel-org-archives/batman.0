Return-Path: <ordex@autistici.org>
Date: Mon, 14 Jan 2013 14:33:26 +1000
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130114043326.GE2890@ritirata.org>
References: <1358130088-22650-1-git-send-email-ordex@autistici.org>
 <201301141140.17187.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <201301141140.17187.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't use !! in bool
 conversion
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2013 at 11:40:17AM +0800, Marek Lindner wrote:
> On Monday, January 14, 2013 10:21:28 Antonio Quartulli wrote:
> > when converting an integer value to bool, whatever the length of the va=
lue
> > is, "!!" because of the standard Bool conversion definition
>=20
> first of all, there is a verb missing somewhere. This sentence does not=
=20
> compile.

whoops, true. Changed the sentence too many times.

> Secondly, it fails to explain *why* you are making that change.
>=20

well, the "why" is implicit in the missing verb :D
"!! is useless". I'll send v2.

Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ84qWAAoJEADl0hg6qKeOHlMQAJ2A5XPzcB1pd71PcsiUpiVj
KlIkvVy+B3TJvseqATE/v8HaZL6CHal6WrIuzHFrQvklHpbA5999bBQfvPXuXMkr
yLptuMdiw+coeIIrQWsQHJBknuk+aepLQVN8Nx8T0eBvqhGG4ZafAomkFO6jnVO4
a7IopXXFPyIN8iW5GQy9bg7/tUsJmskFjum74+V78crcIdkrkb7sdZXWJnT37kiE
iixThF1YceywnEH2lp65DugedAUMIwj7OP4TgcHkeVjyOUMcXqBn7bjzYA9DE69P
ETGSBM9wEKjs6bbwDOvKZI3+/5rA5AFFOlfwHs+yLrzmDzO/6sIZPgbSUapn9ffw
ELzROpayo37ZMgveOzkjrFdL6UHgIicuJ9qbNvxk9QBpeThJn5tVQL0xT0TZ1Ydd
52pU9OTCu3v1uBnbSZjbXaPs0p4UVtc2yw9/xiHSuR8O+NuBXjKaoaclbAfqRuZX
MKIgm+OL6Y8PHbvUgft6YB3uCD+1oUYHPmpXB+5hcFe5/Nvry6UVEug72nJtlSXt
0Nms3bFIAobE4WViHyEQgqu2xzs1E51zKS/VQUIQuo8qUEGUmHcvdzwYuyiQ2Iqk
K3B1Ccwd51lYyrUsANnhIMsemlYq7Cx0b9TpHcZ4PO3CwirFV/pTiU1s7TBcnK0s
86jHzgKRWeKpWFh1Wu4m
=xjHM
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
