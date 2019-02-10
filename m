Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 10 Feb 2019 19:50:14 +0800
Message-ID: <2066898.20yZjQT5U2@rousseau>
In-Reply-To: <2472562.MHgaaGEVWG@sven-edge>
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
 <2472562.MHgaaGEVWG@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3379546.c2uJRL0TkL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on
 DAT DHT candidates
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
Cc: Sven Eckelmann <sven@narfation.org>, a@unstable.cc

--nextPart3379546.c2uJRL0TkL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

> > With this patch the purge timeout for local DAT cache entries and
> > entries submitted via a DHT_PUT message is differentiated:
> >=20
> > While the former stays at 5min. the latter is increased to 30min. Which
> > decreases the rate of broadcasted ARP Requests.
> >=20
> > Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
>=20
> @Marek, if I remember correctly, you had some issues [1] with this approa=
ch.
> Could you please check again

Sven, thanks for pointing this out. Antonio and I had to refresh our memori=
es=20
on these matters since the previously rejected patch had aged 6 months by n=
ow.

The conclusion is this:
* The old patch was rejected because it was tied to IP/MAC address=20
combinations snooped via DHCP only (!). The magic happens inside=20
batadv_dat_put_pairs() which was called via the DHCP snooping path. When=20
comparing the old and new patch be careful as batadv_dat_put_pairs() has be=
en=20
renamed to batadv_dat_put_dhcp().=20
With the new patch that DHCP dependency is no longer present. The way to go!
* The old patch also introduced flags being sent around which wasn't all th=
at=20
necessary. This is also gone -> green light++

I'll comment on the patch itself for further simplifications.

Cheers,
Marek

--nextPart3379546.c2uJRL0TkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlxgD/YACgkQU1VOj+62
HMClsgf9Eg4RoFjhjIOYlAGhnfe2VsRE3yECSiJHIdcwWTFiSbp92VQooSvqc9Xh
zz2zyqYS0juqJrmokkCtTUnUOkRTUsqB0uHYjqdPArZi4sCT9YKt9jj5JudJse6g
xSyoUA8YdyjwvxPZytv78g0BCZXZbpQut1SEk5XkViwsrfW7jGPnI4WgNAimamDN
MWyY1nIltNjQ5mc9c4xLQDuPps9M886QNHsI6KlZp6Btuyse5BojiZUku0ph/sMz
3DmZ9MzzsvQ+adTpxMjB7kufqE+jdNm0NvqTQT67D+L8UtHO/66ZUaQve1kreryL
jd+TqzKP59lZAYCyscMHc2ilQZGZDA==
=ehxS
-----END PGP SIGNATURE-----

--nextPart3379546.c2uJRL0TkL--



