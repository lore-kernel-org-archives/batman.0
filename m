Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Jul 2017 08:30:14 +0200
Message-ID: <5016212.eXVVEQaTKU@bentobox>
In-Reply-To: <20170618075928.27964-1-sven@narfation.org>
References: <20170618075928.27964-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3371115.3ChBtnttFg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove variable deprecated
 by skb_put_data
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

--nextPart3371115.3ChBtnttFg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 18. Juni 2017 09:59:28 CEST Sven Eckelmann wrote:
> skb_put_data makes it unnecessary to store the skb_put return value to copy
> some data to the packet. The returned pointer of skb_put_data should
> therefore not stored by functions which previously only used it to copy
> some data.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch belongs to the series
>  https://patchwork.open-mesh.org/project/b.a.t.m.a.n./list/?series=11
> It must not be squashed in the "batman-adv: introduce and use skb_put_data()"
> because it is already part of net-next and we must port the change in our
> patch in a separate pull request.

Applied as 6e94ef826db0 [1] to reduce the number of warnings from the daily 
build tests.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/6e94ef826db02e0f6b0fb286ee0c9ba86254bc2b
--nextPart3371115.3ChBtnttFg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAllch3YACgkQXYcKB8Em
e0YejBAAtqQCWaQqHD1KzUnQ5EHj4fwTM9qaiWokHVmHvgXMCGcx9ejY3/tzH6Ob
OrcU64eH7rvWbHp8hPBVVrBa6PD42kb6GYoISpWZKf1BcBem+kIDaGM4dBjY5Gxd
uM4BWzbEMP4Q9lV3T6r42/uwPkh35eOxAl52HTxGPAhLT4wnco3BV4rKI1EgUnbI
fiWtP5NYi2Xm2gPHuLRj0FQqUI1+oItBIv5O2mG8oVfzpXzgFSD5lxyfrQXcBXSY
tiTBc9/U1lkZ40XPyyaCRZM6W+5KNzhoQFjLRHXa7o48XBRuQx+x+M7SMVw2ZWzs
oDb/FXpTsg7s72CTnesW/g/3VuV7VyFuduCuRrjStQRyEOydiIxEhiAHMM1AvozE
mkID1t9rsy+SCWbBWTxmMIC0kkiaORpEhHqTZgwu9+PPNd7GcxVvIraCf382WriM
YZEupYi4CNBczTCCL7UlmBLlf6gZx2lTtd7LqMCNNJ9anPfPWgZ7EIlbDecMh1NR
VyRrvXobbiqQQqgAeUt7HnT0d/weIOxhFZlJJlnlKesrFIWFLXQeZTt9KM3TdufS
7TYMrTrmrgk9ctBwPyjbLC69L//spx6FeAm29xgrrQQbqtSmIQTxlmvbjKeiJJJf
OBV74GrLSLWr8w0fd/PC3mBbvtSDO7Uphw7Fp7Mq8bkHp9iTUGs=
=6dr2
-----END PGP SIGNATURE-----

--nextPart3371115.3ChBtnttFg--

