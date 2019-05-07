Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH v2] batman-adv: Introduce no noflood mark
Date: Tue, 07 May 2019 16:00:18 +0800
Message-ID: <3691280.TvIfeD7Em7@rousseau>
In-Reply-To: <3693433.LtgH54LjNc@bentobox>
References: <20190507072821.8147-1-linus.luessing@c0d3.blue>
 <3693433.LtgH54LjNc@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6222648.CryiznrDVP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart6222648.CryiznrDVP
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 7 May 2019 15:30:46 HKT Sven Eckelmann wrote:
> On Tuesday, 7 May 2019 09:28:21 CEST Linus L=FCssing wrote:
> > This mark prevents a multicast packet being flooded through the whole
> > mesh. The advantage of marking certain multicast packets via e.g.
> > ebtables instead of dropping is then the following:
> >=20
> > This allows an administrator to let specific multicast packets pass as
> > long as they are forwarded to a limited number of nodes only and are
> > therefore creating no burdon to unrelated nodes.
> >=20
> > Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> I still don't see why this has to be implemented in batman-adv and not as=
 an
> external filter (tc-ebpf or something like that).

As I understand the use-case (Linus correct me if I am wrong): The mark is=
=20
supposed to drop packets that couldn't be $optimized by one of the various=
=20
batman-adv payload traffic optimizations. From outside of batman-adv it wou=
ld be=20
difficult to tell if a broadcast / multicast packet was optimized (think: s=
erved=20
via DAT cache, sent as unicast, etc) or not.

@Linus: How about making the intention clearer by choosing a better name (f=
or=20
example: nobroadcast mark) and introducing proper documentation when and ho=
w=20
to use this flag ?

Cheers,
Marek

--nextPart6222648.CryiznrDVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlzROxIACgkQU1VOj+62
HMDvlgf/XIwoh8N+/zWkJG7ft95S7STYUefdu/ZGCOMY5W6Zo+pB/UFgzpZarJdK
OKGkHEjT7rc6y9LK2+2DmuYcmwAc253JgwG0FoAL5mLx8XdctYqCLphunPtAKlev
7GKEP5vfvXmBHTVYRTSYd6D9Cc7vnWHlSjAepN0tx2NUE0ybuqPQri8l0o0rug9F
aubKiDWu3BTk+EBtoTT/I+vOqFEcfHyDJkk4JG5UzaAHWKF6YiMpzWJR7MvwjL79
d5ANEFfRNhG1hh6fQDBqQEpi92vJO541zdmaFlMqrHZ/Uto1+VZSLCCnRQw40/kp
X68CN/wyPYDJJUtZk0ucswm/5uXVTQ==
=l45+
-----END PGP SIGNATURE-----

--nextPart6222648.CryiznrDVP--



