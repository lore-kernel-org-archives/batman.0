Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2011 09:27:57 +0200
References: <1305407694-16789-1-git-send-email-sven@narfation.org>
	<20110515063624.GK4071@lunn.ch>
In-Reply-To: <20110515063624.GK4071@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4717124.oprHjl44XJ";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201105150927.59225.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Annotate functions with
	format strings
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

--nextPart4717124.oprHjl44XJ
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> Nice set of patches.
>=20
> Are you using any tools to find these issues? I don't think sparse
> points these out.

I read the linux kernel mailinglist and found a mail where batman-ad was=20
mentioned [1] - nothing to be proud of. So I started to look around and fou=
nd=20
something here and there... at the end I had bleeding eyes and 9 patches (y=
es,=20
there are ten because I did a break and noticed too late that I wanted to a=
dd=20
the sparse/lockdep annotation for the RCU update-side since a while).

Kind regards,
	Sven

[1] http://thread.gmane.org/gmane.linux.kernel/1139857

--nextPart4717124.oprHjl44XJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJNz4B+AAoJEF2HCgfBJntGe1sP/0RuQg3tNMlGDvZZUi4T0zbr
NpW9B/HFrvD/j0uhrtD3kYmxuK0fHcBK2cX+YhbcI5gJaydAqztAtF3ZjFxLYr6X
0oJlCpJ7Ime3rV/vs0EYuSsnLhAfE1++G1aufWmCO6nWq+QJmS6kjdILLX88UwEV
y/Tl7Wa7Fw2ES59NYpOTCH+9IufR+3YeuPR7gsxae3El5gW2qsb+IfY6FCUaJJMu
tIfLkKyrzRM3tfZuXb9z8gqo/0qbkN6IIyVfGG9YVXa0kwz11gxSsEji0DK6IQ0N
4FVORXwhbrO9rtMGIDd4+TqnNvPVL/iY7VRVmjjg0aInQn1nruhxD/tINrN7PhCe
qM7KvcbW4pPFeawAvz6gIwzm+7FsCT0AQU+7CgUKvcvQ1zACnWEELC1+SGns0VvM
vQ32lL1SzTKksnBAYLMN45typEAHjpgnBwI2bvoRERihCucCbKfbrYd6zaL8az+t
vCP2/3wvqSiQ7hKb0xOYQeg+bomgUe26D9DFmYfRAdOSdhsgGV/vHVr/u50KgMYB
r7NmeOFNnMuoV1Y2Yjp1kRZBRiSSsyQXcKAYcxKpywqgt91wKpsc4PDkMg4FLjCf
+65KsawAR227tVtHnhxbzHSwVl3hIi0WgL+aIqLreX4th1MwRj8KwadPxIx6goVu
WJsXS2oBjfhojP3T/jzK
=cOLv
-----END PGP SIGNATURE-----

--nextPart4717124.oprHjl44XJ--
