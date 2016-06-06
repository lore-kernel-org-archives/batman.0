Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jun 2016 23:35:22 +0800
Message-ID: <3104087.nWbZjg80UC@voltaire>
In-Reply-To: <1464549952-27830-1-git-send-email-sven@narfation.org>
References: <1464549952-27830-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4406306.xkeas7Rgxx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Fix ICMP RR ethernet
	access after skb_linearize
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

--nextPart4406306.xkeas7Rgxx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 29, 2016 21:25:52 Sven Eckelmann wrote:
> The skb_linearize may reallocate the skb. This makes the calculated pointer
> for ethhdr invalid. But it the pointer is used later to fill in the RR
> field of the batadv_icmp_packet_rr packet.
> 
> Instead re-evaluate eth_hdr after the skb_linearize+skb_cow to fix the
> pointer and avoid the invalid read.
> 
> Fixes: bb69cb678d37 ("batman-adv: generalize batman-adv icmp packet
> handling") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/routing.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision f6c80c2.

Thanks,
Marek

--nextPart4406306.xkeas7Rgxx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVZg6AAoJEFNVTo/uthzAgqcIALB7QqiE04bU1MuYHKLyqmQX
o0FgLX5xamIJT2IjEZbXpJoc28M0HhcWvwM56WFTskjgPaLj1lwXWFfcplypBrce
E0Y7mGZXqvmA+HohJhp1jJaeBh02rYfCx7AEyERwalklRmqJDvfiC3gfpGljFw10
Ae+KMvUMiMf1Ikz46ltPKuAy2fdZLk5mJQpWWqfoGIqVKIAlHBA9oIL7eRc1tsQw
iiErq26cTXYWi/d+DA61jA8jyNMR91uO9wrijbt3h2u5fzjcInJt1heNVW2w6j41
zTgs6rRmTUGEliMc3gKeHBWPYWZIPjY4yjVfQQwf/Qfh6SoaZQsZaSxk8zaGH1k=
=zydf
-----END PGP SIGNATURE-----

--nextPart4406306.xkeas7Rgxx--

