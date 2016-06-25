Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 25 Jun 2016 17:46:47 +0200
Message-ID: <1666680.Y9BoZfK7nu@sven-edge>
In-Reply-To: <1466865846-32621-1-git-send-email-sven@narfation.org>
References: <1466865846-32621-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart63778614.Q0UCzesp2C";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: use kmem_cache for
	translation table
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

--nextPart63778614.Q0UCzesp2C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday 25 June 2016 16:44:06 Sven Eckelmann wrote:
> The translation table (global, local) is usually the part of batman-a=
dv
> which has the most dynamical allocated objects. Most of them
> (tt_local_entry, tt_global_entry, tt_orig_list_entry, tt_change_node,=

> tt_req_node, tt_roam_node) are equally sized. So it makes sense to ha=
ve
> them allocated from a kmem_cache for each type.
>=20
> This approach allowed a small wireless router (TP-Link TL-841NDv8; SL=
UB
> allocator) to store 34% more translation table entries compared to th=
e
> current implementation.
>=20
> [1] https://open-mesh.org/projects/batman-adv/wiki/Kmalloc-kmem-cache=
=2Dtests
>=20
> Reported-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Here is the changelog (since the RFC):

v2:
 - use kmem_cache_zalloc instead of kmem_cache_alloc + memset as
   suggested by Linus
 - add cache batadv_tt_change_cache, batadv_tt_req_cache,
   batadv_tt_roam_cache
 - Added Reported-by
 - rewrote commit message
 - summarize+link the results from Linus' tests

Kind regards,
=09Sven
--nextPart63778614.Q0UCzesp2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXbqdnAAoJEF2HCgfBJntGWNAQAIg++0fwbctv7uGKIRvlIfs1
KCInFAnWjpzZkMhiNAP9LICq4IXmAsCs6IrSoL+3cF8utscNRRgCWTWERtbbzVdw
OeMf62ZbOqQ8V0zmi2vPAY0gYIzxWbDhpGsVSYrGa5N3zYuaEhrYtvNHy5uVizev
MqkuYEW8iBKEvmrVfURgQQHgd3Ld2209ddtMvMohlpzRc3IPJrZ5arLs+fNudMRs
/8ePv7ezqh/b070e18f4s5Yh6rrDk6CLGr+y0pOVJR2JiawBFLvvDorBWBGM3o3E
JoVtqRGKmxkkfiknstCsjyWEVpKADKXtNsa1YNPdDReTun+Fqr70GjGxni3t8Md8
7iMKwmD7yWxSJ2JcNCUOaNitcusHmYBebGXLn8o2FDNKQMtK4/5WY8R1b6vX34+5
Q1XE64O8LRPdxJwIr7kaOVa1hXZZLdbld3Yjuvaiqh5ouGNiVQ/JkL6FP9OJTQxt
C1KL/+qFNrdy48x+Yz9kecltdfEAvxtXcOcqTmusH7ycPXAIAUVk6uH/O2HV20U4
MW48qNWvXGjhQxOYZSJtfvh9BqrKBqYyQT7FXnCwqz9nBmdF9UDlKSmuNUGB5tbg
FGUpAIKopIUyAVQnQp8zxH1mus77e54cCcrpUcJCdtsrNx+GOUUZm2JMruPu9XM4
Unb//weAklOj9ywTv2mA
=Dw2y
-----END PGP SIGNATURE-----

--nextPart63778614.Q0UCzesp2C--

