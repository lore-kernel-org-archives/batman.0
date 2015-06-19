Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 22:08:58 +0800
Message-ID: <1893866.X6GAN1oWdJ@voltaire>
In-Reply-To: <1434646404-19291-4-git-send-email-sven@narfation.org>
References: <1434646404-19291-1-git-send-email-sven@narfation.org>
 <1434646404-19291-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4965531.DVKqFMuDlW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Add missing include for
	BUG_ON in MCAST
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


--nextPart4965531.DVKqFMuDlW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 18, 2015 18:53:22 Sven Eckelmann wrote:
> 7f220ed1f063 ("batman-adv: Fix potential synchronization issues in mcast
> tvlv handler") started to use BUG_ON but did not add the include for these
> functions.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/multicast.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision cfb1542.

Thanks,
Marek

--nextPart4965531.DVKqFMuDlW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVhCJ6AAoJEFNVTo/uthzAdawH/1ho3UkKgPx5ZJW4mw3tysIt
mG41IyFfPATwE2hNVhhksF80h8u42b/7ps0MpF5m+sWF9sey1+EW98nk7g94UgTh
H9a7LsRRY+PP3Jd8xfV3dgxMbGA3vjJkX8cBac6kgQn9COqEtdcciS15nc8H7fUm
a0eJ3jSU5R7g8IvjEBJhkkVN7+1sDRIIrD3lob1pD9fb1b5Y0TbNqNYKu7EckU+O
hPrelmVSyGOMbz70HIFNE0/R5NN60wKAhnOarq7c1R2iHQ8GhcC2rAn/PIXObyAn
4P28wA5sTf2UyX2fD7c4nH4TpHgcJoWuKFovTvSGKH1pVuwC2ixU53hY0TPVz6I=
=CfhK
-----END PGP SIGNATURE-----

--nextPart4965531.DVKqFMuDlW--

