Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 19 Dec 2016 12:37:43 +0100
Message-ID: <3103100.ET4KBLGWzf@sven-edge>
In-Reply-To: <20161219105027.GL6323@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <31536424.nRq5nXL76i@sven-edge> <20161219105027.GL6323@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8877508.rCNl6clPWP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
	independent TVLV handler API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart8877508.rCNl6clPWP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 19. Dezember 2016 11:50:27 CET Linus L=FCssing wrote:
> And didn't use "void *ctx" as a parameter of _pack_ctx() directly,
> to have at least some compile-time verification regarding the
> types.

I was not talking about the packing functions. I was talking about the=20
function which is used to trigger the handlers. It is not necessary (unless=
 I=20
miss something) to have some explicit void * casting when its parameter typ=
e=20
is already void *.

> I wanted to have something a little similar to the way icmp_hdr(),
> icmp6_hdr(), ipv6_hdr() etc. do the casting, for instance, hm.

I think these functions cast from char * to something like struct icmphdr *=
 by=20
first retrieving the transport header from the skb. So they do a lot more t=
han=20
your more-than-necessary-explicit casting function.

Kind regards,
	Sven
--nextPart8877508.rCNl6clPWP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhXxocACgkQXYcKB8Em
e0YIXw/7BZoUGtEguXh2UH3etsTaWDro1ujIu94B46cgG+SnP7dr5ZzAH972j3W2
FVrMYq2vqhk/jAs7JLhmFA8XalGhPJCl9jFNPrmxrkaSXjJ9/LoQiZuENbnBvfbv
k7wIwt8h/vL/KqzQnfxiKPQKWb3keM7AOM+EcvgiJckMWV4VaVxJVVmBhgh4bFGA
lmHIwRylqt9qsOFlXfvTNz3R4QD9QStDdCgvCfg/uL8n5+KTt9zQJKMpBNRlZiad
khHmkHWAWyB2wmDjGB84K+2Gh798pbZ/f8jxedBUt+WsgUhaiJ9cc5Ox+U03jKSU
82iY8Hqwl/5GsQUQmO3tqRKos38UbCH/tjxUPN9bpmXqFypiU4APxyvTHSDWkObD
xAZHkkfHvmiu93Lu/jC6f1hu3eOgxAxlZms3gn9QOJ0IIwRKBqGB3esMPHQyPPmm
auLc65UWY7V3mFJK9VfGVhpHU5wV61NC+49RzhzBPem8AjXW7E/dha0ufidmjrr5
r7CFt2N+15sERGNuEz4gjt+rMVldg8YKxc9MvmJ1q6C4HCg8hfoCZQGcsVfiKgwr
qQoeb5smg3OYC6e7DqehvzKNPXOWxk5BuIF6fUOHsKh4U0e8LzKe2OkSrhdTAt80
hLafLc+lCBRjSm0EWCdjavHfsgYxb4KHVixQ6jA69JPy5oUdwMY=
=Mrsb
-----END PGP SIGNATURE-----

--nextPart8877508.rCNl6clPWP--

