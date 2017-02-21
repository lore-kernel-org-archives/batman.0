Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Feb 2017 18:27:29 +0100
Message-ID: <2747006.Pa2tuinOe8@bentobox>
In-Reply-To: <20170213194431.24075-1-linus.luessing@c0d3.blue>
References: <20170213194431.24075-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9725692.62bTmEj2WV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix transmission of
	final, 16th fragment
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

--nextPart9725692.62bTmEj2WV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 13. Februar 2017 20:44:31 CET Linus L=FCssing wrote:
> Trying to split and transmit a unicast packet in 16 parts will fail for
> the final fragment: After having sent the 15th one with a frag_packet.no
> index of 14, we will increase the the index to 15 - and return with an
> error code immediately, even though one more fragment is due for
> transmission and allowed.
>=20
> Fixing this issue by moving the check before incrementing the index.
>=20
> While at it, adding an unlikely(), because the check is actually more of
> an assertion.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>

Applied in 464eff3b1768ff190466a453a57ac140ea5cb756 [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/464eff3b1768ff190466a45=
3a57ac140ea5cb756
--nextPart9725692.62bTmEj2WV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliseIEACgkQXYcKB8Em
e0ZllRAAjv6SsKOd3uUBFZAsqrQEi52xptchkA/TKd95bO30wGxZHRlTr1RAVPjd
JY8zJtLUwXTfb6rwDtz89jxmPIabdu2/Ug2ZQQ0LCpNHG8/hURqtge0IXKEiqOjj
AKneFvVg919wpMRu5cItsNiuxcUlVbpTKmozqlF7gzdBr0r/+z2x6q6z6O4TKzkz
Y9VNVWwHXBwj/sqxBuc3x50alJKCcjBNp1oAvZz2XIH/W6Ec/swVB1lltMsJZ0Z1
eilmiAa7h0wfGIEOcogOh+k3kxAq+6q0OOhE0cYFoOsBf8YnXXxrx8H0iTdhBh7L
U3jSFbyrtRXB9SXURmWJdg856Pg2TIU/PnGvxh2Qjkb1GiwLgyeWmATuRIC69h/K
OHDKAzJHacOLYCYRjaeoUcItB9fXoxLxnrvEbxCj/aJjF7R98t5wIY4WvzfrXd1k
JuWlSxIHLC48UC0phYwx/hp+a4JAs/ElVHwJRmSCCQnF1/i2q3eEOaEkNkm+1rnY
pwFM9hnL4M1amYWvd9CwaGeEdHil2Ze7hSH3DUawntP2EpQWVs2VPU/BdU6LKdGE
2GW3EgUCFtKnWDHfmBAO8AgicjLzszX/U6sIBrrCwtQLbGh1ye3mgJR9WpE8JhMz
E5ODjqRdXqxgwT2zjrYHm/0YAoQ+DqbDCWptrDXBtzndd9xX4sY=
=FW4k
-----END PGP SIGNATURE-----

--nextPart9725692.62bTmEj2WV--

