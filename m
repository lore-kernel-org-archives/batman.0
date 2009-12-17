Return-Path: <sven.eckelmann@gmx.de>
Date: Thu, 17 Dec 2009 15:47:14 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20091217144714.GB13081@WGT634U>
References: <1261051915-13960-1-git-send-email-sven.eckelmann@gmx.de>
	<20091217122544.GM4648@lunn.ch> <20091217143447.GA13081@WGT634U>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <20091217143447.GA13081@WGT634U>
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


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2009 at 03:34:47PM +0100, Sven Eckelmann wrote:
[...]
> > When finding this bug, did you take any notes etc, which could
> > contribute to such a document?
>=20
[...]
>=20
> The documentation about the context in which each lock/function is used i=
sn't
> really there for the kernel. As there are some upcoming changes we should=
 wait
> until they are submitted. They should be generated while checking for new
> deadlocks introduced by them.

Sorry, wanted to say that there is no real documentation inside the kernel =
in
which situation/context a specific hook/function is called or can be called.
Some parts like the vm has such a document, but this is more an exception a=
nd
not common in many other subsystems.

Best regards,
	Sven

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBCgAGBQJLKkRsAAoJEF2HCgfBJntG170P/i/2T1BNS7YQyGrDGAMepnTx
MUMcIAaLm1PWq5IKfTGpMYLC3mZk5yKJjHROI+pz66JqRbU76ZGUeugsan8nTszo
NV7BX1dO0pUkx8ofX4piaBAsbHikbFV1Mm7r3TWj/v+blxdhNo0u7x7DUtLyH/IB
PkVdPDbqbuJt0oLLfl2zrgAKyrzPvk34qDqD0mvGu4PeBj2J9gbkQz2oKFHBO7KO
38cziEzpsRMkwHz2QYfDqHGKaVHn04RvYqijt0RreLKGxOMXugkB5x+VP8eGKfwz
6VQ92zxl4pnik4mkv5yBpTZLr9bVxZFQjVzNL7oUaeJrc8C/ZyFVmTahxQWIFwo4
NaYOy75F78Rqaz44gjuonTScID8CtBRgdoCiTdZbnGa4W08sz3M2gSUUe74GYgr2
zoAY6mJ9CmJq+PTPkMRHV+kfQKK7MIC7rRC/gepEDAIoHoFTf6xoZIEuJxqGjo1w
PYagxF4IhxOtpYnqeAz8VSRqJcxw/qrTBJ5wmFZBHaFx3AXdUUG0EUTTBDQUZRfX
/arncd8vl5RfIMsGf3i2a0gOVAytAOn/tZMfRC7MdK46K1QHDlH5crIjXEU2aF1H
PRmfh7WdbK+fVAe+yNK3yYsXFdOy9gwgkxwsg70bx4bViPYZxLqIkv1nL6gJlYx9
wWJlZs6D/tVhd3BU+Om5
=uTuG
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
