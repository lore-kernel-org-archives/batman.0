Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 19:17:41 +0800
Message-ID: <4054561.C0aWplkklE@voltaire>
In-Reply-To: <1462527819-11907-1-git-send-email-sven@narfation.org>
References: <1462527819-11907-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2525601.SFykCLCmY0";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: Avoid nullptr
	derefence in batadv_v_neigh_is_sob
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

--nextPart2525601.SFykCLCmY0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 06, 2016 11:43:38 Sven Eckelmann wrote:
> batadv_neigh_ifinfo_get can return NULL when it cannot find (even when only
> temporarily) anymore the neigh_ifinfo in the list neigh->ifinfo_list. This
> has to be checked to avoid kernel Oopses when the ifinfo is dereferenced.
> 
> This a situation which isn't expected but is already handled by functions
> like batadv_v_neigh_cmp. The same kind of warning is therefore used before
> the function returns without dereferencing the pointers.
> 
> Fixes: b05bbab5e1fc ("batman-adv: B.A.T.M.A.N. V - implement neighbor
> comparison API calls") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2: Add patch to reduce the reference counter of these functions
> 
>  net/batman-adv/bat_v.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied in revision 036aa7b.

Thanks,
Marek

--nextPart2525601.SFykCLCmY0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXLH1VAAoJEFNVTo/uthzALI0H/RGtNJv8E7yexKHo1zZesdVk
ZNFdZUsBsyiV0Gg2AUDN1S1bjsCqYbntMyJApUW1QhQCbtcwAy9DMaLaGLa+ap9v
a7GKhJThf7MF7h3dlNX+jzmBZfv44YBEhk/Y4HtJC9KuXLPn2EL3e6W/0s8sPIBK
bZw6jq7y6ZkMqNM3Pgo03S4Ux+wqmtiMctUkvBQlSw9PoPX+PPprxaqpb7Kg7/Jh
e4r/fZoZVbm9il2hbAt9YD0StpSxt4e0L5HUYYKwwvxn4SApPFtJRJjv3NI6rNcx
aD8aOmIWGQ8ni/xOHcbtdY72KreB6V7KrKef2hCRCgwBIpycCc1BTXnOipC2odg=
=YT5M
-----END PGP SIGNATURE-----

--nextPart2525601.SFykCLCmY0--

