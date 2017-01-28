Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 28 Jan 2017 10:07:48 +0100
Message-ID: <2478762.JtaPp2H7Jj@sven-edge>
In-Reply-To: <20170128034050.GC4195@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20170128031311.GB4195@otheros> <20170128034050.GC4195@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2550961.V1uFWpkUae";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/4] batman-adv: Keep hard interface
	neighbor list sorted
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

--nextPart2550961.V1uFWpkUae
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 28. Januar 2017 04:40:50 CET Linus L=FCssing wrote:
[...]
> Ok, found bug.h is needed for WARN_ON() in the third patch. The
> device.h addition and err.h removal still leave me clueless
> though.

Looks like an copy + paste error in testhelpers/kernel_mappings.iwyu [1].
Your version was therefore correct and my change was incorrect.

Thanks for checking the headers and reporting the problem.

Kind regards,
	Sven

[1] https://git.open-mesh.org/build_test.git/commit/cc571792fca7a4d15def67d=
3359863828313e173
--nextPart2550961.V1uFWpkUae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliMX2QACgkQXYcKB8Em
e0Yy9Q//YJoecDI5Zm1OCCkqnAUaTzbNooXoLP1S+zHaSyODGu20jCIQpxZrIBVi
3429IeIIFQ6Fc2eY9OJB3Ugh39x3Z0ftauB5Z4xvXB/OVQVUQoaPYDUkgfT5+0Gt
3sxACyILBzu+ZWESzn3+cuvnbL7PN4SDeFi7mOYEGvfU4w6eTQSZEX/eZwQfojiv
q8Ss7wpV7j6U8ShfIzh9E+6I/M06i5VbaMkcmtpiRhKJ5OqO6MjUjvkdcng1eB/W
l+JrF+m5ZQVgu3j8KtcSLu/0nKwzWbWYdCttEJbEAQxrWDEVL38tBPcMmIDMw5ee
Wnkn6EmfBgOBnTke1G2cosA0ezAgrRSW23EUUt7lDzTF4s58DHAwa4DyIyyqTDkt
lzoMimhL5vVdMvqGuSykta1i1GC46COTONTVLDqeqPhwDHPj1yuxS3RqF4uYrvq8
6grpYKC/mtS5fkjWv/LfGPrYtQn3X4iRflhWPEbAZyNMeeGQU+wWxrY7k90xRc8b
53+yOcdjgoDp1GwHpeZX7BZx1FsC2udCHfWqwnyp+OE7P+pNCJeMDt3c1HqPmig9
ul1+Osm1t/2YNuynlrtcOXigHTK/yQYVSa/nH//EKG8fvuDoBE0Kkzi+9eTqdrhq
ZCP00ItSesIiHc13c8as4St4ra6MlQYf9aj2/HYKVsSVgcfB4X4=
=Whl8
-----END PGP SIGNATURE-----

--nextPart2550961.V1uFWpkUae--

