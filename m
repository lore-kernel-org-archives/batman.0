Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 21 Aug 2010 08:19:23 +0200
References: <4C6B80D2.9040906@web.de>
	<201008201644.58520.sven.eckelmann@gmx.de>
	<4C6F5950.8070204@bb.banban.jp>
In-Reply-To: <4C6F5950.8070204@bb.banban.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1835383.beOTkNnbui";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008210819.32546.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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
To: Kazuki Shimada <zukky@bb.banban.jp>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1835383.beOTkNnbui
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Saturday 21 August 2010 06:42:56 Kazuki Shimada wrote:
>   Hi, Sven Eckelmann.
>=20
> Sorry to be late to reply.
>=20
> > @Lemonde, it seems that you have the same problem. The patch will appear
> > on the ml later. But please also add the other patches I'd suggested.
>=20
> Thank you for your reply and patches.
> I applied the patches. (It seems batman-adv-devel is a little defferent
> from batman-adv, so I made patches to fit to batman-adv-devel on
> buildroot. hope I didn't mistake :- )
> The result is the same before. But this report has already obsolete.
> I'll try your next patches.

Actually these patches are for devel aka the trunk. The patches I send to T=
im=20
were for v2010.0.0. Please check if you really use the latest version of=20
batman-adv from trunk (see mareks reply to your message).

The trunk (r1776) has nearly all patches I've send around in the last week =
(at=20
least it should not have the problems you've experienced). Please try that=
=20
revision and please report back.

thanks,
	Sven

--nextPart1835383.beOTkNnbui
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMb2/sAAoJEF2HCgfBJntGnmYP/2QYiOzgpCyESINpsYot8Ozj
VQch+PAbnf/hcNYdzdYSKUYCoWMnSdudAueVRkpQu64rw69XD8O0ehCi+9e92XuY
xoXTqbRjtAjSaKFMoS2BJQqvp6AuPcepGEdtXeVfmDRbgHhDkcEhNs/O7Ki9A2g2
gmTztqyNlqvJVp+2zKicyEklFrRCEPZkw8ykTzwjP0IJWVF7TiK2RPB+Ko82uyYr
yMLrOCwki/2ZuETwhCAV5zxAL+Gqj4Fme65D4jf8xR3H09FnivfNYEkAKx3YwAFp
NGws+1ZzfeCaMqXAdfvBwp0Jz3xaxixXzM9HS70VpQT7glSMO1gFJIURlmrHHK1x
PBiz/o670AL+O3FqPpCzNNLk1ABeDbp/uv+sletDUDaJPfBv0Mlj8Fp6BwGnyPjt
m8dt6EM89pIlqCSWdveEvIxycq/jBmJ4rQpLCzO0u/up49oNHgHNC1gvW6hEmhBR
A8D4SMzbpee75fDUqeHLIQ1HHh/UjuMNpO6ON5FgEWqh0CRzqwopoCjgfxXKk2H4
2xWkC25jYXJ8nTiFqRww07iRsXEKZmno2Myzz5KtLznad5jZbPv6NaQVYa/Ky/t+
Oe8DeAHXGgFc6f9w6SqIBlPk4+tntQ/yJvvzqChqdtiDHIz0lPbhmaG8mW69Fov/
8mAwEjehy3rEdG1kNqib
=TQYh
-----END PGP SIGNATURE-----

--nextPart1835383.beOTkNnbui--
