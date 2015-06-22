Return-Path: <antonio@meshcoding.com>
Message-ID: <55883F28.9050806@meshcoding.com>
Date: Mon, 22 Jun 2015 19:00:24 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434795203-21947-1-git-send-email-sven@narfation.org>
In-Reply-To: <1434795203-21947-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VWvAhoaw14mSWtfVS7ociMXMtc6dTeDCI"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Annotate deleting
 functions with external lock via lockdep
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
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VWvAhoaw14mSWtfVS7ociMXMtc6dTeDCI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/06/15 12:13, Sven Eckelmann wrote:
> Functions which use (h)list_del* are requiring correct locking when the=
y
> operate on global lists. Most of the time the search in the list and th=
e
> delete are done in the same function. All other cases should have it
> visible that they require a special lock to avoid race conditions.
>=20
> Lockdep asserts can be used to check these problem during runtime when =
the
> lockdep functionality is enabled.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Thanks for this patch Sven!
This should reduce the likelihood of having of making mistakes in the
future (I hope!)

Acked-by: Antonio Quartulli <antonio@meshcoding.com>



--=20
Antonio Quartulli


--VWvAhoaw14mSWtfVS7ociMXMtc6dTeDCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJViD8sAAoJEOb/4TMchkvfbVoP/1lLpN3zLRe9wzo7mAC2trNK
e8Ay9O1Xar22W6xF0VNhbHT90WbPXbb+FZ6KvpTOV8iEHXdB6+PqIbzh6j8NQkws
nwuMs4jAkppx7o/95Kjqk51U6t4l0RzqL0aJh4g+pQFzuhF5nZkqV8EeQ01MrL5S
AIx5iUs6LbgGK41VqeRB3UPYKk0sKG8pVn0jPnMIjtfknoWWN9XVSeFf71gfLYec
lQ9a1ZpJHjwaWZ0fqfSxqGUV3njbqqmKVRxri4aSFeHwUW7gMA6U7rJVTc2Wxf1v
LGyr/g5Yk+dAF3UANzPAOIspmat6fnpA1cceT+/MvRklZl9KpH9Q0YvsLFVxEhBQ
Y8nVZoiXnVmFiGCoLCuO8YANVsu5ePEthI2OP4UAGTlKbIPaNy8Ur7gNYaICYk3R
0aWfZN4FFYQovFJnqmkxOzrOxV94Eg1Y3Oqv7AfQajOPfJZg4U4TH7BaEW324jzV
mJBbBCgsz6VP770npZ5KJoLL4ukc+S8kei0t9QzoPIjm6vfgwvisfEVcDelhhDdY
FTnm1/uEqYrXXyyklHnXJuxTOhCeSKt0qlyYR3yazvmYoVb0PJuZ5qF38cxN4KZL
AONHd4xsrinEiH82nRLZpR+h74oO00bpf/+YXrkhwUfghg4g4LqvullZYUe0l98O
x5VTswtgJq4vVLV431JI
=Drp4
-----END PGP SIGNATURE-----

--VWvAhoaw14mSWtfVS7ociMXMtc6dTeDCI--
