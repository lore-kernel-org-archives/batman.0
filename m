Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 16:59:18 +0800
Message-ID: <3825916.yLgOJom9pH@voltaire>
In-Reply-To: <1467545508-7333-6-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1577229.2OYAU3T3FI";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 05/16] batman-adv: netlink: add
	translation table query
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

--nextPart1577229.2OYAU3T3FI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:37 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> This adds the commands BATADV_CMD_GET_TRANSTABLE_LOCAL and
> BATADV_CMD_GET_TRANSTABLE_GLOBAL, which correspond to the transtable_local
> and transtable_global debugfs files.
> 
> The batadv_tt_client_flags enum is moved to the UAPI to expose it as part
> of the netlink API.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: add policy for attributes, fix includes]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> [sw@simonwunderlich.de: fix VID attributes content]
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  include/uapi/linux/batman_adv.h    |  56 ++++++
>  net/batman-adv/netlink.c           |  23 ++-
>  net/batman-adv/netlink.h           |   3 +
>  net/batman-adv/packet.h            |  36 ----
>  net/batman-adv/translation-table.c | 377
> +++++++++++++++++++++++++++++++++++++ net/batman-adv/translation-table.h
> |   4 +
>  6 files changed, 462 insertions(+), 37 deletions(-)

Applied in revision fcfcf61.

Thanks,
Marek

--nextPart1577229.2OYAU3T3FI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKXmAAoJEFNVTo/uthzAagAIAKdsELVMnogDP/l1Z3iY7GU1
Jg7LuzCiXpdtpW/qA0huHepMjGKNScmDWwbLuuaDcDbddSCkGCLLDqbAaWXBbZ2z
+3suPxxLK3L6I6g7qJRjrfr5vYaW+dELymM18wst5JNI5ISYgMuhEhvzTeMNNAzX
tBA9RxylflDPHmhR8wJsgXwHKd/Sy9JZclHlyiuArHmST7kiFqUiq8osx6IdHGQ8
AVsan76nAvXiQwx4JEFuWhkSGVMpXfUZNU8Hiz+mVkv8GoId5QMeRpmhucAf8U2v
J0vhAyv/PhUYWPoOcd7kZkjaTlQnH4WUtZZIijqSsXHlfeTdwvWNEAWdhQsUDHw=
=loIk
-----END PGP SIGNATURE-----

--nextPart1577229.2OYAU3T3FI--

