Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 16 Oct 2010 04:11:06 +0200
References: <1286922125-18097-1-git-send-email-linus.luessing@web.de>
	<1286922125-18097-4-git-send-email-linus.luessing@web.de>
In-Reply-To: <1286922125-18097-4-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1404379.22pUyvBfaQ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201010160411.08260.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Introduce generic
	BAT_ATTR_* macros
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

--nextPart1404379.22pUyvBfaQ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Linus L=FCssing wrote:
> This makes exposing bat_priv's atomic_ts storing boolean or uint values
> possible with only two additional lines of code in the future. It also
> further reduces the amount of duplicate code in bat_sysfs.c.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---

Please fix the checkpatch problems first:

WARNING: please, no space before tabs
#47: FILE: batman-adv/bat_sysfs.c:55:
+ssize_t show_##_name(struct kobject *kobj, struct attribute *attr, ^I\$

WARNING: storage class should be at the beginning of the declaration
#101: FILE: batman-adv/bat_sysfs.c:139:
+inline static ssize_t __store_bool_attr(char *buff, size_t count,

ERROR: inline keyword should sit between storage class and type
#101: FILE: batman-adv/bat_sysfs.c:139:
+inline static ssize_t __store_bool_attr(char *buff, size_t count,

WARNING: storage class should be at the beginning of the declaration
#126: FILE: batman-adv/bat_sysfs.c:191:
+inline static ssize_t __store_uint_attr(char *buff, size_t count,

ERROR: inline keyword should sit between storage class and type
#126: FILE: batman-adv/bat_sysfs.c:191:
+inline static ssize_t __store_uint_attr(char *buff, size_t count,

total: 2 errors, 3 warnings, 0 checks, 241 lines checked

0003-batman-adv-Introduce-generic-BAT_ATTR_-macros.patch has style problems=
, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

--nextPart1404379.22pUyvBfaQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMuQm7AAoJEF2HCgfBJntGSxgQALxeFzN5XhWEHU22X7s/A1dE
YzsN6ewjDoamtaAbWVwBH4+v/kCBFa909tnoQcQLpCbkRSxtGLkZ1qQYzMQo82g+
oFp84L0Es1N4aDJZYUeqexu4ttKZt4JuVA4dKwwhKRfbybxwMeUd2+R55UKCotgm
SrKM8vblQu5kiCz0dpVSRRheysn1RbRo4Kl7D+b0/kMKbjFZUhM//7YG+FBN56dt
zuS3ss7RHr4A/duSPJGGrDA6dKrusNkpKdbefzgSmG4Fk3aBZLEGHhidYzRPyFZd
NbMpA4AzVK37tNN4goHhwdMAMWDANz4vNkGupbWlj+GObnIWYCscquoFB9H2O9hO
erx+0phfS69FkpvvLI2QxgvoAE0pfyyyPlh3sUmWLWLhiJVhnBquvlQQjuUD37Rp
Lg0gMRp7RhSn0RRvC1il4gO/DVSQVAUAjbRYvkt/QhdQ/ONpsJXuBGjc/OZKpAdk
q0Nz8KuAr31VKLTJ9z9vGYbeyVZYGHSAf89EwSIqPOFKUxEgh7MMT6blOpxVBvaY
AbcHIyFDoXLd8vmRSpJiBlvdE3fzzpgS96t15hYryH0cY1PEa/R51M01XgY1j8Fi
IS4rKh2Bhwwk35jMdyemPnO2/N/hrSEYtJpwprTUMMBo+pSak+diaJjq+aoUbcSJ
RfW81g+juHby8mOcLKoa
=GKci
-----END PGP SIGNATURE-----

--nextPart1404379.22pUyvBfaQ--
