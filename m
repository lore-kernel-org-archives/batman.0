Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 19 Oct 2011 21:16:21 +0200
Message-ID: <2858789.LPPrD7sNx2@sven-desktop.home.narfation.org>
In-Reply-To: <4E9E9547.8090801@gmail.com>
References: <201110190044.38983.lindner_marek@yahoo.de>
	<1378702.GiY0aRojPS@sven-desktop.home.narfation.org>
	<4E9E9547.8090801@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2162539.9WMcOAx6Xj";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.3.1 released
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
To: Michael =?ISO-8859-1?Q?St=F6cker?= <michael.stoecker@googlemail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2162539.9WMcOAx6Xj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

Please always try to send your mails to the mailing list. Otherwise the=
 person=20
with the right knowledge may not be able to participate.

On Wednesday 19 October 2011 11:15:51 Michael St=F6cker wrote:
[...]
> its not "my" makefile, its the default openwrt-batman-adv-makefile...=

> then i have to wait till somebody who is better involved in
> makefile-stuff makes a patch/new makefile ;)

I just forward Mareks answer to the question:=20
https://dev.openwrt.org/changeset/28490

> i just think that the current tarballnaming is inconsistent, i
> personally expect in a folder named /releases/batman-adv-2011.3.1/
> tarballs of version 2011.3.1 ;)

There is no 2011.3.1 version of batctl. We decided a long time ago that=
 we=20
want to mark compatible versions in the release folders and keep batctl=
 and=20
batman-adv separate. That means that we don't want to force 0-change re=
leases=20
of one tool. My initial idea was also to name the release folders only =
2011.3=20
and only link the current stable releases into those folders. I don't k=
now=20
whether there were other opinions or we forgot to talk more about it.

The reason why I asked about the x.org folks is the similarity between =
the=20
strategies they use and the one we now try to follow (actually, I looke=
d at=20
their release style and kept it in some other open source projects). Wh=
at is=20
your opinion regarding the 2011.3 name for the release folder and would=
 it=20
help in understanding that batctl and batman-adv are separate parts whi=
ch only=20
get common releases from time to time?

Kind regards,
=09Sven
--nextPart2162539.9WMcOAx6Xj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOnyIFAAoJEF2HCgfBJntG9gYQAL/xvJpwntUvaDkXCyCz6fdY
ChvBjBC51Ul2R3M180LJP89dzNeenrLW7/XBAB+WZpszRrWHxFDSkt1oFxMOupEL
9GFOfSBrRHDwyOWFZu/O2LjcNRo+whU/S9gl21bHcxmvEhAFojrvSOYMrMxNPEgq
8jEPes76tsWrEUv1+Zq2XKIFvLq8Xz/nUc6p57OFeK9KrOw/eU757w4w2wHEXAyF
Fthf31l8Mo2PEOrfUj1JGgeycoGTm88FNGsWJefVn6TeCiJMln/2egs53X0ngsD1
VEhxL5Zh013sd/Tyw5GZZx6aFVVWo3VEGX0oWytth2QbZzU/tQ2GwGfEfQ/0wXgt
ScQMejDssOLJpo3xlI26fblvUegonAMT9GNhMUUOXAxnfIcqs0dR3pfXTahKI4Pl
307AyUF694WDupORfl750dBcxTcDzzfPHGsi6cXdX+73n0H8Buk6gQB6hFEp+aWu
sXVBq+HNh1RksobsT+YmrdcVNb7khjPn0ZXkvec7Nof63b7e5Rbj6ydd00Ifs2X3
tsIw5DjmZecT0FLN3uS7jlRyuCfVNeUCgbLimtQnEjpWtUHONqZriufUYz8u8P+T
DitHzIxmMn/NrGITvlBhtwVuprxsfsZrzd9JqSgVrD3BbPJbOS6yLTdl2SvlPg26
0x2PpQSAPnMuRVvVjJjw
=cuBa
-----END PGP SIGNATURE-----

--nextPart2162539.9WMcOAx6Xj--

