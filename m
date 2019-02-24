Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 24 Feb 2019 22:22:37 +0100
Message-ID: <1711580.CLzo8a4Rc7@sven-edge>
In-Reply-To: <CAHh66V-79d--F=d-Rx+af6Vffm09bs=-EOTiK4dtB3+r-E91Ag@mail.gmail.com>
References: <CAHh66V8N6KCqGdxnMQpHTaqjLbfMwWyGrRvjZY+P20W3-UF4Hw@mail.gmail.com>
 <CAHh66V-79d--F=d-Rx+af6Vffm09bs=-EOTiK4dtB3+r-E91Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2719746.dRSoaqNljY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fwd: nodes start disappearing after a certain
 node count
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
Cc: umut deniz <umut.deniz@gmail.com>

--nextPart2719746.dRSoaqNljY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 24 February 2019 21:48:18 CET umut deniz wrote:
> my current platform is ti's beagleboneblack wireless board running openwrt
> distribution (the required bbbw dtb and wl1835 driver firmware applied) with
> batman enabled and configured. with this high level description of the
> components i am able to build a mesh network 6 nodes (i.e. bbbw cards) but as
> soon as i introduce a 7th card into the network batman mesh becomes unresponsive
> as the last seen times start to increase and finally, after 200 seconds all the
> nodes drops from the originator and neighbor tables which could be inspected
> with < :#batctl o> and < :#batctl n> commands respectively. all the cards are on
> the same table and well powered.
[...]
> i researched for a while for the cause with no avail. i would appreciate any
> kind of help to point me to the right direction to solve this.

Please don't use things like wl1835 when building larger meshes. It is known 
that these kind of  devices only support a very limited amount of peers and 
are most of the time only (more or less) stable in management mode (client).
And afaik, the wlcore driver (like other TI wirelss drivers) is also orphaned.

If you're wifi link/driver doesn't work, batman-adv can also do nothing to fix 
it.

Rule of thumb: If it is a USB/SDIO wifi device, start waving your hands in the 
air, scream and run away. This strategy is also helpful in other wifi related
situations.

Kind regards,
	Sven
--nextPart2719746.dRSoaqNljY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxzCx0ACgkQXYcKB8Em
e0ZTuA//TFb+kL4PdzIX63TrFtpHWk0uzdyUuIR+oR36mMrOhFf3D9ULsgC7uDNp
Okg5rwewcPhBGOAbdYKdySGzIAKVS1Qi2moiP7ydh3YUFf0jneAVaQ/O5vXznunP
te4vnvSjynA9Kp6Q60A03nqwU5kBJlatKbUxiCcbiEBUENJ54grb9ho/vm/qE38S
L3pnrbb62cGZKE4cRks2ACT6DdtQmiQrpnTTEfrqBbUM6m4zDsboZdxGOZTCngjB
WSBRDD5eSpIDcelCV4NnBiXAg9IdrO6HV1NNaU1Glox7p+PBs8BydRKlMMUdNO+Z
IOl26/2p27rSzrjlOWp4JBD7sHczMkL6juakRemIkiCeSO6iaKlN2ShiibJEKuqm
SOTtJiSqR+WuU28dP7uU+ByriG+o8/EiX4ybG6N8PGs/QSDRB4vX2XkGNQ122la3
c3cHtVFdg/F2r1qLeDXjuMnLYbT9oIBqE0nWNZtMTxgwgU4Uhb8TiYRN3xoSkwSS
JqTblkhSRPGfZp/tte0avI8nEudyWR7Aon3jY70ImWbPUk32f1BT3Pu4/RbSLBKZ
S+E6mirmjF20/92eScG9SVMoKiIeQi/9gw613BSmUXsrIp8+Q1rN0NrEltdKFF4D
0lk0xBAwxn/7UxFZs9ez0zoSZkFICgl9nShPTf4RbN91Fh3l+O8=
=qpvJ
-----END PGP SIGNATURE-----

--nextPart2719746.dRSoaqNljY--



