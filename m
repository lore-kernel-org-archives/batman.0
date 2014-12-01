Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Dec 2014 19:36:24 +0100
Message-ID: <1636479.Afs8AsjRjg@sven-edge>
In-Reply-To: <1417456897.2788.2.camel@gmail.com>
References: <1417388720-5019-1-git-send-email-sven@narfation.org>
 <1417456897.2788.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10424071.gSAyn5jZTd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Calculate extra tail size
	based on queued fragments
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
To: Philipp Psurek <philipp.psurek@gmail.com>
Cc: martin@hundeboll.net, batman-ml <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart10424071.gSAyn5jZTd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday 01 December 2014 19:01:37 Philipp Psurek wrote:
> I=E2=80=99d like to inform you that I implement the patch posted with=
 this mail
> 18 h ago. It is a mix of the patch Martin gave me earlier and your 1s=
t
> patch from =E2=80=9CCalculate extra tail size based on queued fragmen=
ts=E2=80=9D. There
> was no crash, but this means nothing. Now I see, there are many, many=

> patches which solves the bug with different approaches. Please tell m=
e
> exactly which one I should test because I don't speak any C.

The mixed patch is a good start and doesn't really have to be changed f=
or your=20
test of this specific problem. It misses parts but at least the importa=
nt=20
change is included. The "final" patches which may need to be tested are=
 (and=20
these should be merged into batman-adv maint):

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-December/012613.=
html
(this is already in your patch)

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-December/012620.=
html
(this is not really your problem but I doubt that this is related to an=
y=20
problem you see - but just keep it in mind)

Optional and not relevant for your problem (these should be merged _tog=
ether_=20
into batman-adv master):

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-December/012614.=
html
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-December/012615.=
html
(these are partially included in your patch - unfortunately your patch =
misses=20
the part from 012614. And 012615 requires 012614 to work correctly. So =
just=20
cross your fingers that no one exploits this).

So if you want to have a clean test setup then please include the two n=
on-
optional patches (012613, 012620). It is also ok to just include 012613=
=20
because this one is most likely related to your problem.

The problem in 012620 should only happen when the difference between ba=
tman-
adv MTU and device MTU is far too big. A difference of around 1400 byte=
s. Or=20
if the device MTU is smaller than 1400 then the batman-adv MTU has to b=
e=20
around twice as big as the device MTU. This doesn't seem to be the case=
 here=20
according to your description.

Kind regards,
=09Sven
--nextPart10424071.gSAyn5jZTd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUfLUvAAoJEF2HCgfBJntGRMwQALG7ja/l/rQ8tAfoEdzJQ5rV
B2Yw7z24GuHR3Lb2TLSxUnW4eT32iQeQgBDpa81qdnJJl8DNeK3Txbj6lU1TCgWd
uM2lJ4cfs3Ok3/cqDc3D9jGvbTwHDMW6Gm27deIwUSxXGVq8lT4ONvWa9VvFVdA6
O9O194UiD50rc+64dIvu3jafn5MsF/qzf7tzjxdNC44VDlN404d5LuUg8MzlwiT7
f+5rKcXHnxwbqMyl5wcUU16+2Du6TW8kzXP5xy3iRG0I67WC0WKNezRdPdCCugnk
7QGSp38M8eG1S/9ER++56hbQC3zlbPRpNjX3KOJKNgSVy9Jumr9GUFBlsfAEPkKD
kvmyM6vjIf+C7kWykr39wfTqur5ek9Lr7IQfwwHOq+FvSqNwZTB+6XW8iXVuCIU1
PKx4K18v65d/swP4KnQXbpD5piwddRT43vq/XgicpX1Jfg1qwuabgjUQOzWqI7R8
huYIbkOlqBb5NjaBmQIuDfAynZsbRv0QknQIAwIUgjAt/krPb372gxI0M2tw2Ko+
6RVIuFxWWcPOsk12e2CeyGZBLqgq9JoJVkdKejhbabCe/vFSIwVztXnTU+Obbuj0
6exR9FB5lvsG7v0gy+Pl6tijMEabtZCNIKzk1kvXsYvSbLn4JtnQ/OoKn7zJ92lt
y+nitvHQJRzYyh5uO+0H
=IwHc
-----END PGP SIGNATURE-----

--nextPart10424071.gSAyn5jZTd--

