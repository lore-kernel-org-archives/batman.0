Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 Jun 2018 12:40:47 +0200
Message-ID: <32533954.9n15W0HXMB@bentobox>
In-Reply-To: <1528971137-432-1-git-send-email-omer.efrat@tandemg.com>
References: <1528971137-432-1-git-send-email-omer.efrat@tandemg.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1894910.JER9txcFyR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/5] batman: use BIT_ULL for
 NL80211_STA_INFO_* attribute types
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Omer Efrat <omer.efrat@tandemg.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

--nextPart1894910.JER9txcFyR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 14. Juni 2018 13:12:17 CEST Omer Efrat wrote:
> Since 'filled' member in station_info changed to u64, BIT_ULL macro
> should be used with NL80211_STA_INFO_* attribute types instead of BIT.
> 
> The BIT macro uses unsigned long type which some architectures handle as 32bit
> and this results in compilation warnings such as:
> 
> net/mac80211/sta_info.c:2223:2: warning: left shift count >= width of type
>   sinfo->filled |= BIT(NL80211_STA_INFO_TID_STATS);
>   ^
> 
> Signed-off-by: Omer Efrat <omer.efrat@tandemg.com>
> ---
>  net/batman-adv/bat_v_elp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It is called "batman-adv" and not "batman". And when (as in commit) did it 
change to 64 bit?  Shouldn't there be a "Fixed: " line to know which kernels 
are affected (especially for the stable kernel developers).

Kind regards,
	Sven

--nextPart1894910.JER9txcFyR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsiRi8ACgkQXYcKB8Em
e0YbyQ/+My4yzF1oi/pXLfsQ5ZowyM1a3YffYUmbjwas2LAli29aMCFeESnB14qO
bpoiFHbfJw0F3+hBRrJ0+/mc73MBi5V/YStIIamWGpilNaxGjlQ+QzlM2nQWqXGm
RByQ6/1M/JTsLMc9+QpBy2kNMQC/Upq6kFeMLlramvHO9x1UjudUJx9PFzX/2AnD
vJzSRwo5wa4+7ugUzgeRiZWRydIXn2kbrwvWjlzFY/Y0z6F/YgdyNOmrW9NGNFLL
lblfLP81rSFwXi18rxOpHVwAuQ/OLoYwboQwxSQgec1oVHV35vHBQOyqs1qLE1Wz
RXi3aFi5uKiTXoTwoC7HToU5Hah8M3lJBk+Rp8LrOgp8BNJe2nkxa9QDj2djj2Xi
cIojNYGWNpeGhxy73IITHwLh+llpRMEBtejmkmRGxMboj+NiIXNRnDqwxkVoksxW
Hz6zCmNrooFtLhfx8YPzaMjicsuQ9rV2A9aO2pE6mmgqrnaiontXUUyP7I5cMfOf
PfcO0Eu1BECFDU7EwVJPTn71+6gtP6zIqzrwZQ1+OQ4Tb9txrBseHWqjqiumk5Eu
dxwkTwYTBqeQO4Vxm+r7GBJse5FdAMrgqvFwjh1taFX4fYkTo6OzddjY2+v6gRec
6PYZs6YveYYymeNJbUoWbSNzUIWRmGelU/pKapz6d5j/k4a70Cc=
=e0XQ
-----END PGP SIGNATURE-----

--nextPart1894910.JER9txcFyR--

