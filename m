Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:07:55 +0800
Message-ID: <18241209.EXcgiBYQBQ@voltaire>
In-Reply-To: <1456951556-27662-1-git-send-email-sven@narfation.org>
References: <1456951556-27662-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3067025.9yorAd6BSY";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: clarify CFG80211
	dependency
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

--nextPart3067025.9yorAd6BSY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, March 02, 2016 21:45:56 Sven Eckelmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver calls cfg80211_get_station, which may be part of a
> module, so we must not enable BATMAN_ADV_BATMAN_V if
> BATMAN_ADV=y and CFG80211=m:
> 
> net/built-in.o: In function `batadv_v_elp_get_throughput':
> (text+0x5c62c): undefined reference to `cfg80211_get_station'
> 
> This clarifies the dependency to cover all combinations.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2e0a2972e354 ("batman-adv: Depend on CFG80211 for BATMAN_V")
> Acked-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Submitted for out-of-tree module with adjusted "Fixes" line. The
> upstream commit is fb653ebddcf871e8a83a63c1e4e73d41bc3cf599
> 
>  net/batman-adv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 4735b46.

Thanks,
Marek

--nextPart3067025.9yorAd6BSY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+Tq7AAoJEFNVTo/uthzAtZAH/RwoCH/M5AG5pM5T/jj7gpOl
Q1KRyLkDBCjd1BzKIyVXd2LnNTUgxs6qvHNmu4Klg9vSaqffniSZKzwYApxKGXSo
aE1yd8jsQZx+Qve6GdhfrMFWinGNZZNfG2nOZS/Byq5c4EBGXwFBcwbvlinJ5ugD
rOAOF93XJpYVc8fHKhaaU0VC4bdoyTnyAOk6fdIJFcXmG8YTWtXd9y9XqAo+8qE4
L648ioLkFBTilT0AhxWaFNUBCWio1fr8SUrJIyWfn0gGBG+75/AYE6mZ0us37bI1
9NCzNeNV4v1SMOCM/swxsxV0EFv0rSH3Qt/o+F0qG/knapuzxXmarKPnHQZ5T60=
=5aMW
-----END PGP SIGNATURE-----

--nextPart3067025.9yorAd6BSY--

