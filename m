Return-Path: <mt@debian.org>
Date: Fri, 29 Mar 2013 11:48:16 +0000
From: Michael Tautschnig <mt@debian.org>
Message-ID: <20130329114816.GR798@l04.local>
References: <20130320175154.GT41481@l04.local>
 <3212285.GF4Btbehao@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fberPwKQctZF/fXp"
Content-Disposition: inline
In-Reply-To: <3212285.GF4Btbehao@sven-desktop>
Subject: Re: [B.A.T.M.A.N.] Bug#703540: Inconsistent use of _GNU_SOURCE
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: 703540@bugs.debian.org, b.a.t.m.a.n@lists.open-mesh.org


--fberPwKQctZF/fXp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sven, hi all,

[...]
> > Either all or no file should #define _GNU_SOURCE.
>=20
> Please add information how to reproduce this the next time you are adding=
 such=20
> such a bug. Now I can just assume what you are writing is true (even when=
 the=20
> man page about sendto says otherwise). Not knowing how to reproduce it in=
 the=20
> best possible way just makes it harder for everyone to check the impact o=
f the=20
> problem.
>=20

Just one question before I elaborate a bit: what information in the man pag=
e are
you referring to? I can't quite seem to see anything mentioning _GNU_SOURCE?

I fully understand your concerns and indeed it is a problem that I cannot q=
uite
provide a concrete counterexample witnessing the problem. It may even be the
cast that, at present, this is only a potential problem and not a real one.=
 It's
much like a compiler warning: ok to be ignored if you are doing it intentio=
nally
and you are 100% sure you know what you are doing. In all other cases, howe=
ver,
it is likely worth fixing, as the problem can only ever be found by link-ti=
me
type checking, which usual compilers can't do. Even if done, there is some
non-trivial effort required to tracing back the type inconsistency to
inconsistent order of #include or a missing #define.

The most I can provide right now is all the scripts that suffice to reprodu=
ce
the build results and error logs, to be found at
https://github.com/tautschnig/cprover-debian

> I've forwarded it to the upstream maintainer and attached the change for=
=20
> Debian.
>=20
[...]

Thanks!

Best,
Michael


--fberPwKQctZF/fXp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (Darwin)

iQIcBAEBCAAGBQJRVX9+AAoJEKjvEonjOGdBm9EP/3j1gXYjjLIwlWiVogadI5jT
8gIIdRQGZ0xmSc1JovqDZYex0WB638QjKcavlRvu2bHD4DIhlVnJ7Oz1jAjvmNfg
eQB+FkW8kOKZvbbnKzTzJwqlXik2jjqZ/Hk4PW1JL19i+HqVAlRW2zXFFHwn4kpR
5hZbT44/sdixgN8x5RfyOQHFiWe/Mu4Tmelg7rPB3v1WufW1Zukx9dUiMjsnsWf2
u06r24+ODNGsgtTUANAOkuFRZ/QeZxotcJjoPyKcf2wzzfvR3kCnBcoe2Q76GcvG
UE7nPzRJD1obcewn++x67liCmx7qct9oEe0WQGH1lmoJJJkve1ekeJJ9fq0LCAEZ
R8zH9BTLYpwGchl69B4shUTpp6ulyN2rYz84kLkmXkPeEOlCANRaVID4XWlQnUxO
RgXmEoey1yqHjPNOahJfPbvNu95BydU1ALoK9XL0Vl0RuZvHb50ww/Oo8qL1YVHG
WGXtkblVm5isyWnt+GWCO1oOMamPjqcyEVNRspunBWTRjYMAKzP86/QHm1/xdthv
vQbYwRpdGUIlfxzAfPb7DxyUBSBdrkaPOThvm27HlpJH4nOG/u1K6fINnXRIPUpd
R67fiRMziDLyAd3xGzu7sFlLNLkhDeCaP+LJ8UZTlWY5reaw/W6lfDcd7O6hMJEc
1diqttQuD1zw1iJxZnfZ
=CrCv
-----END PGP SIGNATURE-----

--fberPwKQctZF/fXp--
