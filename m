Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:19:49 +0800
Message-ID: <1794132.YjfXVH5hJf@voltaire>
In-Reply-To: <1457190564-11419-1-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4088858.DZKQYGTi4p";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/9] batman-adv: Check hard_iface refcnt
	before calling function
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

--nextPart4088858.DZKQYGTi4p
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:16 Sven Eckelmann wrote:
> The batadv_hardif_list list is checked in many situations and the items
> in this list are given to specialized functions to modify the routing
> behavior. At the moment each of these called functions has to check
> itself whether the received batadv_hard_iface has a refcount > 0 before
> it can increase the reference counter and use it in other objects.
> 
> This can easily lead to problems because it is not easily visible where
> all callers of a function got the batadv_hard_iface object from and
> whether they already hold a valid reference.
> 
> Checking the reference counter directly before calling a subfunction
> with a pointer from the batadv_hardif_list avoids this problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_iv_ogm.c | 11 +++++++++++
>  net/batman-adv/bat_v_ogm.c  | 14 +++++++++++++-
>  net/batman-adv/originator.c |  5 +++++
>  net/batman-adv/send.c       |  6 ++++++
>  4 files changed, 35 insertions(+), 1 deletion(-)

Applied in revision bd2dcf5.

Thanks,
Marek

--nextPart4088858.DZKQYGTi4p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+T2FAAoJEFNVTo/uthzACVQH/RvjC8+yP4zBn6P9YtQYE8GI
r+xAKm8OinGC5vFOA4Hwv0LQfpJS29Olg0IeEtYkmodW7f7ZOiVf4DiFtsANFKF/
3u3DkIutnTE7SXtNPr1I/ANpqox74iBmD/abjsNpwHtxxzXTGhneGggPRPR3j0E2
OL3POf/8YfuHPKl+q/647fcp8koxMydYgBz1PStdzgLxoqbssia9Ald7chXH5WuN
6E3OB1/Z6IdQbJUBX9o4Z+Ft5Wx1mpBgnYfrKRhdasTeR7mdgoCItRNhalLKtuXc
rCHRAimxvxz4JvKmQt5tu0LBSMfyaj+iYYzZWk4+92i56FFy0ttWmTXWRljtXaQ=
=yQuI
-----END PGP SIGNATURE-----

--nextPart4088858.DZKQYGTi4p--

