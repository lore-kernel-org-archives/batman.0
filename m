Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:40:03 +0200
Message-ID: <10941458.vKKeqiOf2h@bentobox>
In-Reply-To: <1470514996-32044-1-git-send-email-linus.luessing@c0d3.blue>
References: <1470514996-32044-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4150522.2ydUfDb9T3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v3,
	1/2] batman-adv: Remove unnecessary lockdep in
	batadv_mcast_mla_list_free
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4150522.2ydUfDb9T3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 22:23:15 CEST Linus L=FCssing wrote:
> batadv_mcast_mla_list_free() just frees some leftovers of a local feast
> in batadv_mcast_mla_update(). No lockdep needed as it has nothing to do
> with bat_priv->mcast.mla_list.
>=20
> Fixes: 5b95c427d187 ("batman-adv: Annotate deleting functions with extern=
al
> lock via lockdep") Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3=
=2Eblue>
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> ---
>=20
> Changes in v3:
> * none
>=20
> Changes in v2:
> * none
>=20
>  net/batman-adv/multicast.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied in 0ef2a812dc3e9394d1b35f73a250f73a5214b134 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/0ef2a812dc3e9394d1b35f7=
3a250f73a5214b134

--nextPart4150522.2ydUfDb9T3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBiYzAAoJEF2HCgfBJntGSnoP/1wFEQf2qWZ65zruupn3R4kw
ZnNI9FY4SPv8hXyBYsttJvptePA4CAdeEE4HA6YL9YlFCzARWMFADOEvEBL57giJ
lyuW3W+9VlZ2+aepLn5RxXXnFaYXfifaenbiABW6YWF5VrPmUpAa92B8z0II9TTO
1V4HIDsm0jQ6xDl+8qCE+jEB3InM0tjAR+8zVHBzmgwGZDHsAXJx2KSYdvb21ADO
Jux8fwqctmZ235lLTry0RqYwnBU3bcb10RB59PWA6A1xA5A/u6tlEOyEEI4asX8J
IlP3QZw2NkdIB7YRnjy2nqkBR53Ml4k1+Q17JXe/cPAqljD2Z8Sz2i9vDAnXubza
q69StzLlRJOJ5n3+6OhXLOFd9J3xQYM4E+3zzp9N16hEMaLCUCUevZb221wmQs8Q
0geZbU48iTY2o2HIDialR9Jw/NPLsLTZ2hLTOM+bOLLjX/1O4bawpPy75iRaJXa3
WnZmv/qHyWk8PvqmC79qeH374xLXGP2u1eXGu1oaXrealFdax4PaT6M7vwzdyTZT
FNKzhWpoJFs+Lq2+5RAY6KHMeYaWY9nZDitxgP2R7F/FlTHYASYx3I3s7UASO1gq
6JgdTIuMoRNwPuCbTcHXrCzfH3wnlHu2QiPfTbPcykMciNQjmSANCeParhBdWHsv
MIawgejr7xqmp3QiIqet
=cppx
-----END PGP SIGNATURE-----

--nextPart4150522.2ydUfDb9T3--

