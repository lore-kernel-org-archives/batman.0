Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 23 Oct 2017 17:21:16 +0200
Message-ID: <2426942.o1Iv1Lg3Ss@prime>
In-Reply-To: <20171021094546.8299-1-sven@narfation.org>
References: <20171021094546.8299-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4821622.niHM4j1QSe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use inline kernel-doc for
 uapi constants
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

--nextPart4821622.niHM4j1QSe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, October 21, 2017 11:45:46 AM CEST Sven Eckelmann wrote:
> The enums of constants for netlink tends to become rather large over time.
> Documenting them is easier when the kernel-doc is actually next to constant
> and not in a different block above the enum.
> 
> Also inline kernel-doc allows multi-paragraph description. This could be
> required to better document the netlink command types and the expected
> return values.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Thanks Sven, I think this really improves readability. Applied in commit 
dcad23d0.

Thank you,
     Simon
--nextPart4821622.niHM4j1QSe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlnuCOwACgkQoSvjmEKS
nqEUPhAA1YXuU8KFnaijhG2QuOeJgmBJ5pt4wkrShKvJBS0cv+/2OYszuL87VK5n
7atr5ZsNo3yxCkMdp5n1E62IXtS+AhR+hAw/NzS8BGXkA/XjcemEEOmhq/F/d8s5
A+IRq5fI8D0K1G/6vtFxONNXfoAXawnTfXfBh3Azw4TuX0Lc9Pr2iMGDGN/hAudm
ndCurpAhS2nXJxdhTsws+lc462mukQ7y5DATIdk5llDZVEOZLtifvYmpt5WyFkCq
Bkt8qHs7NtrbFMj+Dmh045rkKO4RmB23U5I/Yb2Ac+uCb419dUMFJpnOAaCNGNhL
w4X+BbuuZQzVR6SQd+pca/PL6vfP4PV7KBeYApXAbGK86yNNbsGLe9yagn+T28eH
KS6zBysdUiXlfo8OHhY/0/yYHW5rr4aycHi8Wdg1E6VYdpUYrs/vlfYpxeLTXQhD
5//e61yg7KJSncch/qXshfA2uVPP7iUshW5gl54293WQ8gMmW9rDHO4WTUlTKCL+
3XJGbA3stg4CLuKYSVGY1df4l1PTEMmhN8lloV1o1CPnwdTrXxbv0Hkr1ILf+G7v
2cFBNu62Xj8gRgx/mHNiBYMhfTG90/RkRvKZ1PyuPteEYUGEkda77jWbTYBJiDPz
am0Xj/+QV9x5oeVxRS7RJiOXSQ4foVxZERVEQOVd7ZSFr3r4iUM=
=4NI/
-----END PGP SIGNATURE-----

--nextPart4821622.niHM4j1QSe--

