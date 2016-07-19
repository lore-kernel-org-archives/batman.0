Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:26:34 +0800
Message-ID: <1549331.XNoTBgD0hV@voltaire>
In-Reply-To: <1468597173-25378-7-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-7-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1717498.Gbji7YIaLP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 07/18] batman-adv: Place kref_get for
	tt_local_entry near use
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

--nextPart1717498.Gbji7YIaLP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:22 Sven Eckelmann wrote:
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

Applied in revision af05c2a.

Thanks,
Marek

--nextPart1717498.Gbji7YIaLP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeQ6AAoJEFNVTo/uthzAk7MH/2arqOxb6ejh8NYGgmWboArv
aJRrgdUPWb8xpCfhUjBkX36sGYAwAB+GKHGJWUEnqizSn33gyCUoGZHtB8Q6+QOX
ll5hV+ffMeakf5ueWYA1qS4MVmRMkoY8V+r29swQh70ST5yUalNydxShs2b3GIe4
WRkrYr4PS89BN7v8oOWUU6EqXDsSW+GZoXdRufwvmsTGpnJ43rAqAOP9+uP4CA2C
E1Ps8MPwAl4fNfZ7lmpN91v0AXoRPYrKBNMbZU8LCmQ7JHcPUmuRDruVumovGHcs
Jgw0C1dfUXi7tcJ5We86fkmxyTucFCLWwrdgBvVqEYz079EhlZQCsYSSOZoA/ec=
=kcAG
-----END PGP SIGNATURE-----

--nextPart1717498.Gbji7YIaLP--

