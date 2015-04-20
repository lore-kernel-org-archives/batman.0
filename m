Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Apr 2015 08:26:46 +0200
Message-ID: <2274295.3MVYo3rjRo@sven-edge>
In-Reply-To: <1858370.NxXzavUms0@voltaire>
References: <1429298961-13250-1-git-send-email-sven@narfation.org>
 <20150419174900.GG2396@odroid> <1858370.NxXzavUms0@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3095803.rIGjiVBWYQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Use kernel-like folder
	structure
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3095803.rIGjiVBWYQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 20 April 2015 11:44:09 Marek Lindner wrote:
> On Sunday, April 19, 2015 19:49:00 Linus L=FCssing wrote:
> > On Fri, Apr 17, 2015 at 09:29:21PM +0200, Sven Eckelmann wrote:
> > > The person submitting the patches to the Networking maintainer ha=
s to
> > > take
> > > each patch and move files around and add some files to make it wo=
rk in
> > > the actual kernel tree. Having all files included and already  in=
 the
> > > correct kernel tree layout should make this a lot easier.
> >=20
> > I like the idea. Was moving patches between in- and
> > out-of-kernel-tree batman-adv a few times, too and that'd
> > spare an sed call in the future :).
>=20
> If I am not mistaken the build process of the various packages need t=
o be
> adapted unless we provide a Makefile in the root folder ?

This is what the RFC is about (btw. I have a cleaner version of the Mak=
efile=20
here in my HDD). It tries to keep the batman-adv stuff in net/batman-ad=
v and=20
provides the compat and extra Makefile stuff in the root folder. You sh=
ould be=20
able to do a diff of batman-adv:net/batman-adv + linux:net/batman-adv a=
nd see=20
no difference.

This means the person moving patches from batman-adv to net-next (or th=
e other=20
way around) still has some occasional changes in the compat code outsid=
e of=20
net/batman-adv/ which he must removed (or added). But I hope it is stil=
l=20
helpful.

Kind regards,
=09Sven
--nextPart3095803.rIGjiVBWYQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNJwoAAoJEF2HCgfBJntGZl8QALXqR9/V5AIR7nnVNzM8/ci0
DPgN30bSxiLAeD7R9uIXK58WqZo0YtuucjMskG0OcDUyXmHfVLe0m7V9fTBFnZaG
RgaIYHVGGQytpwlP86ZDQTKjTnmVCTd7DuU20bcE3+vb4PENpsEhhj2lm7tpinAH
ZwpDS7cebUJ2TOIbn9Hvx6O+gvuStXyjspO9V5BUeSjqsuawV2CzwogAknxYTlB5
ZDUTm9IYMAv0FgGKIU+hjihgqzeu2yewRm7l0tE1rL5DlroPbE3SrdhLekphF4g6
ptt5ilKZwX0ZMzTUvBM2pfakwjlejZe46ZsPgdWN3462HAzRTQ0YL/AM3hd9SqDn
UsmQXnSy44v2PIau3ljhbU/I6fqKNyu8GIPo3lEtNztMurpiCiEZ0zzvqtJ6TM6t
YbegjHJZGPGecSDZcjsFnwTPTx5/wKo9RsuRp0qNYyFMtF8DChCftVKVAyvi/LLo
1c1x/v8Qg76Quev842tIJTBuu3fNTaj85q0JqeUYEhhUgB4ZVxf0zPSr6VLnonxT
BPPweuJKJCukFGnJqu1Sztyg8HA5SoA+ivi6Qd6CJ9O/HUTIjYJ/Pa652/rrf59E
IsuT/8f16izKexc21xbW1agL2NzFbVVSVlrMDmnGQVnuiT6WVbCN/TLFzTaoPS9f
BVXBjMNE9HaHmSWKAn21
=C+fQ
-----END PGP SIGNATURE-----

--nextPart3095803.rIGjiVBWYQ--

