Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 16 Nov 2014 09:50:43 +0100
Message-ID: <2704279.HXZgGAggkv@sven-edge>
In-Reply-To: <20141116062826.GA2469@odroid>
References: <069201cffe76$c6b720c0$54256240$@dslx.net>
 <21787558.pbjUVs1b2F@sven-edge> <20141116062826.GA2469@odroid>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1745744.399JECUa5X";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Current OpenWrt build
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1745744.399JECUa5X
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 16 November 2014 07:28:26 Linus L=FCssing wrote:
> On Sat, Nov 15, 2014 at 07:58:23PM +0100, Sven Eckelmann wrote:
> >  * can it be deployed?: yes, people already do it
>=20
> Is anyone using the latest batman-adv release with bridges?
>=20
> Maybe I didn't make it clear enough that the outstanding multicast
> issues and patches are severe (as in makes common setups
> unusable).

Hm, I am now not sure if we switched topics again. Maybe you can enligh=
ten us.
Jay was not perfectly clear in his first mail what what he actually wan=
ted to
know. His second mail was refining his question to something like "tell=
 me if
I can deploy batman-adv from OpenWrt because I've read the term 'crash'=

somewhere". I am sure that your critism of OpenWrt is valid and a good =
point
to make. But maybe we can make your answer a little bit more understand=
able
(at least for me):

You are saying something about "outstanding multicast issues and patche=
s"
without defining what it means in this mails.

Are there known missing patches/issues for batman-adv which would break=

"common setups"? If yes, why is multicast_mode enabled by default in
batman-adv?

Are there "only" missing patches/issues in the bridge code (the ones yo=
u've
linked to in the other mail [1]) of OpenWrt which breaks batman-adv wit=
h
multicast_mode? If yes, why is multicast_mode enabled by default in
batman-adv?

Are there "only" missing patches/issues in the bridge code (the ones yo=
u've
linked to in the other mail [1]) of OpenWrt which breaks batman-adv eve=
n
without multicast_mode?

Are these missing patches/issues only about bridges + multicast and not=
 about
batman-adv?

Kind regards,
=09Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-November/012=
554.html
--nextPart1745744.399JECUa5X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUaGVrAAoJEF2HCgfBJntG7XgQAKXbu6PEWxfZrRj2agZhU0ux
88GZ7UycPyDSXjimoJ145DBiDIrdMLdnHGLcLrBhExIWpf4I8clKw+vc6KhmCWct
m6Tb5oQbo7uM2T4i3CFE3qwAGNTnDJbW1UoqGiCVuJ26p3B5LEsM/kSADICulzB0
OTEaXyzLQITFz9lvenYC/NS/IIvI1e1rnN9DrRrZ0f4X4t/9q3fXNE4UPnF20pdH
nCn1PjJjpQiFYLmopHPkitlLRt2EHj5ZCSMEmxsHre0heMuBQEAJG/xufR2EDyDi
N3a0tCj17WjXyeIhH9JshEENjpawL3DUE7B6L6hw9liIXYkZfcivlUCdiIEC8EPr
Qww2mGnCQrlaFea/gJzZWnxbObfmn7d0aaDirdmQjoPGznH7KTes1Q220Ht9xa++
ddGn5eNS7LwkOZrzfH9Sxvuu+n3rjtqxuzkNZ8F5NrhCWygMPIEgG+dt7g0U1QMZ
yc0GdVC0StV/S6T5uw2dOzeCS5IDQkigBvPIenYiWmnEFr2aWzt4lKKGS0W7h5Ss
Rta/lKhrKQK2lYDodi+/I373OHpRHeDFYjplXhdmFlUZ8Pr6G1qpxuBTWfLj9bQD
RJtFIXcEFh5G2KZhEQO+N6M2lGIFu9oMdrUfJP0nok/Q1E2RZGKIzpfe2Q3A02pE
QAelvFzRVlzD+voKfJ8R
=l4l8
-----END PGP SIGNATURE-----

--nextPart1745744.399JECUa5X--

