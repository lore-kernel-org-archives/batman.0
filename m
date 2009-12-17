Return-Path: <sven.eckelmann@gmx.de>
Date: Thu, 17 Dec 2009 15:34:47 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20091217143447.GA13081@WGT634U>
References: <1261051915-13960-1-git-send-email-sven.eckelmann@gmx.de>
	<20091217122544.GM4648@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20091217122544.GM4648@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Use
	forw_bcast_list_lock	always in disabled interrupt context
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2009 at 01:25:44PM +0100, Andrew Lunn wrote:
> This reminds me of something i keep intending to do, but never get
> around to.
>=20
> It would be nice to have a LOCKING.TXT document, with the following
> Table of Contents.
>=20
> 1) What locks we have and what they protect.
>=20
> 2) What different contexts different parts of the code run in.
>
> These two sections provide the basis for the following sections.
>=20
> 3) Which locking primitives, ie spin_lock() or spin_lock_irqsave()
> should be used for each lock.
>=20
> 4) A list of what order locks should be taken in, when taking multiple
> locks, so as to avoid deadlocks.

Yes, would be nice to have something like that, but Simon will change some =
of
the stuff with the next (maybe not deadlocking) patch to remove the big
b.a.t.m.a.n. lock. And I heard that Simon also wanted to change the way the
packets get send... which probably changes context of each lock.

> When finding this bug, did you take any notes etc, which could
> contribute to such a document?

Sry, I have no notes. I was just sitting next to Marek while discussing wha=
t we
can do to provide a better working situation for you. This patch was just u=
sed
to test the changes to git-svn and the pre-commit hooks of svn. The patch w=
as
only produced using the help of much to less sleep and some developer tea.

The documentation about the context in which each lock/function is used isn=
't
really there for the kernel. As there are some upcoming changes we should w=
ait
until they are submitted. They should be generated while checking for new
deadlocks introduced by them.

Best regards,
	Sven

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBCgAGBQJLKkGBAAoJEF2HCgfBJntGzrUP/0k0hPdac9sxWRru1Du0jZxb
euzmSp5eD3qCXIYv6bwGbvXYEfIVtxOVACA8TQNjkRQaPi+kHe6DWKKobYRLcojg
GNKKV4eZFeRoP8ys1QjkRf3+aU0fvCgI2/6jjQpx8x6Wr5QaMTggIcjbb1fbNiYd
EyZ3zIU9IaxBKDYfDsMSuFFVvtHllgQuUhEA1RNXRJob4sQsuisD3obQF91w0dRd
VxdMMUOatVTVRqbH1zkDn3EXA9E83CBj/VVBpUZS0RqlBtQh4HRibbHAfC8DrZGX
XMBf3j71zb2O9moh1dpSQ1ytI9xxUrjrXbVIkNYgerUP2WThnwr7FbHzpHqIhgde
x27wRG+j3qU661vT3c8RtYw8dAf5XdJdL33j7JzR3OoM8MXUscQUBenXLtshoSFO
KYR95rRkLpRvc6n1GvmIhAsnJy2pliTU7YoTH9C+vIF+GfsBIuHrEJBmJqjiAvYa
6rGmwk93k/WdFH0Gn68BaBTQ1wbWrwfZcFERtlol0x3ory8PdiDAdO81bhTTH/Sd
Y3Nfr5cYNMv7tWhde93hYKIwg0Ifl7dqJQ7jyR3tihijbRQZQVgpqft3rr/fWJNH
48n/sEZN1g+H2/wEiu81DTJalhwuwh9FzCSKa0WK/P9IyUkhFj3H5TujSGuSYuto
HtAwNrBHt553/i81aTBr
=tJOo
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
