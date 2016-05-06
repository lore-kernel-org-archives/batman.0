Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 19:20:16 +0800
Message-ID: <27109499.monHK1hDHQ@voltaire>
In-Reply-To: <1462527819-11907-2-git-send-email-sven@narfation.org>
References: <1462527819-11907-1-git-send-email-sven@narfation.org>
 <1462527819-11907-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1552197.iCzFAAScBs";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Fix refcnt leak in
	batadv_v_*
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

--nextPart1552197.iCzFAAScBs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 06, 2016 11:43:39 Sven Eckelmann wrote:
> The functions batadv_neigh_ifinfo_get increase the reference counter of the
> batadv_neigh_ifinfo. These have to be reduced again when the reference is
> not used anymore to correctly free the objects.
> 
> Fixes: b05bbab5e1fc ("batman-adv: B.A.T.M.A.N. V - implement neighbor
> comparison API calls") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2: Add patch to reduce the reference counter of these functions
> 
>  net/batman-adv/bat_v.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)

Applied in revision 650d41d.

Thanks,
Marek

--nextPart1552197.iCzFAAScBs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXLH3wAAoJEFNVTo/uthzAb7wIAJWOb1HnJjMaiXyxLblny4fO
uqleRKcGEmxwGpRaTKH0mK5evyDCMiY9RJCtNU5zhk3kLJF1o7/6VUQiGS7DgA4+
9cgsmVoro5yW7wbbK5xQoYupDv1nD33gVhpuXAZtw70iaC4THdaxHV//04DVaJeD
ZEamoQWo4eqicVctdKVPgCmtYFC9vc/eJfnLrZLjZMQhky0o9V7exzSiyCMVboXa
XaNsM09zQ0EGdmL3848u9MI89YNDX7O0O7KeUpgKjduEwQsKJk+tQeKZ3QY0n+bx
AswLhhXRFWpn+C/x/lnZAy06SfMltdnUV2yGCh89kHn749dTZxMx4orsX0oD0p4=
=2hmk
-----END PGP SIGNATURE-----

--nextPart1552197.iCzFAAScBs--

