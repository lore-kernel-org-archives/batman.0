Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 May 2018 21:12:29 +0200
Message-ID: <24225361.zzK6HZQpid@sven-edge>
In-Reply-To: <20180511190244.18204-1-a@unstable.cc>
References: <20180511190244.18204-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1644789.7h1XnVlCVF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't implement
 skb_postpush_rcsum() for linux >=4.4.47
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1644789.7h1XnVlCVF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 11. Mai 2018 21:02:44 CEST Antonio Quartulli wrote:
> skb_postpush_rcsum() has been implemented in 4.4.47 therefore
> our compat code has to be changed to prevent this function to
> be implemented when using those kernels.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  compat-include/linux/skbuff.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in b4693d107e08 [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/b4693d107e0869bf11956fd2d3be4fd0a8671b46
--nextPart1644789.7h1XnVlCVF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr16x0ACgkQXYcKB8Em
e0ad8A//daqY48G3R6I194+UqVWfJTGay+8nepfcGpfhxBlrjuEhwjRQjKaDkefY
FyLGhyzhN95QXwDOIn9k7yaKA+C3wvkKoHRInwjlReH51lUOcMnYw+QJWybOe/g7
1yKGRpaaFGhvYxENqQhsa646WwWrEe3A3mwMWE77eTVfwe1unmzmrmnpeB7ev29R
b/synBoiel9+xO8unNaiHsKlH4jZXCBUwogEY1nHiqAcZD/3sRTyyaTB9SOhkg3R
6xbJz4C05Okpxz9rNFUk0VdR3qyqmOzSz33gdym9T2zu8AgZNf4u9Abj0YF7WfR1
mXzs/YVQlBg1ukJcjCk/DR6aHHmZHLtC2cTPFREkVFsGDHlpspDyynQza6xTpuPr
hBQqp2yhUHXTcMRmUFRkwrngbD+5p7AS/PXLkJcY89KfWwFE8x0/9ofDd7zSgyNt
zWUmtQ1J2Sxy4gmyMY3C9psIqJIvVr62x8WC3xnlHMKpUSASbArsrNfbByzDjPKi
IdA5Y+mwi1owLtc07kwFAq476uIKynlpo1eJw4+JFT1nsw636T4HXOXWb7xVy/53
siMNemF4Btro9d8VcWa55UokFR1wykcKr3cKb+Lnks1CExGhgAB1u9oH5L4t9u9N
FrMtcOKtyx9X4sk6SEFePGJzi9curWPi52AMtoNb4tcZVWL6m/M=
=qwXE
-----END PGP SIGNATURE-----

--nextPart1644789.7h1XnVlCVF--



