Return-Path: <hrogge@googlemail.com>
From: Henning Rogge <hrogge@googlemail.com>
Date: Mon, 9 Nov 2009 16:22:21 +0100
References: <BD0FE81CE135624188025441BB9CB99138F599F20A@EXCMS01.ad.uow.edu.au>
In-Reply-To: <BD0FE81CE135624188025441BB9CB99138F599F20A@EXCMS01.ad.uow.edu.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2323443.150Y1Gac8z";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200911091622.26778.hrogge@googlemail.com>
Subject: Re: [B.A.T.M.A.N.] [Babel-users] A peer-reviewed assessment of OLSR,
	BATMAN and Babel
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: Chun-Ping Wang <jerryw@uow.edu.au>
Cc: "olsr-users@lists.olsr.org" <olsr-users@lists.olsr.org>, "b.a.t.m.a.n@lists.open-mesh.net" <b.a.t.m.a.n@lists.open-mesh.net>, Brett Hegelstein <brett.hagelstein@gmail.com>, "justin.lipman@gmail.com" <justin.lipman@gmail.com>, Juliusz Chroboczek <jch@pps.jussieu.fr>, "babel-users@lists.alioth.debian.org" <babel-users@lists.alioth.debian.org>, Brett Hagelstein <bretth@uow.edu.au>, Mehran Abolhasan <mehrana@uow.edu.au>

--nextPart2323443.150Y1Gac8z
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Montag 09 November 2009 14:00:24 schrieb Chun-Ping Wang:
> Hi all,
>=20
> Many thanks for all your feedbacks.  It will definately help us to improve
>  our work. However, I think there is quite a bit of confusions at very
>  beginning.  So I would like to make some clarifications for this paper.
>=20
> As it has been mentioned earlier, this paper was to study all the protoco=
ls
>  in their default setting.  In term of "default setting" for OLSR, we used
>  original config file shipped in olsr v0.5.5.  As far as I know, this
>  config file is based on the LQ mode of OLSR  (i.e. olsrd.conf.default.lq
>  ).  So, correct me if I am wrong, we have been using OLSR with ETX to
>  begin with. We only modified the HELLO and TC interval to improve static
>  node performance. The results shown in our paper is actually the
>  performance of OLSR with ETX.
Hmm... olsrd.conf.default.lq should be with ETX...

> You may also aware the protocols that we used are already out-dated.  This
>  is because this work was done back in 2008.  We are more than happy to
>  undergo another study with more recent protocols.
The implementation was outdated, not the protocol... but the protocol does=
=20
only mention hopcount, so most people just use "RFC compatible" OLSR.

I would be interested what config file you used for the test. If you plan t=
o=20
redo the test we (the olsr.org team) would be very interested in getting=20
feedback what kind of problems you have so that we can improve our software.

Henning Rogge

--nextPart2323443.150Y1Gac8z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEABECAAYFAkr4M7IACgkQcenvcwAcHWfwBQCeOporpgU8Dk7nepIKs1spFcEo
50kAnjIGHbL+Ad4w7bbcU2nJ/lAPGQ1q
=9ulT
-----END PGP SIGNATURE-----

--nextPart2323443.150Y1Gac8z--
