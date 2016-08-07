Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 07 Aug 2016 18:06:47 +0200
Message-ID: <1489843.erd8EGXgK4@sven-edge>
In-Reply-To: <1470566059-3782-2-git-send-email-linus.luessing@c0d3.blue>
References: <1470566059-3782-1-git-send-email-linus.luessing@c0d3.blue>
 <1470566059-3782-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6600458.k8n848CA4F";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/2] batman-adv: Simple (re)broadcast
	avoidance
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

--nextPart6600458.k8n848CA4F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 7. August 2016 12:34:19 CEST Linus L=FCssing wrote:
> With this patch, (re)broadcasting on a specific interfaces is avoided:
>=20
> * No neighbor: There is no need to broadcast on an interface if there
>   is no node behind it.
>=20
> * Single neighbor is source: If there is just one neighbor on an
>   interface and if this neighbor is the one we actually got this
>   broadcast packet from, then we do not need to echo it back.
>=20
> * Single neighbor is originator: If there is just one neighbor on
>   an interface and if this neighbor is the originator of this
>   broadcast packet, then we do not need to echo it back.
>=20
> Goodies for BATMAN V:
>=20
> ("Upgrade your BATMAN IV network to V now to get these for free!")
>=20
> Thanks to the split of OGMv1 into two packet types, OGMv2 and ELP
> that is, we can now apply the same opitimizations stated above to OGMv2
> packets, too.

@Marek, can you change opitimizations -> optimizations. Thanks

>=20
> Furthermore, with BATMAN V, rebroadcasts can be reduced in certain
> multi interface cases, too, where BATMAN IV cannot. This is thanks to
> the removal of the "secondary interface originator" concept in BATMAN V.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven

--nextPart6600458.k8n848CA4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXp1yXAAoJEF2HCgfBJntGokcQALq0Vp4gYdPT9JSOT/RMt/iu
dFzRBomCvkfogWjHoUaw0lJOz9g6ZvrJmzC60PVFz54xun69s6pkFmh5Hq+YVb5R
mXr5Phu0Zca8DWQAkd/vM76tJly1XX3o+Gcekt6LwZjzaA2hQU1ru4L4pSKC+G2r
0CiQasFVlUIzCD51TLZdBWoqHAiOtbb2hb6o5FjNDWX0EfUPJnzoHXxjnkbALbZQ
qu69y7KzgY631ju4UyQOa5FnTmIDqSwUUX2cU5QqiYiVFvCp0Ky6R2E45eypwAPe
77Z1jGUSWlICL5htyDApBnvnRaji9Ofm3rjl2GdjdHLDc7RR+fvBWCvdVraTHalu
mfZh57Fh/ZnTS5SznFRWPxDlTAIDPFJpJ38BrPU0o75XxD5/7Ge6GQUxyqnhwEg3
Gr193Nc6uT3vDBlg+u+doE1YrzQ8S0Kv8/MVnp/f8G+zhw2BWhsbBRSDBNbAYL00
KkP8nSJEIvoOb22bWFC99drJiSi2x7+GLNNnymhZxJ3ghCvC3zwiCBR8oxnRZga1
pOoKLYDWMaMpsh7lJnN1dxPAISTl5qBPJRI3Gb7r7uaK5F/wV/qf7M6vLWuTGskM
JnX5aejUSMblgDjEKfvaC6nypnTWXUn17vS23hjKR4Pqy/B11GG//xhb57+vTehH
6WRjb48HMT8sw5LUBk40
=RKoA
-----END PGP SIGNATURE-----

--nextPart6600458.k8n848CA4F--

