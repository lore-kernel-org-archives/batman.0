Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Apr 2017 09:13:55 +0200
Message-ID: <2383073.8lvV2lGcs0@bentobox>
In-Reply-To: <1626579.VOjpoqf3Fa@prime>
References: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
 <1626579.VOjpoqf3Fa@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6756833.Nb86zZmoUK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
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
Cc: Xuebing Wang <xbing6@gmail.com>

--nextPart6756833.Nb86zZmoUK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 6. April 2017 09:04:50 CEST Simon Wunderlich wrote:
> Hello Xuebing,
> 
> it sounds like you have WiFi driver issues. There are some effects like key 
> cache corruption, deafness, and other effects known for the AR93xx series.

Correct, completely forgot about the deaf and 0xdeadbeef issues. There were 
also two workarounds for them [1,2] from Simon.

Kind regards,
	Sven

[1] https://patchwork.kernel.org/patch/9433619/
[2] https://patchwork.kernel.org/patch/9433621/

--nextPart6756833.Nb86zZmoUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAljl6rMACgkQXYcKB8Em
e0aA0w//cVKpdWY0l05QLMdhmaRJlD/jnlWUPTrTprLvlLqypH+Pug6hnybZ+BUZ
CKYNDFBVbstCo44W6PaimIejr3/5WBbPvsMU8Bu37EqG+TvOrW3J1Iqdbuo5qykJ
1oFBjkMDUSCnQbZHnp1cHxnhj5EuiruSAacg9LvAJs0B1SvVZjiqvD7QHgFOafzm
cgVBpxDJoYA93jaWyS6jdfivKhz2FIQWlbfUIOVg66v4qSil/Ka3tzdAcXai21MG
Pe/huWsm0evSPvK3fFyqwZytX+O/YltISn1Z8I43iLiNkn5932yWXM5CPfervJTF
kn15sWpWJW2jdWrFEpfIM65aa/LOV2Wh1L0kZsRMMOxykTw5CXZy+UdToxy/EQFC
0fddhv7JYHuKpWNO+hIzDRELfPE/GWOWs0pcFypK3NrjryJVyZYsXfxaaUwHm5TK
ZLrI32H87ZJBZbsQQCVgCAAstegfQFlawSdMNDQR0uYSEAqLFPa8OA5NqHNNjGqr
KIhkJ7mGHM3QtNm3xtICpyha4FVEO1rXh0O1yPGtrs4ef3QE+ILOOrn/x/TAAbMO
XukOllqBBAX0MBStnIw0PYbh2hR/D2u2NYw3XVeZiU5VQjmPwdcpnhnsBBRgwi8s
gtVcoyTIWCygNwIxzkRSPl9gNl2Q38v0fkne91joIbqWdqdMXu4=
=xmqx
-----END PGP SIGNATURE-----

--nextPart6756833.Nb86zZmoUK--

