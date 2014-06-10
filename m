Return-Path: <antonio@meshcoding.com>
Message-ID: <53969F3D.5040306@meshcoding.com>
Date: Tue, 10 Jun 2014 08:01:33 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <53957653.5000406@meshcoding.com>
 <1402334059-28681-1-git-send-email-gaul@web-yard.de>
 <53962199.4060202@meshcoding.com> <539628F6.9070706@web-yard.de>
In-Reply-To: <539628F6.9070706@web-yard.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xjX5OCrMGjgwxFwsbaJmAhUlxESMrNVRA"
Subject: Re: [B.A.T.M.A.N.] [PATCH] remove unnecessary logspam
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
To: =?UTF-8?B?QW5kcsOpIEdhdWw=?= <gaul@web-yard.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xjX5OCrMGjgwxFwsbaJmAhUlxESMrNVRA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On 09/06/14 23:36, Andr=C3=A9 Gaul wrote:
> Hey Antonio,
>=20
> thx for your quick reply!
>=20
> Am 09.06.2014 23:05, schrieb Antonio Quartulli:
>> I'd suggest you to check this patch with checkpatch.pl --strict. Here =
I
>> get many errors due to non-printable chars at the end of various lines=
=2E
>=20

This is my output (this is checkpatch from net-next) - you can ignore
the warnings about "Macros with complex values should be enclosed in
parenthesis":

$ ./exp/linux-merge/scripts/checkpatch.pl --strict \[B.A.T.M.A.N.\]\
\[PATCH\]\ remove\ unnecessary\ logspam.eml
ERROR: DOS line endings
#111: FILE: main.h:242:
+/* possibly ratelimited debug output */^M$

ERROR: DOS line endings
#112: FILE: main.h:243:
+#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)^I\^M$

WARNING: Whitespace after \ makes next lines useless
#112: FILE: main.h:243:
+#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)	\

ERROR: Macros with complex values should be enclosed in parenthesis
#112: FILE: main.h:243:
+#define _batadv_dbg(type, bat_priv, ratelimited, fmt, arg...)	\

ERROR: DOS line endings
#115: FILE: main.h:245:
+^I^Iif (atomic_read(&bat_priv->log_level) & type && \^M$

ERROR: DOS line endings
#116: FILE: main.h:246:
+^I^I    (!ratelimited || net_ratelimit()))^I^I\^M$

ERROR: DOS line endings
#125: FILE: main.h:251:
+__printf(4, 5)^M$

ERROR: DOS line endings
#126: FILE: main.h:252:
+static inline void _batadv_dbg(int type __always_unused,^M$

ERROR: DOS line endings
#127: FILE: main.h:253:
+^I^I^I       struct batadv_priv *bat_priv __always_unused,^M$

ERROR: DOS line endings
#128: FILE: main.h:254:
+^I^I^I       int ratelimited __always_unused,^M$

ERROR: DOS line endings
#129: FILE: main.h:255:
+^I^I^I       const char *fmt __always_unused, ...)^M$

ERROR: DOS line endings
#134: FILE: main.h:260:
+#define batadv_dbg(type, bat_priv, arg...) \^M$

WARNING: Whitespace after \ makes next lines useless
#134: FILE: main.h:260:
+#define batadv_dbg(type, bat_priv, arg...) \

ERROR: Macros with complex values should be enclosed in parenthesis
#134: FILE: main.h:260:
+#define batadv_dbg(type, bat_priv, arg...) \

ERROR: DOS line endings
#135: FILE: main.h:261:
+^I_batadv_dbg(type, bat_priv, 0, ## arg)^M$

ERROR: DOS line endings
#136: FILE: main.h:262:
+#define batadv_dbg_ratelimited(type, bat_priv, arg...) \^M$

WARNING: Whitespace after \ makes next lines useless
#136: FILE: main.h:262:
+#define batadv_dbg_ratelimited(type, bat_priv, arg...) \

ERROR: Macros with complex values should be enclosed in parenthesis
#136: FILE: main.h:262:
+#define batadv_dbg_ratelimited(type, bat_priv, arg...) \

ERROR: DOS line endings
#137: FILE: main.h:263:
+^I_batadv_dbg(type, bat_priv, 1, ## arg)^M$

ERROR: DOS line endings
#138: FILE: main.h:264:
+^M$

ERROR: DOS line endings
#155: FILE: routing.c:709:
+^I^I^Ibatadv_dbg_ratelimited(BATADV_DBG_TT,^M$

ERROR: DOS line endings
#156: FILE: routing.c:710:
+^I^I^I^I^I       bat_priv,^M$

ERROR: DOS line endings
#157: FILE: routing.c:711:
+^I^I^I^I^I       "Rerouting unicast packet to %pM (dst=3D%pM): Local
Roaming\n",^M$

ERROR: DOS line endings
#158: FILE: routing.c:712:
+^I^I^I^I^I       unicast_packet->dest,^M$

ERROR: DOS line endings
#159: FILE: routing.c:713:
+^I^I^I^I^I       ethhdr->h_dest);^M$

ERROR: DOS line endings
#171: FILE: routing.c:755:
+^I^Ibatadv_dbg_ratelimited(BATADV_DBG_TT, bat_priv,^M$

ERROR: DOS line endings
#172: FILE: routing.c:756:
+^I^I^I^I       "Rerouting unicast packet to %pM (dst=3D%pM): TTVN
mismatch old_ttvn=3D%u new_ttvn=3D%u\n",^M$

ERROR: DOS line endings
#173: FILE: routing.c:757:
+^I^I^I^I       unicast_packet->dest, ethhdr->h_dest,^M$

ERROR: DOS line endings
#174: FILE: routing.c:758:
+^I^I^I^I       old_ttvn, curr_ttvn);^M$

total: 26 errors, 3 warnings, 0 checks, 65 lines checked

[B.A.T.M.A.N.] [PATCH] remove unnecessary logspam.eml has style
problems, please review.

If any of these errors are false positives, please report
them to the maintainer, see CHECKPATCH in MAINTAINERS.


maybe it's the mail client that messes the patch up? Are you using
git-send-email ?


Cheers,

--=20
Antonio Quartulli


--xjX5OCrMGjgwxFwsbaJmAhUlxESMrNVRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTlp9CAAoJEJgn97Bh2u9ebt4P/1TJ8QjO95Qs4DbWenZqb0r5
pAZrNriw4w0OTQL9qAiG1OLDbZPWYonJ8ZA/h+IEF7yHTFjnb/WAldIe2JSXrPdr
kYPveifir60b16j7qSv5S/ATrUh5UOzk6aVoFsMykBx4PsSuh7FAdG/3umDPlrHP
2c1O71PmTf4ABsQA54AKn1vVzvU6yTvtvnXrGKwa9FqFV284yrYuevif6va+C2bD
U5rg/khcjBHwaxD4mJvbLrCzZqSJ12rZMsKRf+cnjFgoQgD7c9TIj3ImeodvByVc
rCUOD0TmTcblibKvb/wME8DemI1XGcMfNHl6q2Df92qv97G/TOwwClt5ArAdYbJ3
0aoHwc+v3GRDXgh2pfbmwulQa8ycH8fYKWUBNj0r4fbe59aJdBtv/GUDbZ5014v8
Q/tlkcPflm6r/D9lPeWEZcnmKLR/jhULDCdmGSjm7YIUUMlEmqu+dt/U8kljJQ97
bqJu4C6JBVc+dQMT2i/MK/IVwfIOVAq8dxcI02P9z7Yi7hftm1d4LUonUfv7pKq0
qnfCd3BU0M6zcb8DODqnOwR018tzL2NvTu1bhG49Pv2ML9euH+X0jAsMGrpITHMU
4VGKa7oncDC8/jezr09IPX80R3PXqeVrkXnQhrPyspifNBun9mq1X6VI6/8VFGmX
RM6zqfjnc1m5eCsoUPcW
=R5So
-----END PGP SIGNATURE-----

--xjX5OCrMGjgwxFwsbaJmAhUlxESMrNVRA--
