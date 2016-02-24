Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 24 Feb 2016 23:54:26 +0800
Message-ID: <1502266.mGUidmsZ34@voltaire>
In-Reply-To: <1456248335-20169-1-git-send-email-sven@narfation.org>
References: <1456248335-20169-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14571887.7GdxIih8Ty";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Depend on CFG80211 for
	BATMAN_V
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
Cc: Antonio Quartulli <antonio.quartulli@open-mesh.com>

--nextPart14571887.7GdxIih8Ty
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, February 23, 2016 18:25:35 Sven Eckelmann wrote:
> The B.A.T.M.A.N. V metric can uses cfg80211_get_station to calculate the
> expected throughput for ieee80211 devices. This function only exists when
> the kernel was compile with CONFIG_CFG80211 and thus the
> BATMAN_ADV_BATMAN_V option has to depend on it.
> 
> Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on the
> estimated throughput") Reported-by: Antonio Quartulli
> <antonio.quartulli@open-mesh.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> @Antonio: Please squash this with 0b0214420ad2 ("batman-adv: ELP - compute
> the metric based on the estimated throughput")
> 
>  net/batman-adv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 2e0a297.

Thanks,
Marek

--nextPart14571887.7GdxIih8Ty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWzdIyAAoJEFNVTo/uthzAb8YIAJMZORp/SO/D0sZgiJnXColk
XliCdNxiFXkYhfFlTlxYXx6SOg3gnoWurjUE+6+qZZu9303pSGXZ4VVmvCJbCppB
Bhc6i4gQkVrHC018wKITCnzgFUteraKZOeed9NO0WXTqQo+tI7daeH3f1eWfNPGE
Fng059wP4LfQm6UdhAsAxtRjlwF69jObBT2/veg14qEbfq4SdifEPNZAKzr5rj9q
jH5VvUkSFUw4pHZIa9mFDbpyW4nqWTZ11POV5TvRbDj+ROcSpbtRD6FoEm03Mz5Y
2JrFl0E78RA1RRcpOzTcwZ+qUMUIIvcfITC0lxJEgGCU0G1OYAePdkmpk55SAZ8=
=jmo9
-----END PGP SIGNATURE-----

--nextPart14571887.7GdxIih8Ty--

