Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: Fix refcnt leak in batadv_v_ogm_process
Date: Mon, 20 Apr 2020 07:53:31 +0200
Message-ID: <6844758.PSh0Y5hloC@bentobox>
In-Reply-To: <1587361040-83099-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1587361040-83099-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3626795.PeB5Tdf7to"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>

 
--nextPart3626795.PeB5Tdf7to
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 20 April 2020 07:37:20 CEST Xiyu Yang wrote:
> batadv_v_ogm_process() invokes batadv_hardif_neigh_get(), which returns
> a reference of the neighbor object to "hardif_neigh" with increased
> refcount.
> 
> When batadv_v_ogm_process() returns, "hardif_neigh" becomes invalid, so
> the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in one exception handling paths of
> batadv_v_ogm_process(). When batadv_v_ogm_orig_get() fails to get the
> orig node and returns NULL, the refcnt increased by
> batadv_hardif_neigh_get() is not decreased, causing a refcnt leak.
> 
> Fix this issue by jumping to "out" label when batadv_v_ogm_orig_get()
> fails to get the orig node.
> 
> Fixes: 9323158ef9f4 ("batman-adv: OGMv2 - implement originators logic")
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  net/batman-adv/bat_v_ogm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied [1]

Thanks,
	Sven

[1] https://git.open-mesh.org/linux-merge.git/commit/afba933d9875cdf31c973a1ecf05de7129a142c4
--nextPart3626795.PeB5Tdf7to
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6dONsACgkQXYcKB8Em
e0b6aA/9EgeHxmgaw9nEaGwVPQxs/aDz3TGXDZAVPhtj4/dd/uXxbvJ9USAG8veI
XgBtMWRDj7jQP41+1CGYaPePAid6tZ4/hE0mEFg5d7+1gnf2rFCZ8CN0ox9GhGN2
pccBnmMuJpHWIyxABUjCwbtYFw+fTbGAIV1Hm1y610JgXGmszcjfcqtY6LNaw3b0
A8azcTlyZiAPJ+tCzUYb33hrxeNb9yqgaZSHMDXOpzcg/L8iR9xvgpgYRZi5DBj6
E2EDpPWknflOfd4lX3FVrHzql7V2URKnDUBhhMc76Nea5qVLFqn8vKgW2IdbYwt+
zTjGSqmwsme0pOEAI8xJkXGbwC3X4LhssidHHLRQb3vUu5UU+ShrEhGw+ack9IeE
QUr9nGgpX3Yf6bu7jmEnIFZHG47A2l+KHbyxWpVsN9vnRMWKfvD82cqjfbglS5Xp
y3V3RrREXN5hlKQ5jpn9vnJmlI0XmoWBiXjVkZHO2S2XPhXxf0FcwYCtCoGQGDa7
qYc3adPv/pAf09g4rB1DYsB7/BXPjuz1JMf9zpdrGoJ/E+2z5xKRYbhiZX95TFSk
n2ay85irBwRODSC4tgIzqJdH0udGUKxWAOo26dLOmZRTC1DUN+6IxfdGetGg7Y58
9aZWNtXkhaeAtZyIU4VT191pyWf13nuL5luP3EPST1n/T5/nQCc=
=oZeN
-----END PGP SIGNATURE-----

--nextPart3626795.PeB5Tdf7to--


