Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:09:18 +0800
Message-ID: <1644748.Q2bq021Rvb@voltaire>
In-Reply-To: <1458474055-9857-1-git-send-email-sven@narfation.org>
References: <1458474055-9857-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3560495.UEZ8KB1JRB";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: Update compatible
	kernel version number
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

--nextPart3560495.UEZ8KB1JRB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 20, 2016 12:40:55 Sven Eckelmann wrote:
> batman-adv currently only builds against official kernels >= 3.2. Older
> kernels (>= 2.6.29) have only incomplete compat(-include) support which
> will not be extended anymore.
> 
> The next release will also share mostly the same code as kernel 4.6 and
> thus by definition is compatible with Linux 4.6.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  README.external | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 15c5834.

Thanks,
Marek

--nextPart3560495.UEZ8KB1JRB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+TsOAAoJEFNVTo/uthzAKgsH/0iKpRq2Jio6Dv/nBMZqmnoL
mBo0sFzMfN5zAWW9MQ8IOtdwI9i3kGvB5ovZp7M456y94tM2r5hYToSQIAYzsaBG
G2/aUHxYwXalrZgoTKt2q/mWyPtxfhwiS8zvZciKcFEXfXHPxmNLsAocUUhwyYtG
cb8q0d7PXGInm6x6CcIv/tHaDeHTrzN1aJ6+/8+evLQsdjoC4IOCHSGEvGvLawnc
fyMR4cNqw+WgIzuqPkcVHrSbGkJZrE84pHzZdsaktUOKc25EUSDwgUeS7a8WziUW
ceDQbm7q3Emvv6CQYaMcDbjXZVZr7zuJ7ZUl/C5KRcXDarAV3YliUHFzp8Ehc1g=
=3EH8
-----END PGP SIGNATURE-----

--nextPart3560495.UEZ8KB1JRB--

