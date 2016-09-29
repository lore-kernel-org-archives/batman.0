Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 29 Sep 2016 17:39:48 +0200
Message-ID: <2657137.uJCnlVSzAE@sven-edge>
In-Reply-To: <20160817210759.19357-2-linus.luessing@c0d3.blue>
References: <20160817210759.19357-1-linus.luessing@c0d3.blue>
 <20160817210759.19357-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1558270.KirH01uYoS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: fix race conditions
	on interface removal
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

--nextPart1558270.KirH01uYoS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Mittwoch, 17. August 2016 23:07:58 CEST Linus L=FCssing wrote:
> +		WARN_ONCE(hlist_fake(&forw_packet->bm_list),
> +			  "Oh oh... the kernel OOPs are on our tail now... Jim won't bail us =
out this time!\n");

Can you please add the hlist_fake function definitions to
compat-include/linux/list.h for Linux < 4.3.

Thanks,
	Sven
--nextPart1558270.KirH01uYoS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX7TXEAAoJEF2HCgfBJntGwgIP/j/KoGVRQlJjYe/AzO9e9tuh
dsBBIlQ3WDVkDiDNE06Ig0JmxSA99jXN1tLEkQ+t9M30CdEc9y4DhBI3+PtAIz3d
BO1zjtqOv33P2p1h6IeHRZ3AkMS93OruudAc95jvawdy12s73lIp4mYXtFR12e2e
A7noGRdaLqO9foCxv/YR3hzXThz0rmui4BQ0A9zrsRttV4VJwq7cNTmjOt5AnAyb
EY4sS0bxHHvL3ItYSWuKdFsmq47ussnT4w4JZO8E610G3Lg6J4HpgU9kftmxS6Nt
08keiyX1Nbd0+BWjqlX5lqb3scG0zQp6CsWYQdwNZaH74zyTD4qSOWzeFP5GuT+w
YaZc0xoARy7pHwJDK9XHftB/e83rVSrqfBp7u2WEZW+jy6qr+93e5AS4CunNpSlY
uEQ+ejrrK0KuRiNKo8nYjuNN0vArXx+HCyGWgiiyIla7hyHxPfMnIYeMFmNj6ph/
J5M6wYdyh6N4P0QRrpFFqMVI33ZaGp6umHjw+ECT2N8Ng/ke9aqAE2wJIjSFGLrQ
xd86I50sL3u+/LD5IuL94cubO/FviCph6DUOC6JqXZ7+aylRdVaPTAxe9N9Cp0x8
8KPPhf7Fl75B1Barn7AAdDWm2Fdqenm5HqLl/CyQiYEKBntdDRB0vlzf7gokdYuA
TflkSI0EnNQsiVs8Mshd
=IlSs
-----END PGP SIGNATURE-----

--nextPart1558270.KirH01uYoS--

