Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 16:32:49 +0800
Message-ID: <2829424.dRhlWCMSPh@voltaire>
In-Reply-To: <1466445210-17616-1-git-send-email-sven@narfation.org>
References: <1466445210-17616-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2775966.sGigunlhA3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2 1/4] batman-adv: Free tp_meter
	ack skb when it was not consumed
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

--nextPart2775966.sGigunlhA3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, June 20, 2016 19:53:27 Sven Eckelmann wrote:
> batadv_send_skb_to_orig can return -1 to signal that the skb was not
> consumed. tp_meter has then to free the skb to avoid a memory leak.
> 
> Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - rebased on current master
>  - added patch to a common set of related patches
> 
>  net/batman-adv/tp_meter.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied in revision ae49875.

Thanks,
Marek

--nextPart2775966.sGigunlhA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe3CxAAoJEFNVTo/uthzAldYIAKFeH2g5L82I6E6apvtoxWNF
qmmVZVuDhD/WLAmI8iL+iSH+0gbaEbflrjxFaIg4T071FFsYgTry/UNdxvhBpx5a
XU3rKcETaeqXOiQiD7cAijMcUBvVEEWpuE888cYW6fwy+7vLzMTAb0UbxJMpbXAk
LVCmYiaYMaWFalHOn4E+5MpwROaGwZ3FwWbC/Rjm5UZA8xwy6xMZJogwPOCuBisY
3XP1bCup7y7/hdK0MDkOqVSmdnrGmfo3yx3usM9+e1zJZfZsn6H+FkrLD1TEFAex
t6LTgYbmaExMoyq/ynOaHJ51bWZD6J0GEDg8fw09vtIXPKoeOQReHQfAq9d5/ZM=
=+X/v
-----END PGP SIGNATURE-----

--nextPart2775966.sGigunlhA3--

