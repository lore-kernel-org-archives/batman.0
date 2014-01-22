Return-Path: <antonio@meshcoding.com>
Message-ID: <52DF6D6D.2040404@meshcoding.com>
Date: Wed, 22 Jan 2014 08:04:13 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>
In-Reply-To: <86lhy8pn5v.fsf@coulee.tdb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3OHUo5vxnihHLOD93rPvUh7O74AKok5lh"
Subject: [B.A.T.M.A.N.] memleak (Was: [PATCH maint] batman-adv: fix
	soft-interface MTU computation)
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
To: Russell Senior <russell@personaltelco.net>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3OHUo5vxnihHLOD93rPvUh7O74AKok5lh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22/01/14 07:04, Russell Senior wrote:
> Also, for testing actual traffic over the batman-adv link, I build
> OpenWrt r39354 with the patch on a Soekris net4526, so that there were
> two nodes with the same revision (different architecture):
> ubnt-bullet-m with ath9k; net4826 with ath5k.  I first noticed that I
> was losing about 100k of memory every couple seconds and pretty soon
> (with 20 minutes) the net4826 started oopsing on out-of-memory.
>=20

mh..does this happen with or without fragmentation enabled? Does this
happen even if you don't generate traffic on the interface?

> I removed the patch, rev'd OpenWrt to r39365 and confirmed that the
> net4826 build was also leaking at a substantial rate.
>=20
> I am seeing a similar, though possibly slower, leak on the ubiquiti
> bullet m2hp.  Right before rebooting, top shows kworker/u2:$N (where
> $N is 0 or 3) chewing up some cpu cycles.
>=20
> Has anybody else seen this memory leak?  Leads on where it's coming
> from?  Not a runaway process, at least not that top shows up.  Just a
> gradual disappearance from MemFree that /proc/sys/vm/drop_caches
> doesn't fix.  It isn't adhoc mode, and I can associate the two devices
> over adhoc and move a bunch of data with no memory lost, but turning
> on batman-adv seems to sink it.
>=20
>=20

Thanks for reporting!

--=20
Antonio Quartulli


--3OHUo5vxnihHLOD93rPvUh7O74AKok5lh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS321xAAoJEEKTMo6mOh1VEOIP/3XwxxS+0GukHrNqIt849HHG
lZ5bVX9s4eAy6LYpJv5J1WwcB4CblvUXbidW2af4qVjXB3Dl0eUju+6HsspIsmUr
9B4YoBMSCXqmtebZqo4xaZQwtwQroyEKHWbzG/s77MHmZDmwTXZT7ouhWlJH9n2N
pr99WO3BFBx2W1aIp5E0H01KR211XOFGi+sls13Rdw++PLsYrW0GhvD+epZ3rbgM
CO0jkmmgU3t/7YGQnSAJpdPPWNFZSTwSqHUwIvWwbuw3EaoY/UFpy/PT2hqXOQEL
eDZKGQKsNYg1I/Wx8sEHyzcsoikjFvW6bSsH0XCGHLq7rLqf3n55GBuqWjF0uXuH
M+UezAbwVFbZ0PdYgWI15VrjUzuuvvTqiap1xEeepqGSba64Tdb+Fs0TPz1JE2Av
1T/aYaH483z23DuXaLu+vVcQTrIhZT8TRBhphK+qLHJIjqg1jt7TJ1PP2FZ2FdOR
LmEp3D6D7EfRE+7IheWquz1dXd/TPeLGcXZCV4dXAPS9Mj0ufV9M33alUE90pATj
jj/x7hlOvlzy02UzUoXFRvTnfOdeQN6shxJK66Gv5uL2odIO3/N4H2UUX1zY0fxQ
0c/Rr0ihEW8+XwzQImLcBhkStBHwYHaP68sAA62X//zoNJCc6G46keksq8A9986w
wEf1VcmS2Aka6SJ2/VkZ
=3BK1
-----END PGP SIGNATURE-----

--3OHUo5vxnihHLOD93rPvUh7O74AKok5lh--
