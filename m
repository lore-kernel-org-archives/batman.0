Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 29 Dec 2014 21:54:09 +0800
Message-ID: <1976303.uAsSFb4M1v@diderot>
In-Reply-To: <1417438784-20880-1-git-send-email-sven@narfation.org>
References: <1417438784-20880-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1872230.r7EigQzrVZ";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Unify fragment size
	calculation
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
Cc: 'Martin =?ISO-8859-1?Q?Hundeb=F8ll=27?= <martin@hundeboll.net>, Sven Eckelmann <sven@narfation.org>


--nextPart1872230.r7EigQzrVZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 01 December 2014 13:59:44 Sven Eckelmann wrote:
> The fragmentation code was replaced in
> 9b3eab61754d74a93c9840c296013fe3b4a1b606 ("batman-adv: Receive fragmented
> packets and merge") by an implementation which can handle up to 16
> fragments of a packet. The packet is prepared for the split in fragments by
> the function batadv_frag_send_packet and the actual split is done by
> batadv_frag_create.
> 
> Both functions calculate the size of a fragment themself. But their
> calculation differs because batadv_frag_send_packet also subtracts
> ETH_HLEN. Therefore, the check in batadv_frag_send_packet if a full
> fragment can be created may return true even when batadv_frag_create cannot
> create a full fragment.
> 
> The function batadv_frag_create doesn't check the size of the skb before
> splitting it and therefore might try to create a larger fragment than the
> remaining buffer. This creates an integer underflow and an invalid len is
> given to skb_split.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  fragmentation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision eddbc3d.

Thanks,
Marek

--nextPart1872230.r7EigQzrVZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUoV0IAAoJEFNVTo/uthzAt+AH/j7RnWo56fKx/NK+rBGZK8tt
w+VHeBH8Jy1nvWoSg7+qs2ykShhFug1VxZQFeFfJr82oqtwvIkDVUVTv9bYETCHj
putfj5mgGgQW9lKnMknTv4qk5XDxNlS1L1eieHzaID7e7zpzW7+hMXU7SPBGA1Mf
dfp6cDz/ie2U+TmGkNEA0kN5MA1m+vGKFTzvgb7If/TD82FyfIBzG/Jcv8MMy7kW
zXTV69+2IW8yZSA4BoZ7ZtcHoZNjy30uVojuhh5zREfWPEd0BQJMDyzZGcKvnBAx
I9NyhyI7Yv8GcSzoenaOVr+Lr0zR//TiLuG0J+OjccBHRZnF8y546Veg9ryi+lE=
=wqwS
-----END PGP SIGNATURE-----

--nextPart1872230.r7EigQzrVZ--

