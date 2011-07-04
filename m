Return-Path: <sven@narfation.org>
Date: Mon, 4 Jul 2011 20:29:14 +0200
From: Sven Eckelmann <sven@narfation.org>
Message-ID: <20110704182914.GA4362@sven-atom.home.narfation.org>
References: <CAJA-1Lijvt9hZVTP0QXi81bk061A54tRs=quUyztzo2_cM-LNw@mail.gmail.com>
	<201107041455.33023.lindner_marek@yahoo.de>
	<CAJA-1Ljmeqym_Sj4zqSEqaJtVvGf3brFQPtghYYi2QT5PFLYHw@mail.gmail.com>
	<20110704182256.GB26734@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20110704182256.GB26734@autistici.org>
Subject: Re: [B.A.T.M.A.N.] Disconnecting the nodes in batman-adv 2011.1.0
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


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> As Marek suggested, you should use something like ebtables. But honestly I
> remember that ebtables support has been removed from batman some time
> ago.

What about using a bridge over the actual device to simulate the bad link
together with ebtables? This would resolve the problem that batman-adv must be
ebtables aware.

Kind regards,
	Sven

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJOEgZ6AAoJEF2HCgfBJntGZJMP/2UmxHAOOWZNk74jZBeVk5ov
gMxabazlwcmVWYIX/sUZDuuLY31JVsJTeprKSL6/jkd7gpdAUxB2T0zV0pqa0Hrs
5Du1okvQxXpLCha+yj4SNyi7/hFWNGR4/r3nTUqu57/5wkSoTzclqBMVdmubgGv0
TdsRpnWquT4Bunqkqxo2lCiv5k8JBrrh0rfqBaYuSaVTV/6n+9QTycOiiSOo84/u
6gn4k3zPzVa87vZlQ0hS5vsrjDFkpc/CvSRALe8OXQ7B0npVoJmAWCMQPf6Kschq
yVDSFMMJXjmgApw98u0ii1A/dKLXJV1AskJ4WGRq6kL3Zk6QaEnbtDhyc4Enw8G4
V2SbKvaYH97u5XwCMTiTcKQNqUSd6yewDm6fwYpyGGbGm9Uow2Zayk/vWhUG1BCJ
ta0XdWcVisgmsM/xisiI0AVCVPu/Mmc7O11aqdBTtGKgI+X+SWMBbWYmTpssqZJB
MfG69z2XQCWGbBfpzm8W9YnU9XqJ728ZGBDhZDRAxgD4ZLMpL2iAVuvdNQUyuylR
LTbzjV2RZ336Yj96vpvz21XWIUHBsKO4asqEB8/pgIiN07oq0nw3zbX10OxRcOU/
1qIO2F7rPpxifv988hgl6mtQAbRLiCX+pRykLbTtDamOumVKCGl3ofMpt/3ksdgF
OLSS0t2YW7KV8b7Uil5H
=ooJp
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
