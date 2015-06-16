Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 16 Jun 2015 15:07:48 +0800
Message-ID: <4847167.bn6DxWQpdi@voltaire>
In-Reply-To: <1434349345-12854-3-git-send-email-linus.luessing@c0d3.blue>
References: <1434349345-12854-1-git-send-email-linus.luessing@c0d3.blue>
 <1434349345-12854-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3092554.FtTgkTSLTX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix potential
	synchronization issues in mcast tvlv handler
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


--nextPart3092554.FtTgkTSLTX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, June 15, 2015 08:22:25 Linus L=FCssing wrote:
> So far the mcast tvlv handler did not anticipate the processing of
> multiple incoming OGMs from the same originator at the same time. Thi=
s
> can lead to various issues:
>=20
> * Broken refcounting: For instance two mcast handlers might both assu=
me
>   that an originator just got multicast capabilities and will togethe=
r
>   wrongly decrease mcast.num_disabled by two, potentially leading to
>   an integer underflow.
>=20
> * Potential kernel panic on hlist_del_rcu(): Two mcast handlers might=

>   one after another try to do an
>   hlist_del_rcu(&orig->mcast_want_all_*_node). The second one will
>   cause memory corruption / crashes.
>   (Reported by: Sven Eckelmann <sven@narfation.org>)

As far as I can tell from looking at the code your patch does not addre=
ss the=20
issue raised by Sven.

The first problem is that the mcast code calls hlist_del_rcu() without=20=

verifying whether or not the element is still in the list. Adding a spi=
nlock=20
is not going to change that. You can still have a purge event going on =
while=20
we just receive a new OGM because the purge caller does not need to hol=
d the=20
newly added lock.

Cheers,
Marek

--nextPart3092554.FtTgkTSLTX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVf8tOAAoJEFNVTo/uthzA+/IH/3xiyVbhW+46bhLX8RMuLX1h
op/lCtZXZ9BwYPQr1q0DxZRcFrLZA7+KGw3F879tPJwG51mo4FUdDztMKN+agXjH
jsxMYW5c9x6kRYDhoHoJtwiFMu5Al+1N7Uw1n8X11708txR0jQ/DcZCDMuU2u+b7
bTz2WLy4gvENrQt/Q+6lyMUWWTICMV/zFVHI89jlTCjnh+0mMNMJF+QVdJGzQ0ii
usUg64shKRbm2XEdMTgGOuESp/rGQ/hg/xiV42/AfnXmDv8Ue+ZuQ1Ghh+MWuskt
1MbGfzw+oizU/qcCUxn6B2WH58OwqQpebrCUQWA0sU4icecrM5reoCdTRpb6W+Y=
=v02B
-----END PGP SIGNATURE-----

--nextPart3092554.FtTgkTSLTX--

