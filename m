Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 4 Dec 2010 20:42:14 +0100
References: <201011291800.02971.lindner_marek@yahoo.de>
In-Reply-To: <201011291800.02971.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1339953.MfJWNC2QZT";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201012042042.16056.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] performance patches (v2)
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1339953.MfJWNC2QZT
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Marek Lindner wrote:
> Hi,
>=20
> I continued improving the the performance patches which results in the
> first usable version. I tested it in a VM environment as well as on real
> hardware and did not encounter problematic behavior anymore.

I looked through your patches and have some small suggestions. First I woul=
d=20
like to move the hashtable-functions related patches to the front. This wou=
ld=20
make it possible to send a new version of batman-adv to David S. Miller=20
without adding to many changes (so maybe he doesn't get too angry this time=
).

Then you missed hashtable_t::elements of the hash implementation which are=
=20
only needed for the resize implementation (now it is only a wom :) ). The=20
hash_iterate function is also still there.... I would like to remove it=20
completely. hash_remove only rcu locked the list - but we must spinlock her=
e=20
to prevent double frees. kref_put of data directly after call_rcu for bucke=
t=20
could lead to invalid memory access when a rcu protected region still acces=
ses=20
the bucket which isn't removed yet (but the data in the bucket was already=
=20
removed). Unneeded(?) hlist_empty checks. Missing conversation of neigh_nod=
e=20
hlist operations to _rcu. Missing rcu_read_unlock's. Missing correct refcnt=
=20
for neigh_list

I would rework some of those parts and resend all patches again to the mail=
ing=20
list. This doesn't mean that I have checked everything.... some of the patc=
hes=20
were just too "wirr" and this is a first try to get it in the right directi=
on.=20
It still needs a lot of cleanup and testing. For example neigh_list stuff a=
nd=20
the kref_put after call_rcu is complete unfixed and I also didn't finish th=
e=20
complete patchset.... maybe will continue with it when the patchset is clea=
ned=20
up.

Best regards,
	Sven

--nextPart1339953.MfJWNC2QZT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJM+pmWAAoJEF2HCgfBJntG/04P/A/n6Bq1jl6C2VMHVxQ5hyav
WBZZf33C9l/qBxV5hm6fpSoNfBbNFmquwOjkyqQ4xLVwwxbCxlXLYM9kr5G9l9Zg
tMyfBaXhX3RTklJV+uwuFT7tlwahxWDrVnzmmZircas6JW0Dmhqf8qGtlagRHTVI
fgVLEawt3oHdq9k5Q/qL2EVtFDVBZxezd/MEt14lHqBIqtsxSqrGnECZK6tjpZPK
7JlS8eZKLKcMFK1oh2UPN4RKKEyB9shc+hh6+xbB0tHCoEFRD8Q5kkr1VfXP614B
kG84zqdhIGOsfqiNISTeOp8dM+CC/5AOdm3zNWWSSpucye8Lsg0UWfA8rmLmlhGz
wDIpIv1KD2k9wpuRLw2+8B96DT8LLywPBg3WGVrs6C+o8rs+wJtua0GTkgSjjQBe
C68Ly5cvt2h8hghMposEdOOJGwQry7urJxmROOX31DvqS7eF4h+Qia3g4LgY1iJH
OtljX/38hIaeCdrYa380cVtP9GQjQhyqwSEhvSOHcoiMDllZBvTx31Ftkx7OfXsT
ANYWTlrYBZegCKX09LTxttfLOThCEakvrjpp+RI/J4pMjHRLpqWYn3SrG4yJUsvN
L8Omo9fit7IdEm74Wo/UJbHQKebD56d5Eik7V24MBLcKJy22UF7tBYn5yjyRO2ka
FvOwJgbPZPAcFDaE7fhh
=jUQV
-----END PGP SIGNATURE-----

--nextPart1339953.MfJWNC2QZT--
