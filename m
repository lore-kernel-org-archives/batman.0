Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 3 Jun 2010 15:58:29 +0200
References: <1275509418.23599.42.camel@Joe-Laptop.home>
In-Reply-To: <1275509418.23599.42.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8129949.8OlROn3zHO";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006031558.36936.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Convert
	MAC_FMT to %pM
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
Cc: devel <devel@driverdev.osuosl.org>, b.a.t.m.a.n@lists.open-mesh.net, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Joe Perches <joe@perches.com>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart8129949.8OlROn3zHO
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Joe Perches wrote:
> Remove the last uses of MAC_FMT
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/staging/batman-adv/main.c              |    3 +-
>  drivers/staging/batman-adv/translation-table.c |   25
> ++++------------------- 2 files changed, 6 insertions(+), 22 deletions(-)

Just noticed that this patch collides with another one which is waiting in=
=20
GregKH's queue. I will try to rewrite it on top of that. I hope that this i=
s=20
ok for you.

Best regards,
	Sven

--nextPart8129949.8OlROn3zHO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMB7UGAAoJEF2HCgfBJntG5uEQAL4dRnjbahN6EinvUsOyp8so
elB7rxfPCt7z1gxUXKpuoYiSHTQYUurjsWJFuJViXkdOZ+0nnmkMNsplUPCB8t/z
mWv/soU9PiNijUgvMTEiK1+PTkIIS0xtGssGl323kkVDYt+3Ru3fgDPNVs+Tm6CC
+fFz2p1qp/Te6D/7CBsX66GDUI73Fd0sQWmD0+NSAP403mdgCulWS8nN/oiHVpdr
rwNHGvCQZlPXaGkIcCl9C9PIKeIBAtkhey04IMS+C1c6sI5Es9Usr1y0Pl+MA4to
EI93zRUcmhNyslknRddLhssa4PRAwmgNcprBvP1vbk3NYQdLe9VppUCrgigzujX4
JwK2y7crLXQc89G0KipFBPbWkHVyoInIL5J07nzikHjmnaeJEsX4V/6AgIwxwbMt
r6lDfC4aHXT6LeJQx7RVIUkRrPLAEwOvZsbjom6/5Sc4CAkaA0aAUKy0VXSsjXdO
c+1xkc5JVxYlzoKi+FdohnsQxg+/ZN/vwAYmd0J6gbhYTkszbze69K+iNXs5bYHn
6rZX4NFvnEAtLOUJXD00RDq6l31ZdwlAVmExAdZ8z43qiB41vRgpCnEwZnEoREU+
+ezUtYnB1FVx9+QVswHJ0oHNqityNCpq9b/aqdKncX38ilOUkRC0LvBfeteBttev
xMa54O8pfsfWsuYEohQu
=FALl
-----END PGP SIGNATURE-----

--nextPart8129949.8OlROn3zHO--
