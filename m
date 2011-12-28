Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Wed, 28 Dec 2011 18:11:48 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1647966.Lj3AAhsZRW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201112281811.58622.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] HowTo Test Bla2
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1647966.Lj3AAhsZRW
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Mittwoch, 28. Dezember 2011 03:07:38 you wrote:
> Sry for the delay, but we were busy rebasing and fixing the blaII code.
> There are also some other meetings we are currently attending.

Thats no problem. We are very glad that you guys do this work and try to he=
lp=20
us.

> But to make it short: The code is automatically built (you correctly saw
> the CONFIG_BATMAN_ADV_BLA=3Dy), but you have to enable it through the new
> sysfs file "bridge_loop_avoidance" or the batctl option.

Sadly we are still some steps away from enabling it on the device. I search=
ed=20
for the sysfs file and while I did this I figured out, that the patch I cre=
ated=20
was not apllied because patches for batman-adv need to have the string=20
"batman" in their file name. So I renamed it and now it gets apllied but: n=
ow I=20
get the compile error again I descriped already in my previos email. Here i=
s=20
the pastebin link from the actual compile error: http://pastebin.com/iJy2u7=
=46f

Maybe you can take a look at it and find our mistake?

This is the patch we use:
http://trac.freifunk-ol.de/browser/firmware/Trunk/build_patches/bla2/0001-
batman-adv-bla2.patch

I made no other changes to the default files that are shipped with the late=
st=20
OpenWrt release.

Regards
Clemens

--nextPart1647966.Lj3AAhsZRW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk77Td4ACgkQZgdHbA22lqPnwQCeNjJl0Jls9SUnWovbcdvwCLRy
bPUAoOBRFK/SgxJ7ddeaUybvXIKSILHj
=sogb
-----END PGP SIGNATURE-----

--nextPart1647966.Lj3AAhsZRW--
