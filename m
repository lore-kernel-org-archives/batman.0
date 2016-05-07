Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 07 May 2016 18:44:37 +0200
Message-ID: <1916326.J0HcRb74sF@sven-edge>
In-Reply-To: <572E1ADE.5040400@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <1884294.h0rzVsQuVd@sven-edge>
 <572E1ADE.5040400@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3476080.Tl6DQ64emz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: contact <contact@wifibot.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3476080.Tl6DQ64emz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 07 May 2016 18:42:06 contact wrote:
> it was the default version present in yesterday openwrt stable 15.05.1
> 
> in batman makefile i have :
> 
> include $(TOPDIR)/rules.mk
> 
> PKG_NAME:=batman-adv
> 
> PKG_VERSION:=2016.1
> PKG_RELEASE:=1
> PKG_MD5SUM:=8c8e449009b4d29512d26ee308960bb5

This doesn't say much (and you most likely meant openwrt-routing because 
openwrt itself doesn't provide batman-adv). But and Marek fixed a crash since 
yesterday. Not sure if it is related.

Kind regards,
	Sven
--nextPart3476080.Tl6DQ64emz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLht1AAoJEF2HCgfBJntGDXIQAMhwMy+gjp5wfVlz4uHIKPQP
qMInHH1QjXo73faH08tFfbxBFdoJYPAvrp/NEonSA3isiT4ybyjez/KJOjVJj2rR
VstZ96DpjrWchAhPQxbSTwtlpwGTCJ3Ynq+N1P3sZ4r7boLBJC+1N8LgSOvM5Soa
1Zd/97ftlJTWSfy9UJiTAUbQHuloqeFBCHEIGzlN/tVcJ4zLE1EqUMKixji5z58C
RWO/7UgDv3RaJetZV1251OhGjp1N/Gl+dgQEp10zLlyO8LXnvctuuBPnbXEOTslj
tdJluaHZnCh+619yhCyl4oDjGyTJFyOcL5N6CZBRlJ7P+IfWpPtdoJSW7E8QLhEp
DMUW2Q/Mp+fgPkBdBFCDG11Uo8CSq6cKYLPBcgguZL/5dnVXt5oIhJ/h9V5ew5mI
WKVt/cu0lEKnpt8dGHmNidIYsZuzyYemWBECWEMIMw/Q9ZlQYMXRh/KSCet0dsEy
YdtPlbvH6uHc7oGaelwPRUAaOBOuwj6V7ts5E6O+jxM5MjEmjqGXGVE6eoynDB8r
W2NU+PzvKG6VKqUO70PYWRpFjwo0lmctVYYbdsmN3B03UKrODVrvIKMZos1N1Myi
c7IyeAmq3++Fg0JBXQczyvWtiRVR9y0uD0ud2ebhQLa4MR8IUU/8DG2EjzMDTzG4
gTOREfVupT5OTjYYC7bE
=Uj97
-----END PGP SIGNATURE-----

--nextPart3476080.Tl6DQ64emz--

