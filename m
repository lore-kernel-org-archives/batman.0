Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun, 24 Jan 2010 23:03:48 +0100
References: <20100124211718.37790@gmx.net>
In-Reply-To: <20100124211718.37790@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2458833.SkGjmqWLpB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201001242303.56730.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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

--nextPart2458833.SkGjmqWLpB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Juha Yl=F6nen wrote:
> > So please test and capture
> >  * rawsend from ARM
> >  * ping between laptop and arm
> >  * a "ping -s 1" between laptop and arm
> >
> > I hope that tests help to see were the problem really is. If the ping -s
> > 1 works, can you please also capture a some packets of batman-adv 0.2?
>=20
> Logs for all cases attached. I pinged from arm to laptop, would you have
>  liked it in the other direction too?

No, one direction is ok. What we can see here is that we have a < 50 bytes=
=20
packet and it is seems to be send correctly. So maybe the problem is not=20
related to "small" packets.

> Rawsend from arm->laptop didn't work, the packets end up in the laptop as
>  llc packets, so apparently they were mangled by the driver. rawsend from
>  laptop->arm worked fine, which is included in the rawsend.log file.

Ok, so we have a real simple example here. We see that we have a "large"=20
ethernet frame (unlike batman-adv) and a "unnormal" ethernet type. So maybe=
=20
you could forward rawsend.log and rawsend.c to the driver developers. They=
=20
should be able to find and fix the problem with such a real small example. =
Or=20
does anyone see a related problem in rawsend.c?

What is the batmand stuff for?

Best regards,
	Sven

--nextPart2458833.SkGjmqWLpB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLXMPEAAoJEF2HCgfBJntGTa8P/1gleYGZxL4cN8QgjjXyr18E
r2Pw+4NIrYOtmHGq9rkqWXXc3IgtFWhTACAyFei1ONX2hGvKwiVjmbbqaj0lFS4k
JKlFM7dMKYDYQ1gEASuSugib7gWQblhhElXJCXA+oOVICYBNPTe0fpqlkNluZ19Y
rvZmvuh2Ss6tN+yY9jfZbo8n3gHOguYCKfX1F60M1JS6HVho7R5JcdyOElC7hN6G
SigKVesbvD/bKHrwg2Oeze0WubLA+IoGdl1B4czfmiWIYgK7p9MgzxzFh6Jr7tqM
4jlGOS39H8mlTFQu2AO/sqtRWLc6CfRmH4WjXp75st4c1+sUO0h5dvogbemU9pYq
p1YfhycJwIhspnCOaN8jhA5+siSdb/PaSXUbtNZO/m7u0BeCZKSsCtwshfzzvj2e
otmPGoux95prkF0PtK62Z2B8XLqvhgI5u0fSMR2winZIxJkcxzTxJ9eQO90PcHg/
5BDuTY4pCFesX9eyn3qmcE/xlu0tiCljL55w9ZwxfKoOPdhgrJmCjhpCUWdpsdOh
uhlhvIl8zOe3285gN3o5KxJ9KQVfs3j+bdcEcqhf5iUFAASqbP+0qlhjf3usWj1k
cIeJdSMjVt0qw9qrShjY4rFXiu6JxPu9yE8j3IQajzHcpsphQ+dor6sXD3/9H9Lb
pYyDnoHEhtgA4NfUGnEr
=9JN0
-----END PGP SIGNATURE-----

--nextPart2458833.SkGjmqWLpB--
