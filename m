Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 16 Aug 2011 14:48:40 +0200
Message-ID: <2815438.5orOLmS2sI@sven-laptop.home.narfation.org>
In-Reply-To: <CAFevQmOvF2OnFc+aTMHZ3GDNh5Mt=Bh_RMxjhALQMy3f4kZxzA@mail.gmail.com>
References: <CAFevQmOvF2OnFc+aTMHZ3GDNh5Mt=Bh_RMxjhALQMy3f4kZxzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6576311.607HRA9heJ";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] AP - STA
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


--nextPart6576311.607HRA9heJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Tuesday 16 August 2011 14:31:59 Filippo Sallemi wrote:
> Hi,
> It's possible to use batman-adv in ap sta mode?

batman-adv doesn't know anything about stuff below the ethnernet interface. So 
you could also use it over layer 2 ethernet tunnels, wifi ap-sta, wifi adhoc, 
ethernet or even write a virtual interface which prints everything on paper 
and scans the paper on the remote machine (but you should be fast or increase 
the ogm interval).

Kind regards,
	Sven
--nextPart6576311.607HRA9heJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOSmcoAAoJEF2HCgfBJntGNOsQAKrIYK3GRiH2BEcCieI8w3ta
bGskSbSz/2Ojo+EZGKNodJ3q+Lz9as1CFptL6+tC5ZE9JO4p49yN9ktWFg26OVub
9szCN4ArR1j7lMSLbVZdtLrtCGdWbwNWthSgo3bFxBKR+djabK/3T5pPvItTVsjc
UB1Q1apqwe2gidydawViyengdPYJ/DiCgmY+A9MkK+sBqwyVqhG8J2nQOFTCfjOK
YWhkFLe8UwFiF75UY0+edqvPf+mR2Mq4pNKOrAafw/rLsiv7tA+jeeLXggZr/p1L
gSrFdYM/oFu5dAtS3+c4dVlEl5LqqvQvfeQp0l40FYNYpE5iu8QABXXXTlltPmm5
y4CWaS5uq3d9Jq9/6uyKI6lQq7N4hSsaHBSqT8N8bhQ20I3v6oE49FCGb4MZMrsG
nGqc9KBtBVGvxSYDd9yG92OBLbTUsb/KnUZq/rCDmWRqAm9GY4BvSjfwSoAkC0I7
4nCG96wzkMrPZx0n8sUPATcPG2HRrFQ9CK9Gdq6lDdWnVihL/Q1ZWYci9OgOIYNl
yOpQVSQG4aD5F/+HXBdrdvKNk/4Fdqs18dbqz8w/RRKw5DodNfbNPXRujCDLJ2nq
QGC0PkHpPYsXlEQSsznaB/UffjgHxpzY096vU28k9VSda0mBGTxUaQDvGQAGXGVR
pvdqiRSOJE5G4aLPWO71
=g9ek
-----END PGP SIGNATURE-----

--nextPart6576311.607HRA9heJ--

