Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 14 Dec 2013 17:43:12 +0800
Message-ID: <1430028.zLpfgZ7XZd@diderot>
In-Reply-To: <1386013113-25471-4-git-send-email-sw@simonwunderlich.de>
References: <1386013113-25471-1-git-send-email-sw@simonwunderlich.de>
 <1386013113-25471-4-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1497298.37hNSnlavf";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 4/4] batman-adv: fix size of
	batadv_bla_claim_dst
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart1497298.37hNSnlavf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 02 December 2013 20:38:33 Simon Wunderlich wrote:
> Since this is a mac address and always 48 bit, and we can assume that
> it is always aligned to 2-byte boundaries, add a pack(2) pragma.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  packet.h |    2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 6b5c638.

Thanks,
Marek

--nextPart1497298.37hNSnlavf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSrCgwAAoJEFNVTo/uthzAwHgH/3Xzqr/2m9DVtJnhJ1f/UMDg
BnfgI6ehDWPAb5gfip9GxROB4mMiskv84pIuGJfCFFY1/lx4fuMpRLgyUVhs6VBt
FNjQJxlCQkWVCpaB3jwN+XykSlZ8CUj02rVT4K21nl3xMDf6xj7u2M+YyTEUzi1T
XKtJ3Aver1xGtHTxW82XgPYeez4V0TWtPPFEzzBl/HuVlAtg51p+gQGlCZfHlX1h
VtF9FQCzQQ3IzrfZXFGhH3t0HFQyUaKDqXCR/jSlhO34wvQck/wRnlM/p6SE9paD
hVZtC7gX5txIRSbC9uQ5qqWzF1NxwQvG3ZH4A1aaYzO5GretfnQoj+9d5AqwB58=
=gbdz
-----END PGP SIGNATURE-----

--nextPart1497298.37hNSnlavf--

