Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 19 Jun 2010 02:56:16 +0200
References: <1275852501-28523-1-git-send-email-sven.eckelmann@gmx.de>
	<1275852501-28523-3-git-send-email-sven.eckelmann@gmx.de>
	<20100618235835.GB1128@kroah.com>
In-Reply-To: <20100618235835.GB1128@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8481621.2AYVtr1kdW";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006190256.17487.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/9] Staging: batman-adv: Move device for
	icmp injection to debugfs
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
Cc: Greg KH <greg@kroah.com>, gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

--nextPart8481621.2AYVtr1kdW
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
> On Sun, Jun 06, 2010 at 09:28:14PM +0200, Sven Eckelmann wrote:
> > batctl uses /dev/batman-adv to send special batman-adv icmp packets to
> > other nodes in the mesh. To get it working with multiple batX devices we
> > must ensure that every mesh device can have their own socket which is
> > used to inject those packets in exactly one mesh.
> >=20
> > The current implementation still doesn't allow to use complete separated
> > meshes as we rely on structures which are not part of the private data
> > of a batman device.
> >=20
> > Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
>=20
> This patch doesn't apply, I get the following error:
> patching file drivers/staging/batman-adv/Makefile
> patching file drivers/staging/batman-adv/bat_debugfs.c
> patching file drivers/staging/batman-adv/bat_debugfs.h
> patching file drivers/staging/batman-adv/device.c
> Reversed (or previously applied) patch detected!  Assume -R? [n] ^C

Already explained in 01006190249.39204.sven.eckelmann@gmx.de, but just for =
the=20
record:

Missing patches
 * Staging: batman-adv: return -EFAULT on copy_to_user errors
 * Staging: batman-adv: fix function prototype
sent to you in 1275850985-27105-1-git-send-email-sven.eckelmann@gmx.de

Best regards,
	Sven

--nextPart8481621.2AYVtr1kdW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMHBWxAAoJEF2HCgfBJntGSJoQAK7fPjIUJ0aBuBw5r7eB7J/G
at/mbSUm+AvkOOo1w90oc2V5jFYRllUfSQ7MNBCF7Ttjp7h8zFpPLenoqjiV3oM7
I0pTzBgXzpl8A0Yj1aFgyQks6ljdiI5yc0bvzxSXCIwu8k1YjOYfNSF/6TWbtS/U
uBNWgN/WMAWtKc1savjJaessgxaMDfjgOs/IzGsPlOeKpmLNNg5UsnRGNcocbiev
29tiPEUBvFfIcVDkekpHxYWq0tk4InpWz2DQ3yHRxKhxMd17/aV5cl6x7Dr7gsNm
ib7HToh1VY+Rn7g1VG7h8P4M1KQZ4hFPxD6CvpK57X2tMkGEIA9rJZMv6DCfXpIJ
uP1XXn9BH1cCrX5cuM3BrJYwdgNA2wzsW0MNltuHq6iqRyEdL2Nj7wjNIoNOxPJ1
OQifD7FwP1+Bw2TD6nmPBpshcLDg3nihMm6gWbNdUMaPpVJ4sbamf7SDU52jBsfh
5vN7fuL4Gq3Gnw/HZol69zKcBIkytlB5/N+fyvlDEig0GNI3xUvh/a2NOGVHYIlH
dKM5PeXFzcgJlGkpyxSh5XL5XEso3MTSrT15kjiwrCMEQwQ+ZvRHUVhga8lEsv4A
Z34VIiPw56nvnSPEXyi/gPhSOUljxtxxTTwJ8HaEUuvwRbhxMkzTjYIz4TZQzPor
8xgy6CZAZHNa8QMD4K9a
=FsmR
-----END PGP SIGNATURE-----

--nextPart8481621.2AYVtr1kdW--
