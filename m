Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 11:34:52 +0800
Message-ID: <1454619.2gVXbJ0sFs@voltaire>
In-Reply-To: <1429288461-26260-2-git-send-email-sven@narfation.org>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
 <1429288461-26260-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4965419.XED8Y2J4ST";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 2/6] batman-adv: replace strnicmp
	with strncasecmp
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


--nextPart4965419.XED8Y2J4ST
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 18:34:17 Sven Eckelmann wrote:
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> The kernel used to contain two functions for length-delimited,
> case-insensitive string comparison, strnicmp with correct semantics and
> a slightly buggy strncasecmp.  The latter is the POSIX name, so strnicmp
> was renamed to strncasecmp, and strnicmp made into a wrapper for the new
> strncasecmp to avoid breaking existing users.
> 
> To allow the compat wrapper strnicmp to be removed at some point in the
> future, and to avoid the extra indirection cost, do
> s/strnicmp/strncasecmp/g.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  gateway_common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied in revision 5ba0a63.

Thanks,
Marek

--nextPart4965419.XED8Y2J4ST
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNHPcAAoJEFNVTo/uthzAELAIAIGLtG+YlNbv5/42ObOutHir
JLVuNwl08xgjFP3nxfEqWwFW7JOmuJvUVg3xTN1JQ1HjaLevoMDH1yQ+qrvD4AbD
jTKd0k78SVf4W4k0Mhq/DMGZdcZMGkje80JtFwLmEnLtp9CvlMshbpjHdBEs1Nff
0vT7pq9TCOLXKamKF/dn7gUUD2+OlWSHjKX/CfwogYjJXXPF2B1MnIyeeEhwxsEq
98cRj7zx6x48Unq4k+VIvqlldS1uhnrbE/sN7suAsjibAPJoWBRPbugO9lRVqzb0
CJVidEd1SCpE2t1C144Q0eGO+j6SWSHarG+CS8eKCryZ8sO05Atpt+f3OJqKsUw=
=fzQZ
-----END PGP SIGNATURE-----

--nextPart4965419.XED8Y2J4ST--

