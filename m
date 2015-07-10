Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:27:41 +0800
Message-ID: <10046840.JiJO56dRcH@voltaire>
In-Reply-To: <1434890715-14370-1-git-send-email-sven@narfation.org>
References: <1434890715-14370-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart44892419.9KjMnO258g";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: Annotate deleting
	functions with external lock via lockdep
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


--nextPart44892419.9KjMnO258g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 21, 2015 14:45:14 Sven Eckelmann wrote:
> Functions which use (h)list_del* are requiring correct locking when they
> operate on global lists. Most of the time the search in the list and the
> delete are done in the same function. All other cases should have it
> visible that they require a special lock to avoid race conditions.
> 
> Lockdep asserts can be used to check these problem during runtime when the
> lockdep functionality is enabled.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  * no change
> 
>  net/batman-adv/main.c              | 11 ++++++++---
>  net/batman-adv/multicast.c         | 13 +++++++++++--
>  net/batman-adv/network-coding.c    |  4 ++++
>  net/batman-adv/translation-table.c |  2 ++
>  4 files changed, 25 insertions(+), 5 deletions(-)

Applied in revision 5b95c42.

Thanks,
Marek

--nextPart44892419.9KjMnO258g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn4H9AAoJEFNVTo/uthzAFQUIAICOYyckJza0q/U2SdWUNrFH
o5d1wNfgJtCUIk6C/TkId0B/zrXH99m1gxl4zo1uvMcSC0JEB9b/iRnmKNFWlLPq
pYWWSent7MgV5w4D22tqLqDjcTx+RAvrXSrM4LD7rXdP9CwgQqhbheymUNyhdv2k
jg8yXOpHJ0bd9LqokeleAAXDYqCoz92X9NVLXcc7IVlaHUYi0c4dyZ0YUyCR+T+x
O08hE6J/2NKsTQTpL8xXx85A5Wq2FLJKDptAhdC7btX/gtdh+/EI1TlMp+qvVE1B
6UkoA5SjeP+V8V9VhHldXJ3a+eCzKEY+O0m0LWs5j7Xrl6amxd8T9ep+unU+cKs=
=Xtcp
-----END PGP SIGNATURE-----

--nextPart44892419.9KjMnO258g--

