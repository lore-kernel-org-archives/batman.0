Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Tue, 27 Dec 2011 23:06:36 +0100
References: <201112252236.22377.clemens-john@gmx.de>
	<2075196.LxuFnsEOfE@sven-laptop.home.narfation.org>
In-Reply-To: <2075196.LxuFnsEOfE@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2206552.jv9VfqcLWg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201112272306.40661.clemens-john@gmx.de>
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2206552.jv9VfqcLWg
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sonntag, 25. Dezember 2011 23:29:42 you wrote:
> On Sunday 25 December 2011 22:36:18 Clemens John wrote:
> > Hi,
> >=20
> > I want to test the  Bridge loop avoidance II with our OpenWrt Freifunk
> > firmware. Is there a version that works and can be tested? Which git re=
po
> > do I have to use and what are the main steps to compile it into openwrt?
>=20
> Simon Wunderlich is the maintainer of the bridge loop avoidance II
> patchset. His current version can be found in his repo [1] in branch blaII
> (or another branch with blaII in the name). It is currently not rebased on
> top of master or v2011.4.0... so you cannot take the patchset and put it
> in OpenWRT.

Simon commited another patchset today so I took the latest snapshot of his=
=20
blaII_rebase branch [1] and put it on our own server [2]. I changed the nam=
e=20
of the folder inside the snapshot to 2011.4.0 and the md5sum and the url to=
=20
download the source in the OpenWrt Makefile [3]. For batctl I used the late=
st=20
2011.4.0 release and copied it to our server. But when I try to compile=20
OpenWrt, I get the following error: http://pastebin.com/PcNH15EC

Anything I can do?

[1] http://git.open-mesh.org/?p=3Dsimon/batman-
adv.git;a=3Dsnapshot;h=3Debdc92a614b3de8a32c66c92a46df286afe4bf6a;sf=3Dtgz
[2] http://dev.freifunk-ol.de/batman-adv-2011.4.0.tar.gz
[3] http://trac.freifunk-
ol.de/browser/firmware/Trunk/build_patches/bla2/Makefile

Sry for this questions but I=B4m absolutely not very familar with this thin=
gs so=20
I need your help to test it.

Regards
Clemens

--nextPart2206552.jv9VfqcLWg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk76QWwACgkQZgdHbA22lqMTFwCeMsRYW9YcNhBvetmWpqWCuqbU
jO0An29hL9Z2JRlFSF56JwolCAkgbyuM
=pZ1S
-----END PGP SIGNATURE-----

--nextPart2206552.jv9VfqcLWg--
