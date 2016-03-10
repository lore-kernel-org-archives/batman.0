Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 18:08:27 +0100
Message-ID: <10489234.ydKS6b2bn5@bentobox>
In-Reply-To: <1366235673-13763-2-git-send-email-linus.luessing@web.de>
References: <1366235673-13763-1-git-send-email-linus.luessing@web.de>
 <1366235673-13763-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1731788.memtTIaPIr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Refactor forward packet
	creation/destruction
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

--nextPart1731788.memtTIaPIr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 17 April 2013 23:54:33 Linus L=FCssing wrote:
> This patch abstracts the forward packet creation and destruction in t=
he
> functions batadv_forw_packet_alloc() and batadv_forw_packet_free().
>=20
> That way there is less complexity to wrap the head around when freein=
g a
> forward packet.
>=20
> For instance broadcast/ogm queue left counting will not need
> to be done with "manual" atomic_inc/dec calls anymore, which should
> greatly reduce the risk of having or reintroducing another
> queue-left-miscounting again.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---

It looks like this patch doesn't apply anymore. Can you please resent i=
t or
mark it correctly in patchwork [1].

Thanks,
        Sven

[1] https://patchwork.open-mesh.org/patch/2891/

--nextPart1731788.memtTIaPIr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4aoLAAoJEF2HCgfBJntGDrkP/08+w1gQJ8Mw5zwLXd/ZmlrZ
EOg5yfkcRrfyvrzWPZPmrOEcQDvHLYmeeY0R3GegpWb6VTfU4IdsJENndDnD9w09
esCqAIN2shDckPnlVlCsMlDVo5GLil0MAJMG3u4Fh5af9LadngfY38vHEcFHFTRm
RsUni4hUtuPgUuKvuz/LT+2lKxkNfD5D82Gun26hrhlJfe44S8Q+j4jJGWYKd4gF
hEUPHknQLf98x3Nd8T0Sgl2rOoFEP+coetHvOuIwADQlpNob8njfiqnKD7VaTVKD
QG3mj8TSEZq7DuABJPZk+7Rz8TWQ/oxgGYdLr9nW1D+PWLc1bMAllNPwlntltycu
b/bgKcK9I3teUQc7TIyUFmqq2K82C8xqfkmClKGZCzKyxPDeC4JSJ8chKjgOL+qd
KYvYnHShcOvMKBOArqHmNqMFBk+Q6HdIkEDP5+ldvlgHmO73Zte4j+9Hy/26ni7C
4LNWYxmwyEqmOFxu3aPt8dmBwMEDzJ7bLzqK0z8KATrntfYk6+hL9sJ8JbLEOkL3
vHa8PFC+Pz2ECM35EGF7QbbWz3GSEB4g4l/EnIt7EFQAms8NEE6eoz3/nRql4HUD
JY5yn5xoEpd7BA0BDl2ut5TEGzgM7zP9U9g90U8YncBXlArPKTs36r5AZxEqwxWY
0zhYVYUcHo41aq0b4/d6
=7QNv
-----END PGP SIGNATURE-----

--nextPart1731788.memtTIaPIr--

