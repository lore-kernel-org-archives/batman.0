Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 04 Aug 2015 04:07:56 +0800
Message-ID: <7075625.HBap74ta9e@voltaire>
In-Reply-To: <1438622038-20514-1-git-send-email-sw@simonwunderlich.de>
References: <1438622038-20514-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2038397.vvWJSWbQLW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: remove obsolete deleted
	attribute for gateway node
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


--nextPart2038397.vvWJSWbQLW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, August 03, 2015 19:13:58 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> With rcu, the gateway node deleted attribute is not needed anymore. In
> fact, it may delay the free of the gateway node and its referenced
> structures. Therefore remove it altogether and simplify purging as well.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv3:
>  * remove unused variables
> 
> Changes to PATCHv2:
>  * use hlist_del_init_rcu() instead of looping through the list
>  * rename batadv_gw_node_purge() to batadv_gw_node_free() and remove
>    obsolete mesh state check
> 
> Changes to PATCH:
>  * iterator through list to remove the element when deleting to
>    avoid possible double list remove
> ---
>  net/batman-adv/gateway_client.c | 48
> +++++++++++------------------------------ net/batman-adv/gateway_client.h
> |  2 +-
>  net/batman-adv/main.c           |  2 +-
>  net/batman-adv/originator.c     |  1 -
>  net/batman-adv/types.h          |  2 --
>  5 files changed, 14 insertions(+), 41 deletions(-)

Applied in revision 0511575.

Thanks,
Marek


--nextPart2038397.vvWJSWbQLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVv8okAAoJEFNVTo/uthzAdtgH/1WVs5DFw2JkKrboYWr9bXjv
KTNzCIv+/2FPBT771VxShQbxNqoerRbnvfWUDIgQ9lkm6N9p1b3DU9ighjPPS7im
cDQxGjd9Y2jaLygne1U6KRU4l/K1rL/K1dhANtZklnpIL4lTW8Nia0NC9LLKSxVf
yGUn8lv4mRLPjHkTgg3zyIQdakJacxBh6t9bxZY/b+8N8JvounxpsISE6woZ3ABe
JrXyD6cSzoGN7VGk9ZjLAwpF9Tu9KlwkeTfKOYfeHe7GABWI4dS3Gk5g+aMWSLOj
nabpWZyAtrwwk+0bhkvxYo0dZvskiBqXQeGTTY1SkTDgtgyJnwZILlmBMY+DRYM=
=o1m0
-----END PGP SIGNATURE-----

--nextPart2038397.vvWJSWbQLW--

