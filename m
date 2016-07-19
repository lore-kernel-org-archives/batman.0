Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:09:09 +0800
Message-ID: <1727579.XfLgkl9Q8D@voltaire>
In-Reply-To: <1468597173-25378-3-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2677094.SRWdZNaByF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 03/18] batman-adv: Place kref_get for
	tt_orig_list_entry near use
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

--nextPart2677094.SRWdZNaByF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:18 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/translation-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 6d4b516.

Thanks,
Marek

--nextPart2677094.SRWdZNaByF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeAlAAoJEFNVTo/uthzAISkIAJD6wUNUeFVgCo1kFNewcCD6
SGXjzHLB6f87+Ct9NPMJJrZ0Tmc/2AH0ctqqHyI74JMDmHgB0Aa0BvcDAHB9NEdZ
a7HKYrDkFXcrCbcK9bI5/IJI+xdnhMDkmzlgXyVbg4ChHraA0ihgQR8rkWn78fzI
rKnGLYK5SCt1mSvEBPxZFSi616ygeDoo/QAzZCtCdKJkvONOx63lYyDjTWoPMdAK
7YOoYe551clBntGxmxwTNvHDazCaTgRM3JCFDtAi1PCwY8Lvf+cvdIflAMj2LglU
LEBjaXAbjJWbaydpcRhFDdawZk69mJqQZKLWqrwRxVTfA4v/V6gA6eRcUKkIP3w=
=FkXW
-----END PGP SIGNATURE-----

--nextPart2677094.SRWdZNaByF--

