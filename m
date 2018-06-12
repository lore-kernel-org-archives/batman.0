Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 Jun 2018 21:45:53 +0200
Message-ID: <3268372.71QmLCPILN@sven-edge>
In-Reply-To: <20180606153529.20016-1-sven@narfation.org>
References: <20180606153529.20016-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1671669.vjXytAXkuU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: compat: initialize
 sinfo in cfg80211_get_station
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

--nextPart1671669.vjXytAXkuU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 6. Juni 2018 17:35:29 CEST Sven Eckelmann wrote:
> Most of the implementations behind cfg80211_get_station will not initialize
> sinfo to zero before manipulating it. For example, the member "filled",
> which indicates the filled in parts of this struct, is often only modified
> by enabling certain bits in the bitfield while keeping the remaining bits
> in their original state. A caller without a preinitialized sinfo.filled can
> then no longer decide which parts of sinfo were filled in by
> cfg80211_get_station (or actually the underlying implementations).
> 
> cfg80211_get_station must therefore take care that sinfo is initialized to
> zero. Otherwise, the caller may tries to read information which was not
> filled in and which must therefore also be considered uninitialized. In
> batadv_v_elp_get_throughput's case, an invalid "random" expected throughput
> may be stored for this neighbor and thus the B.A.T.M.A.N V algorithm may
> switch to non-optimal neighbors for certain destinations.
> 
> batman-adv's compat layer must take care of intializing sinfo until it is
> fixed in the upstream kernel.
> 
> Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 API")
> Reported-by: Thomas Lauer <holminateur@gmail.com>
> Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat-include/net/cfg80211.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)


Added as d7280ffad5e9 [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/d7280ffad5e9025bc6c26f9ad4925fd0797fb8db
--nextPart1671669.vjXytAXkuU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsgIvEACgkQXYcKB8Em
e0ZDFRAAqXHcfwyE1ImTSHKI45IEb7Gs+rK3je2LUICdxO21w37bCiizLVbCqgYf
dATzTrc+d7q987uEZJdmNr9WzOxMrD1ib2Xglhzi8Nw/6CHlVIgfrhEKnHG6/80/
hmfKklhfSB30Zs8adE//1Alp03ptm58yaRh62eUYcHs1TyMtuU8UFOMIKt4SajXP
BaAyHUdZxn6fYjTSnjJq3VfcG7G92Amm7hIyIUk/OVws88Q5X5qE3tfjd1Z9jIB5
b8dFKhcWOEKqKy5VYdTIYNGVJhxWEtZ9qTQGj20F9PZ6yKfLy/2hG+6Ooktdkbw9
rrBT3Dl1u5f1F8Kx9wNi34Lz0e3VGTOoBn53Fj1IFTOrLAZbgWekK2QGkFxVmRHu
lqCawXUtUFjfn4Ojff3eJb2svOXZQgQ6RXjHO0vfOoR+c4HJq+7F19jfUjYKopKy
Pil076IFBo1dMczaujYaz3qrX5b59CNr3vsHZ5ExD68SHFSVSxVGgr+jZMAfg1p4
h+khYHh4hFpSvJr1z5Svu6K6An+qOdJwOgdOO6UHUYq6hsD2fqlxKs574tb9cgUy
QnoojZW7DYJweb4h2R0Loq3rd3PCHxpeJAtZ+2H/d2R6smNi1oF6jcdrI2vgfhgZ
PcPjB4Gi1QdbaJYiaq+oTVEiZAqliMFv3lTeCgZlZgQfAvFpVPg=
=aWBS
-----END PGP SIGNATURE-----

--nextPart1671669.vjXytAXkuU--



