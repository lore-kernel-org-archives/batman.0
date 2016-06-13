Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 13 Jun 2016 12:46:25 +0800
Message-ID: <11945208.nPaP2GyH6B@voltaire>
In-Reply-To: <1465592459-9474-2-git-send-email-sven@narfation.org>
References: <1465592459-9474-1-git-send-email-sven@narfation.org>
 <1465592459-9474-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1967070.PlUKv0B3dF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 2/5] batman-adv: Use rtnl link in
	device creation example
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

--nextPart1967070.PlUKv0B3dF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 10, 2016 23:00:56 Sven Eckelmann wrote:
> The standard kernel API to add new virtual interfaces and attach other
> interfaces to it is rtnl-link. batman-adv supports it since v3.10. This
> functionality should be used instead of the legacy batman-adv-only sysfs
> interface.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4:
>  - rebase on top of current master
> v3:
>  - rebased on top of current master to fix conflicts with newest patches
> v2:
>  - rebased on top of current master to fix conflicts with newest patches
> ---
>  Documentation/networking/batman-adv.txt | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Applied in revision 0d21899.

Thanks,
Marek

--nextPart1967070.PlUKv0B3dF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXXjqhAAoJEFNVTo/uthzA2wcH/0BAFQnOltj3KS7O5nCfip24
68St/L7uaxc+pBEHosxZAAe9W5yUSERn6LCK1cDTiKUMZ1x9eUtRXb3NjuXoI2pd
39fTFe087PC6nB7nt88yVL1SEPoLb+15TYxUD2XQIntYDzBowSkHdM+sb8pej4f3
lsIZIl33E7Z2wWu1LS5sz/avcKiRRBbbHNbREQZ9nINcYo61nIcCGIEQ9gmcdjNP
9NAWIvv10+PUrU10j8ctFoUYBd1FVs1wOUn5npVAy+X8VlGRFi/amW5nRanSD85v
aSmyVnKWWnJ09Kghec8sa2sSYDOJyyMUDlbxxIi1DN3wP1mDz2tCePBfCqEVgQI=
=NNUi
-----END PGP SIGNATURE-----

--nextPart1967070.PlUKv0B3dF--

