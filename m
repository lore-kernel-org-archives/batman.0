Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:27:24 +0800
Message-ID: <2654579.dWtU2LEh7h@voltaire>
In-Reply-To: <1457190564-11419-2-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5157630.S7fy1zCrjq";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/9] batman-adv: Check hard_iface refcnt
	when receiving skb
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

--nextPart5157630.S7fy1zCrjq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:17 Sven Eckelmann wrote:
> The receive function may start processing an incoming packet while the
> hard_iface is shut down in a different context. All called functions called
> with the batadv_hard_iface object belonging to the incoming interface would
> have to check whether the reference counter is still > 0.
> 
> This is rather error-prone because this check can be forgotten easily.
> Instead check the reference counter when receiving the object to make sure
> that all called functions have a valid reference.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/main.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Applied in revision fee73a8.

Thanks,
Marek

--nextPart5157630.S7fy1zCrjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+T9MAAoJEFNVTo/uthzAFR0IAIOp0rHaU9+94JjoMX3V4798
thVdC8egwwGm2u/H/NBxTY42cz73LPjyAYooS15lFGgZnmy+RmtxHmiUorIF4Ghw
bP+U2fDUl1HZKOeIXKvj5epxScJkj1ITRDEdcoZXsdWsuoYTWjfakl5k9DH4DH8f
T599DuDvW0Tunp4D2HHFA0xBU2rc6O2/D4CZNvbK5YFQXLselccCH6WI+AgHjn+e
uubo/3g/FuLaaq+RNavPOjRQPzjZ6sXGfy8/R7dyQiRLJUcnBBIzNY0uDNoLoEcl
1juaaPybr6RNKVG/0mOIOStppEAznZh7r0AcrLAKEW0kKgymNuywo+IBZhmA4wQ=
=u9IC
-----END PGP SIGNATURE-----

--nextPart5157630.S7fy1zCrjq--

