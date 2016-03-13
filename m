Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 10:29:21 +0100
Message-ID: <5081672.FTLI5Uv8oX@sven-edge>
In-Reply-To: <1456867148-31883-2-git-send-email-andrew@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2368674.yhBKVF2Bdu";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: NETIF_F_NETNS_LOCAL
	feature to prevent netns moves
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2368674.yhBKVF2Bdu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 01 March 2016 22:19:05 Andrew Lunn wrote:
> The batX soft interface should not be moved between network name
> spaces. This is similar to bridges, bonds, tunnels, which are not
> allowed to move between network namespaces.
> 
> Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/soft-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Andrew, would it be ok for you to apply this patch first while the last 
two/three patches are still discussed? At least this could (when Marek agrees) 
reduce the amount of patches you have to resend each time.

Kind regards,
	Sven
--nextPart2368674.yhBKVF2Bdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5TLxAAoJEF2HCgfBJntGMTIQAI8JrT6pZxLT3uzNsv3Qp8WV
2dOOzhryBFNm9rp8f8ev+tgjiXnaFHWjTOw6rGhtSfxyDrQW2CAY7qHGf5OBV4OS
aDLRSEkS5nGgdft9wuZc4MTXkLgpL7u/ZGnzjj309/IOhbMeJypqmnzgdS486z9U
BR+5x7jH4NZbw6056bTtk3uAEYAz9Ql5pfwYzSd+kLiwvMT6sIW0fQXrL4RCU0Kl
mUPrNNFDu6zH+ty0VyUhOTujYje7pw4SzcpzQpbLLGxIqlEaDCuwB8jGCuOFsKsP
NTj1rpAx9VM0ClVkJnpE+ehdfG7W/yi2+0013cJJi5BnE6jZVTEXzxeP4j1tRu1R
lvNPnXfSFfRwbyAxxjKnvna5j/j4f6iTfBgCw/JdibuSGkcwCVaSALlt4nPiH1W6
12MfCSKU7W+O/tIBW2PlPR1n3o2GR1yiW++KVRCxd8C+dgO1qF4QXXXpj22z7wpd
qhdznM5JZp/R8BsO2XUjBbKopsWjzQK6JirFVcPocATBPtAR+b/aYcryrZu4XSNz
L/JQ7YCq3cti5FW1QTVkaouY0oNNsWR3JY1IKqVawIlichyDmGmfBRZ89R0yNPk1
CsG3X96sOV1BbJ1WvjKZ9OqvMNVcXxmh4iQgN6cHpynxUuB1yX7lhlUaB0NfJWto
3pEbyY8SMuSibJ1GT4UH
=WMi6
-----END PGP SIGNATURE-----

--nextPart2368674.yhBKVF2Bdu--

