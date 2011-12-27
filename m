Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Tue, 27 Dec 2011 23:27:51 +0100
References: <201112252236.22377.clemens-john@gmx.de>
	<2075196.LxuFnsEOfE@sven-laptop.home.narfation.org>
	<201112272306.40661.clemens-john@gmx.de>
In-Reply-To: <201112272306.40661.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8283241.QAu7RraNrk";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201112272327.59110.clemens-john@gmx.de>
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

--nextPart8283241.QAu7RraNrk
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Dienstag, 27. Dezember 2011 23:06:36 Clemens John wrote:
> Simon commited another patchset today so I took the latest snapshot of his
> blaII_rebase branch [1] and put it on our own server [2]. I changed the
> name of the folder inside the snapshot to 2011.4.0 and the md5sum and the
> url to download the source in the OpenWrt Makefile [3]. For batctl I used
> the latest 2011.4.0 release and copied it to our server. But when I try to
> compile OpenWrt, I get the following error: http://pastebin.com/PcNH15EC

Ok I created a patch from this version now and put it into the patches fold=
er.=20
This worked. So forget about the last mail.

What=B4s about the make option to enable bla2? How does this need to be app=
lied=20
to the makefile in openwrt or is there no need to change anything because t=
he=20
option in in batman advanced own makefile is set to y?

Regards
Clemens

--nextPart8283241.QAu7RraNrk
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk76RmsACgkQZgdHbA22lqMm3ACgpsREDd8zbMZKso+uzxTqH31k
G2wAoO2aV6ipvqpgVtw4oj5b7ztVgvB+
=NE55
-----END PGP SIGNATURE-----

--nextPart8283241.QAu7RraNrk--
