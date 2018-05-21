Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 May 2018 16:34:16 +0200
Message-ID: <8211925.JcgYpGFXDF@sven-edge>
In-Reply-To: <20180518014754.23644-8-mareklindner@neomailbox.ch>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-8-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9666721.k45vbQlQMa";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 7/7] batman-adv: ELP - add throughput
 meter test duration attribute
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart9666721.k45vbQlQMa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 18. Mai 2018 03:47:54 CEST Marek Lindner wrote:
> When the ELP throughput meter fallback kicks in to trigger
> a throughput meter measurement the test duration can be
> configured via this attribute.
> 
> Default tp test duration: 1000ms
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  Documentation/ABI/testing/sysfs-class-net-batman-adv | 7 +++++++

Please discuss this with Jiri [1].

Kind regards,
	Sven


[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-May/017814.html
--nextPart9666721.k45vbQlQMa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsC2OgACgkQXYcKB8Em
e0aoCxAAugI10xpZlEZoooaUhp6z48pR0vDZvdT3qgVcF+UY49QWzUonYSQFvJQL
PRgXrdRwqOBEMg2cXn7DSaSf63tie4t0loNXHzPtzkZeY81Kh/b3N+vcoA0gyhCb
yrjDky1oQk6F5yY4EX1AN6+kUVgWIjBx60zvTVEeF79pxJ1EKYWRUAaysWuACVj4
A/0tTrZTRbvuFt0hcnA4mPHzgYiK0xeBi6O0rQIxOjC6PNnTzb4GA82VAsAMz2li
UilvhBEtz8R6P4MebPq2zyDg/z3A6aG48Lzr2Em8UUr6onGbg4PIT6EaoMpNHoFl
JY3sFQxFGN/kaGbhW56xQvsPPNvn1CIEkkwUPPEf3Iq9JQfqoeDayaBg3cNoPJKM
5qJIz+I8H4dhRlXYb+HPIEO7jsjCFVbgi2ZT0N4Nn8CcND51jkLB9hipuTTHVU5M
vAyx1GQw65sUIYBPYR9EuNoueyGnIX6kR/wgLsbx6TFxW74DT30ySqdX4f9elJ+I
cWDRKltwkmiRAOIm/o55UtN0EUSz5vBaRbRTFNlVlQsPcjxOGP80DLcvnA9F5mgR
ef6mO/RlLMVYJdx/xS3x98nlIiJJs9/No/ZrEtQ03FPY3TRm39l2EAWMabpVC6Ca
drN9mEZvsIrbrexJMbSqj2IQ+h04Bx9PQQYcC69905TQkYJGDNI=
=fgNP
-----END PGP SIGNATURE-----

--nextPart9666721.k45vbQlQMa--



