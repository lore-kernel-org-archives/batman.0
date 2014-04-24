Return-Path: <antonio@meshcoding.com>
Message-ID: <5358FD91.8090107@meshcoding.com>
Date: Thu, 24 Apr 2014 14:03:29 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1398282390-4677-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1398282390-4677-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KJCccHGnFKAIXb2c7kA3Lx3ea89rcBiq5"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix indirect
 hard_iface NULL dereference
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KJCccHGnFKAIXb2c7kA3Lx3ea89rcBiq5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 23/04/14 21:46, Marek Lindner wrote:
> If hard_iface is NULL and goto out is made batadv_hardif_free_ref()
> doesn't check for NULL before dereferencing it to get to refcount.
>=20
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>

ACK for the change, but shouldn't we have an Introduced-by in each
patch? Later I will change it to point to the "proper" patch before
sending these changes to David.

Cheers,



--=20
Antonio Quartulli


--KJCccHGnFKAIXb2c7kA3Lx3ea89rcBiq5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTWP2VAAoJEEKTMo6mOh1VuUsP/jIxOTMFRQC7R1fl0c+THNtD
Jdz4nzZuJLieN4hJI+kqJdVswcTr5Z8NlXPTw65xCXU6aTvdDTEvkDj/KHxoNqPL
1MDsZVxh8lnRVTp+mqi0cXFVx0T1zxs61cgP0AZov5/PkcxpDIHetcuf9/P3BgpK
BJqzgHkEG9B/ix9jbmkvw7FCvHMR6c1L99nKo8gv/xu8WoUrZmPL0PiW+e2CJR3O
fwaWTn/Rtg91LVxn44guuukWppoM2fGYItx5/8J85vK+vOpH3flO/Y2Tpocz1p0B
1MaYllqcVHfqzCvOJV+WcDcEGhw58p6dAemIZEJ6OGat4eO0zyosuQiLJIvkcOBl
51Qvy50se9if2TvWvXVthrSeDDZg/H5MvcEx+RFKsB8sznrPir/FiqfdfDxNVHKY
7BRCG8nmV7IH+P2/+1WwxQrfFmYQmN3IaXKSUDUCyR8DJnGNLVsm7H/uv5d98YWp
eoTTn5leWq7GdUkcvIHHVQWxYHDdySSAXbpqppJcEFUCcCkH+xC4qGps+n1o1jU9
zq3c55RGbJ5AE7dqJmxiecAf5bfSHoU7VCBnn/pD5lR4hhTlrCO2li7fCMHl+uT3
Ds7/iPReaTLNsRyfMySYVqdz3+9OPQt4DRz7e+2IJ6CoG/HYGeQpJHewgnLbL3Kt
tZfKAECm6Tft8Swn9h7D
=je20
-----END PGP SIGNATURE-----

--KJCccHGnFKAIXb2c7kA3Lx3ea89rcBiq5--
