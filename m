Return-Path: <antonio@meshcoding.com>
Message-ID: <52FD0475.1040705@meshcoding.com>
Date: Thu, 13 Feb 2014 18:44:21 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CANcKu40YtXgXGSiPnPo9biG=auHFqKNRA3G0WNy3E2MYWyqiNg@mail.gmail.com>
In-Reply-To: <CANcKu40YtXgXGSiPnPo9biG=auHFqKNRA3G0WNy3E2MYWyqiNg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MErBvAJc0HcUvq5AwBTV9OQ8DJocCHVOm"
Subject: Re: [B.A.T.M.A.N.] Problem compiling batman for openwrt
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, konstantin.pribluda@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MErBvAJc0HcUvq5AwBTV9OQ8DJocCHVOm
Content-Type: multipart/mixed;
 boundary="------------020506070509020904080000"

This is a multi-part message in MIME format.
--------------020506070509020904080000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 15:15, Konstantin Pribluda wrote:
> Hi all,
>=20
> I try to compile  2013.4 against trunk of openwrt,  and habe problem
> with batctl:


Hi Konstantin,

due to some CFLAGS problem (related to lto) batctl-2013.4.0 does not
compile unless you apply the attached patch (you can save and put it in
the patches folder within the batman-adv package).


The new batman-adv/batctl-2014.0.0 already includes this fix.



Cheers,


--=20
Antonio Quartulli

--------------020506070509020904080000
Content-Type: text/x-patch;
 name="1001-batctl-Add-CFLAGS-to-the-linker-step.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="1001-batctl-Add-CFLAGS-to-the-linker-step.patch"

=46rom 2c7bfe1299efa97438814bf6826a8f7ab3bc0b16 Mon Sep 17 00:00:00 2001
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 7 May 2013 14:51:02 +0200
Subject: [PATCH] batctl: Add CFLAGS to the linker step

The GCC manual states for different parameters that the options for compi=
lation
must also be used when linking. The options for compilation are stored in=

CFLAGS and added to LINK.o to fix the behavior.

Option which need this are for example -fPIC/-fPIE or -flto.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 311e70e..233f453 100755
--- a/Makefile
+++ b/Makefile
@@ -53,7 +53,7 @@ RM ?=3D rm -f
 INSTALL ?=3D install
 MKDIR ?=3D mkdir -p
 COMPILE.c =3D $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
-LINK.o =3D $(Q_LD)$(CC) $(LDFLAGS) $(TARGET_ARCH)
+LINK.o =3D $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
=20
 # standard install paths
 PREFIX =3D /usr/local
--=20
1.8.5.3


--------------020506070509020904080000--

--MErBvAJc0HcUvq5AwBTV9OQ8DJocCHVOm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/QR6AAoJEEKTMo6mOh1VF0gP/3Sp7qpVBf4O/q+0cA0XlT1l
0WrDBdgG+qk7tx+bKS2s2V5yZYUZxLZvXlc58xAuACiSAyhqaecInwoh/eD0eqbD
zFR5lomW8LRn0hAOsFcELHZrKbNhUHTeHlr53q9FdfbeNgrbeA6ZD+9+ichckJsq
agDM97K0t/IShSwTLUYQdNW1G9TRSY68nhhDQEdvY0HnCkm1unBKTKMqPF3p5IPq
XoRhREsqTNZLRHV3W8PbHn+O064J/bzi4Rzmn0RcYTOf0EsYjx4BqUUTZJKjA2bZ
vJDA1NT2Kfz+4bWswd4FXYpD8/oWMLnYLegPhzC2JR3GdZHN8d6pYiVHVn/hQs8D
qhGlxUICB5+gZyUIzXRHdEEsqlZBvbheur8HI3oFZimQ3VsLDGytO+YXqizWVZXW
gnWrrzx3UI99RZ/ZWY3gOuCfjixEkRT0YGv7r2PdX8QaAde/+WpKJCEgoB1VSc/N
koPJoIwrN+eq0O5v0PjfS2Zrwav4wsw3hAHT4XAUbc5U3+QRCViB5OYlxkKE+/+/
p8EDrHX5ghfOPw4mKlLx3NJyDpX172z/JuxFLKrJaE+c/RFUEjHRcsRgd/nEiPbn
SJU61Cm+x+qOKTlOME5nXtbQPDJJ6lEOkljcRkNxKZCY1ZsDaS1tCVxRpXs+WFuT
H1QGGKHU1pL+lx1rKplE
=wOaX
-----END PGP SIGNATURE-----

--MErBvAJc0HcUvq5AwBTV9OQ8DJocCHVOm--
