Return-Path: <ordex@autistici.org>
Date: Thu, 3 May 2012 08:40:48 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120503064047.GA2307@ritirata.org>
References: <1335984651-15385-1-git-send-email-martin@hundeboll.net>
	<20120502211612.GB2093@ritirata.org> <4871527.FqzISMEzZu@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <4871527.FqzISMEzZu@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Change "make install" path
 and run depmod
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
To: Sven Eckelmann <sven@narfation.org>
Cc: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>, b.a.t.m.a.n@lists.open-mesh.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

iOn Thu, May 03, 2012 at 08:26:40AM +0200, Sven Eckelmann wrote:
> On Wednesday, May 02, 2012 11:16:13 PM Antonio Quartulli wrote:
> > would it be cleaner to run depmod -e $(uname -r) instead of using -a ?
>=20
>=20
> Why? The module doesn't have to be build for the current kernel.
>

Ok, then maybe $(uname -r) is not the appropriate way to get the version of=
 the
kernel we are compiling the module for, but I think we should run depmod on=
ly
for that kernel.

However, is a minor problem. I see every other kernel module acting the way=
 I
described. But we can live anyway I think :)


Cheers,



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPoihvAAoJEFMQTLzJFOZF8wgH/RGFuTyfDiZXDK/BYkHPanl5
uCB8xJIhiuWPs0dfcRCTKy2gi/hV/x1l8lemXLLqqgdPNUUoNWh7msyrXKrKF644
Noo7OQ9fxHJSVY8vqHZ2k6mryrimVhCetTeEkLfI1w/4vBzFpdoOgGG/YcgCzlGG
I6//7HCjOJztaGPLezSv+2CClpoEgZuY0mbko665NNX5a5nNq6BMEe0b7N6l4TB+
QqE+JboeW0nCy9uyMVp1aIusGEy/wdohyIm5TzNyBS3fSrJC3uzTRgQooonzHLJG
hPkenXP/NIGTaacZJdOCxTFJQ3zAJkqbmLmmDCwGV2PjTbbrxg7AqQdA4yu500U=
=goqV
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
