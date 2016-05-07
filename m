Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 07 May 2016 20:07:51 +0800
Message-ID: <2142847.UKtbylqlvC@voltaire>
In-Reply-To: <1462566429-26709-1-git-send-email-sven@narfation.org>
References: <1462566429-26709-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2613205.jgjs1TSzTj";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix double
	neigh_node_put in batadv_v_ogm_route_update
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

--nextPart2613205.jgjs1TSzTj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 06, 2016 22:27:09 Sven Eckelmann wrote:
> The router is put down twice when it was non-NULL and either orig_ifinfo is
> NULL afterwards or batman-adv receives a packet with the same sequence
> number. This will end up in a use-after-free when the batadv_neigh_node is
> removed because the reference counter ended up too early at 0.
> 
> Fixes: 667996ebeab4 ("batman-adv: OGMv2 - implement originators logic")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> It looks like this bug was solved in next/master by refactoring in
> 30c96bc7870f ("batman-adv: move and restructure batadv_v_ogm_forward")
> 
> only compile tested. Please add so many reported by as you want - 
> just don't know it it is *the* bug and who actually reported it.
> ---
>  net/batman-adv/bat_v_ogm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied in revision fc3e79d.

Thanks,
Marek

--nextPart2613205.jgjs1TSzTj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXLdqYAAoJEFNVTo/uthzA4f0IAKxiErnr574vIl1h/z8T0+Ut
22lYV2PfH1LUhBWXyuGuRYeeastR3YEm5wxSwRuRz3qdeEM0eJ1xnkHdkJzKnb9Q
t5PPZ/DNhjsGEdEPj28JlLkEKlLXMLfBwSBhgqCQZKVRcuY7+BOs4TQEMAu8zgjV
43mLx3kc7kTqpQwlgi3k1h/VsLMGvuJ9fQxqHc+I5HINhHngTUtYVHEBeBEZIWQn
WJ5LdDptfTUp2cWZ9TF5d95a7puasWrXS46zFeC+kyBcA75BJw3vF9djTLnlQxrh
lJoxcjbsuHT5vtNp1JI5wD+wVcOe9oS6jYD+MHIVM8tfAc6VwnYJAvDNP1NgtDM=
=rugI
-----END PGP SIGNATURE-----

--nextPart2613205.jgjs1TSzTj--

