Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 13 Jun 2017 10:48:57 +0200
Message-ID: <4393196.oYPnlPzS5o@prime>
In-Reply-To: <20170613082600.24910-3-philipp.psurek@gmail.com>
References: <1496077749.5980.2.camel@gmail.com>
 <20170613082600.24910-1-philipp.psurek@gmail.com>
 <20170613082600.24910-3-philipp.psurek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2629077.AKUu1ZV7eL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: suppress
 implicit-fallthrough compiler warning
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Philipp Psurek <philipp.psurek@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2629077.AKUu1ZV7eL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, June 13, 2017 10:26:00 AM CEST Philipp Psurek wrote:
> GCC 7.1.0 complains about an intended fallthrough.
> =E2=80=9C__attribute__ ((fallthrough))=E2=80=9D in this part of code woul=
d suppress this
> warning. Because older GCC compiler don=E2=80=99t understand this stateme=
nt
> attribute and because there is already a comment in the source containing
> =E2=80=9Cfalls?[ \t-]*thr(ough|u)=E2=80=9D we can suppress the warning wi=
th the
> =E2=80=9C-Wimplicit-fallthrough=3D2=E2=80=9D warning option. Unintended f=
allthroughs without a
> comment will trigger this warning.
>=20
> Older GCC compiler don=E2=80=99t understand this warning option and exits=
 with
> error. There has to be a compiler recognition after that only GCC =3D>7.1=
=2E0
> receives this option.
>=20
> Signed-off-by: Philipp Psurek <philipp.psurek@gmail.com>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 6bebb7d..29b7e2f 100755
> --- a/Makefile
> +++ b/Makefile
> @@ -101,6 +101,11 @@ MKDIR ?=3D mkdir -p
>  COMPILE.c =3D $(Q_CC)$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
>  LINK.o =3D $(Q_LD)$(CC) $(CFLAGS) $(LDFLAGS) $(TARGET_ARCH)
>=20
> +# Check for GCC >=3D7
> +ifeq ($(shell $(CC) -x c++ --std=3Dc++17 -E -P - <<< __cplusplus),201703=
L)
> +       CFLAGS +=3D -Wimplicit-fallthrough=3D2
> +endif
> +

Hmm, I don't like this one too much, since it looks cryptic and we will hav=
e=20
to add up new versions, which I'd like to avoid.

Did you try to change the wording? I've googled a bit and it seems a commen=
t=20
containing the wording "fallthrough" will avoid it. Maybe we should just=20
change "fall through" to "fallthrough"?

Thanks,
      Simon

--nextPart2629077.AKUu1ZV7eL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlk/pvkACgkQoSvjmEKS
nqGgIA//ZqWpYiegMUczij2HB/JyCXZBcattZkJzxW5UgMAb7sXRKhzfs/7dqSQd
g5aBVv+hJ+BXDlgIVoosJVoEwoWFXT44ogkvI5GV11SUPzxdGc1hkwLy2SnN4nDl
XOfSbLVKtmZ5dW7jdo+0kIObY/iFOxJ1e3QzUiMnVAkD+v/F3sl3BOhBPf8mizzL
er9UFfjrer43oWvIrw7mlJfdJXHRVj+lwZhGLfkwbg6WTKSkyZY60acOwL1ScB6F
Nl+WTMAP2EWxeZkApW1PGsjAQ2c+3NxPr7V9Z05cteztH+1cwMnHgUj+2Rbwsh1O
lrPTk7l9PgRZJz6KClUxiAEyO5QkFeoatjlkpBVb59lHno7jg/SmHqa9HzyvOwOD
JViQ0ZgFmZtYi6yBXfmjBeZzVFBiVA9t8Mt5kbaKpWWvsbIjryXATn0x0SFlJ+wk
a0stKpGmXb6+VvFGAsIYy2D1IdyTRp6KWl5yZ5r6shw9NmjJ1XXpTWk5XmWUyyXk
P26P/tEC9C9HM/U8CIcCXE6KuEG6C7LwPBr2BM+G6SbBAkCP4trV8BEvpCFRaqJm
7X0AkKzOFaF0cqhVzp993L3OlErHS+BX7Jkqqq2fmqSoaT1R+gozlcWegqQ7wpIU
YISFx3DaAEew9WCtBOgzwNZ0+3hZHhn4MShNEB/XV0WKZbRmS2A=
=Z0Zd
-----END PGP SIGNATURE-----

--nextPart2629077.AKUu1ZV7eL--

