Return-Path: <linus.luessing@web.de>
Date: Thu, 4 Mar 2010 01:06:32 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100304000632.GB24284@Linus-Debian>
References: <20100303233946.GA24284@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <20100303233946.GA24284@Linus-Debian>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] vis packet format
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


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

And maybe the last explanation about the "buggy vis output" wasn't
clear enough. With the current vis raw output we're loosing the
information with _which_ interface we are seeing another nodes's
interface (currently we are always starting a vis raw output line
with the primary interface mac instead of the according
interface's mac).

Cheers, Linus

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLjvmIAAoJEBKw7u43QNpfrc4P/3uTf6aZ/7EmUcrNzfi3F1dR
5sPyi02+xgZUQCvZYAlhvXSTX3ZmGM4ifQ2zR8k8eZhejYIGz4UMr+a62Yuxk7um
G69FZPLOoNM231/nzTAq2+6l+CJaDVa1ES246RQiS6clKYz5eGCj8N6XG9xraeto
23tmUvpJ2pWo4I2GcUqDFSgFOEN+KQMv5afcOuptQOakkaonKYJPR3VWHmbd8NL6
oyvWLW474lWVhk380+C/R5rbhuMTTlUSOMShrORHTVaFAKtHB/kqzb37o4in/O9q
H3cCy37AmUHWDaPQRKILxhHhgFraYdZYKcY25IXcI0ZnKLZhT1Dh9pfgoXStipVM
yy+Ruc7EpHYzb7TTn0mRXqfgPBxiHNxyS7MsL4lhYKzz7v0mE3XOLzyJ3Sa40gBa
KEKHNTM0EXM60GfAJ2kP/No5KWUo8SyfGgX2aYb4Pv+xaiVEukl5Z8S6saB6wS73
DaAc0x9EF5pVaz5F6r23U+y6IFrz9H8a76ZH7Jn+88cWJwA7DFo0RboLakL/QH7F
T2LjIZS0SpxOXD8e9VJngvfWxxgDsArfVvvUTP5ZIbB203/qZsqfHOR7dNw1mn7W
2yv++8cNiI4BgpolLR7cJHNLmwS+Z2cfG/gDDqZcCiQshlDW07n1aRZvmH0Pvddr
PXkcfdirHfquicNrPHpK
=i7EV
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
