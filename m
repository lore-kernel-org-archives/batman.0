Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 4 Apr 2010 12:46:33 +0200
References: <1270341625-28764-1-git-send-email-luisbg@ubuntu.com>
	<201004040312.28481.sven.eckelmann@gmx.de>
	<p2x506b70dc1004031845p81705070o325d93f839c80e9a@mail.gmail.com>
In-Reply-To: <p2x506b70dc1004031845p81705070o325d93f839c80e9a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14277164.y2p5Aiymgc";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004041246.38682.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] Staging: batman-adv: fix whitespace
	style issues
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
To: Luis de Bethencourt <luisbg@ubuntu.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart14277164.y2p5Aiymgc
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Sunday 04 April 2010 03:45:52 Luis de Bethencourt wrote:
> Sorry about the conflict, thanks for redoing the changes. Where can I
> find the current and development branches?

The development is currently done in different branches and SCMs outside th=
e=20
kernel. Andrew Lunn prepares a maint branch for submission to GregKH and se=
nds=20
it to him for staging.

Most of the development of future features are done in
 http://downloads.open-mesh.org/svn/batman/ under trunk/batman-adv-kernella=
nd/
This is usually not what you deal with as only the maint branch is submitte=
d=20
for inclusion into linux staging. Nevertheless all changes in svn for batma=
n-
adv-kernelland are automatically imported into
http://git.open-mesh.net/?p=3Dbatman-adv (branch master).

The maint work is now done inside the maint branch of that git repository. =
It=20
doesn't contain the whole linux tree and holds all files to build an extern=
al=20
module (used for example in OpenWRT and Debian). When Andrew thinks that it=
 is=20
ready to be send to GregKH, he will do a subtree merge into linus (holds th=
e=20
linux tree) and then rebase the changes in a private branch. This is needed=
 to=20
have the correct directories inside the patches and that files removed/adde=
d=20
for the kernel are still being deleted/available.

So doing your changes against the git maint branch is the correct way in mo=
st=20
situations.

> I want to avoid doing this
> mistake again in the future. Specially since I'm planning on doing
> some janitorial work on Staging for a while if it's OK with you guys.
> I see it as nice experience and practice while learning and getting
> ready for more valuable contributions :)

Yes, contributors are welcome.

There is also a userspace part which must also work with your changes. One=
=20
problem was spotted by Marek. So it is maybe a good idea to send changes ov=
er=20
the b.a.t.m.a.n. mailing list.

Best regards,
	Sven

--nextPart14277164.y2p5Aiymgc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLuG4LAAoJEF2HCgfBJntGeEEQANj5V29+KXfx1uAd6LQJfjrP
7UarTcnozVYpS1azcrpUBevc5VOPYS7aQBCoGQoUFgHI9E2JvvekNJKWFucd+YB6
tZ+0aW/+BYejBVUPcAfcDrVbHRludQtGfcxY5M4aGLWWQ23SM2yOvt7bn+i2SUIH
L/iwqgbu9oxw8/w/FVDZVbS16zZ6eUUJnTI/31/H8qykzOqvBQ9p3mQ2x6Mx3oN+
W1rlH678AJCyTjnf9nlQcbQh21EKXfpG3y/iMDj1F1WB/0VpBJ6+P4Kx0MstTrly
GdSak46D/bHx4vwj++tICpI67ZthtA3YSe7DhbK8Kv0UhhOMtCEOMTKhI2WqhI/+
IGqqvGnsz6GXBejNec29EpL/Xd4VTyXOS6pJdjGCXX6WqnyYuxp61wv3nQv9PsmF
BoKOnApn/r1DptMOdSy0MoQ3rjisVEqOWsBQIylFL7uMEg1fwpJN99+CFxKvg+uJ
nH4+WE8Ny2+yiLsV6wVbn24RQ/MBSrObZgQxHHwKZJyY7POVlBoKOzQrOXjTpu7k
PWeBqGbRlFpEO9cYu+NtQX6SBYjJHlQo31unQooRpE6eK6OkSJqvR1oggdpi1yt+
8y0PufLpmCovZpyxq9DQEN3l7zSlPpVFpylkw++AaQrOICqiUQ3Ea9GH6/BYQkCb
NBM013jL9U3ywdL/xevu
=4EV4
-----END PGP SIGNATURE-----

--nextPart14277164.y2p5Aiymgc--
