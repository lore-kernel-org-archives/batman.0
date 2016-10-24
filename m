Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 24 Oct 2016 12:10:03 +0200
Message-ID: <50942836.NYZ1al9d9y@prime>
In-Reply-To: <1470495863-22251-1-git-send-email-sven@narfation.org>
References: <1470495863-22251-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6208484.U3vJlx4aq2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 1/3] batman-adv: Disallow mcast src
	address for data frames
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

--nextPart6208484.U3vJlx4aq2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 6, 2016 5:04:21 PM CEST Sven Eckelmann wrote:
> The routing checks are validating the source mac address of the outer
> ethernet header. They reject every source mac address which is a broadcast
> address. But they also have to reject and multicast mac addresses.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied this series in 3868d9b..bca103c.

Thanks,
     Simon
--nextPart6208484.U3vJlx4aq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYDd37AAoJEKEr45hCkp6hzngQANE9tJoTFXiuYV5SVQ2IMeXg
Uloy6z93kgs3mSk0MN317Vx4DK0M64MdonOE8wOzs4NT5g7gV560cS8pQttTDTwC
uFetLkRupGuyOVWGTqxgxHcSR3HNFQNFHxGgrTD1npnE338+55+CpmhNaO9nUNp1
YIHJTHcy/uUQdwutEemAHq13ynVLbqEM33/dPUEjlNYBtjIlX283WWzcpPhax/wK
b7JB8E0pXX5Za2xAXIAyZ5pTw5QFTELPYJuIokaQpROH3RzZzHlaqp9l/WaHVNQY
2RiJOT9L7Vf6KTPH5StrLHJkpp7JIPFR/c1+M/l0Bi9sYUci2QOKu7ev0Isiv8Ku
g90KB1gT3LZl7zVJk8EeLSeL3snPx4IFjPVrk8IpwyMZ1m254i0KzH4yTaLLR0sc
e6MSnnRoSiuavvZ9bP1D6QMs4ga96rM+Jy+/MAzLwf5ShLbiLv+i5Rj+qhQtEvQe
eD3cfMbJsYbt1gp3FTfDQe8MAqq5bzS0zM20NPE6a1fhpHBoNfFEMrnsaa4cCH5o
jo39tmjoCbbhrw0hZYWcFxWpo6ZQbbzGLXUjLBRL+YW/MaFaOStNkKhTjzRjtSG8
IRbhPeVcpzTvzORrYnnxwyzODIY5J2jlBtvQE9HJS6RjgWzhdpcj5OoPr1tBTjSI
fzTTGAoaRrBpULWzhZmP
=d8/z
-----END PGP SIGNATURE-----

--nextPart6208484.U3vJlx4aq2--

