Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Tue, 6 Jul 2010 19:47:59 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11731094.05CITRpk1K";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201007061948.05784.clemens-john@gmx.de>
Subject: [B.A.T.M.A.N.] Batman advanced and internet gateways
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

--nextPart11731094.05CITRpk1K
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I know I asked this question some time ago but I didn=B4t got it till now s=
o I=20
have to ask again.
I know that Batman advanced does the meshing on layer 2 and has nothing to =
do=20
with layer 3.

We have a wonderfull working Batman advanced network now which we use with=
=20
IPv4.
Communication inside the networks works verry well and everything is fine.

Now I want to go from the Batman advanced mesh network to the internet.=20
Therefor we have several gateways which I can use to get into the internet.
To use one of the gateways, I only have to set the default route of the mes=
h-
client to the gateways IPv4 address.

How can I do this automatically and how can I automatically choose the best=
=20
gateway for my client? I know that Batman advanced does not do this for now=
=20
but I already saw something that sounded like made for this in the trunk=20
version and on the manpage of batctl. The function is called gw_mode.

*How do you this?
*What do you recommend for this task?
*What=B4s about the funktion in trunk? Is the function made for this?
**If so why do you mix Layer 2 and Layer 3 now?
**When do you think this function will be in the stable release?

Sorry for so many questions but I=B4m a bit confused^^
Clemens

--nextPart11731094.05CITRpk1K
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwzbE8ACgkQZgdHbA22lqOTfACfYSxr17NmXXuhlw19aIt1i7re
mfIAoOGEk08e6DGDMj/oMqaXfN0uQqiS
=T/4k
-----END PGP SIGNATURE-----

--nextPart11731094.05CITRpk1K--
