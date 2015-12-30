Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 30 Dec 2015 20:00:12 +0800
Message-ID: <3018788.DBHg4t7daR@voltaire>
In-Reply-To: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
References: <1448901241-30844-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3666510.ZH31JAS0VL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix lockdep splat when
	doing mcast_free
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart3666510.ZH31JAS0VL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 30, 2015 17:34:01 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> While testing, we got something like this:
> 
> WARNING: CPU: 0 PID: 238 at net/batman-adv/multicast.c:142
> batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]() [...]
> Call Trace:
> [<ffffffff815fc597>] dump_stack+0x4b/0x64
> [<ffffffff810b34dc>] warn_slowpath_common+0xbc/0x120
> [<ffffffffa0024ec5>] ? batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]
> [<ffffffff810b3705>] warn_slowpath_null+0x15/0x20
> [<ffffffffa0024ec5>] batadv_mcast_mla_tt_retract+0x94/0x205 [batman_adv]
> [<ffffffffa00273fe>] batadv_mcast_free+0x36/0x39 [batman_adv]
> [<ffffffffa0020c77>] batadv_mesh_free+0x7d/0x13f [batman_adv]
> [<ffffffffa0036a6b>] batadv_softif_free+0x15/0x25 [batman_adv]
> [...]
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCH:
>  * rebase on maint, add actual splat
> ---
>  net/batman-adv/multicast.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 025b743.

Thanks,
Marek

--nextPart3666510.ZH31JAS0VL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWg8dMAAoJEFNVTo/uthzAh0sH/R75KWK9erwtkvMOlm+THUjK
2NFtVPA3w0VmqC+sQibESwHBuUuj5LNsESVh6vjZu7EebnCoYs/33IGwZH+bJFHV
QklTTp+mCBvbKegM1lt06b9imL5xIs7wJMODpy/xp4lIvv8uMuV7tRqA3+ii0cu7
2Jc1ULmuuEOiY8KbkXOa80t3m0lclOwaACYXdP/N9g8ZK0C38/ifIdhE0MQ8kIYM
UnV8dq1sVfezjzbw1j/CUz3rfVdwSDG6G5asbABmQhdVZac7SAny/4Hq8fxIdJ2K
XOvlQGlY6uP2uhrKq15p/Ub6zA6Rox2x7JGUWTKTgSRsiJVGl+4CxLCbemtTxb4=
=QgMt
-----END PGP SIGNATURE-----

--nextPart3666510.ZH31JAS0VL--

