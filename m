Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 01 Mar 2015 18:22:23 +0800
Message-ID: <1677630.xVWRchog9u@voltaire>
In-Reply-To: <1425142217-18966-2-git-send-email-mareklindner@neomailbox.ch>
References: <1425142217-18966-1-git-send-email-mareklindner@neomailbox.ch>
 <1425142217-18966-2-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2210538.WbGlSR6d9e";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: add bat_neigh_free API
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
Cc: Antonio Quartulli <antonio@open-mesh.com>


--nextPart2210538.WbGlSR6d9e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, March 01, 2015 00:50:17 Marek Lindner wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> This API has to be used to let any routing protocol free
> neighbor specific allocated resources
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  originator.c | 6 ++++++
>  types.h      | 4 ++++
>  2 files changed, 10 insertions(+)

Applied in revision 956e12a.

Thanks,
Marek

--nextPart2210538.WbGlSR6d9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU8uhfAAoJEFNVTo/uthzAV5UH/RA58azaz+XljlW9/n48QLUV
25S8/jNRGfTx0YHQ/u6FQMiDA0K71smeXIz7wt/feVoGc/T54dKsiEjNVvhH+o3G
FlbvssGNPx5DMG8YNj4imEzDwYlgT7gqzyE2pvZGvCdlfDcZE605U/D6nGw9PWJa
MAIFv/Ub1HXpmJ5p/L6Yt6rYzgcS2OUE0HRBPxP3MRQQqO+o60Zn5X1uEz8hBXs/
KBsl65eP2zxxStAfPd+EMZmKvzNvoZjarzmy1AoXmZmaPhOITF8kx9yfiVOTVl5S
n3NY0UTNrMkNeG7fc0T7Ctpfp0MPgMxwoHKHquQv8F2p0PArDJ2XBaVCy+H2DaQ=
=aLvH
-----END PGP SIGNATURE-----

--nextPart2210538.WbGlSR6d9e--

