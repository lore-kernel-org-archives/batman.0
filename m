Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jun 2016 00:07:59 +0800
Message-ID: <1516057.WKIYGthmEr@voltaire>
In-Reply-To: <1463770180-4030-1-git-send-email-sven@narfation.org>
References: <1463770180-4030-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart36650129.UEeEbDz11z";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix returned error in
	batadv_netlink_tp_meter_cancel
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

--nextPart36650129.UEeEbDz11z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 20, 2016 20:49:40 Sven Eckelmann wrote:
> From: Simon Wunderlich <sw@simonwunderlich.de>
> 
> The BATADV_CMD_TP_METER_CANCEL netlink cmd can for example fail when no
> valid soft_iface can be found. This error should not only detected but
> also be reported back to the caller.
> 
> Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/netlink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision f0aae6b.

Thanks,
Marek

--nextPart36650129.UEeEbDz11z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVZ/fAAoJEFNVTo/uthzAXeAH/jvqS0Y/770YzvuwulOHkwzN
jMs4PJXkQLm2Ikmc5mRTdt8dwcoBKgrwRaBJd/wAlEbwA8NcOOaejoNVI9caLLm/
YQIyX4Bx2siZzsE/0ma2DxNrZ8DoKXWEvoJqtWS058rZttl7vg1Wa9Gg/5YeB7yG
Ju2ibosiHozVtgacs55nrwLgV0CQesPcivAAQwFthsLCOUSKcIdm+Gm0bBwkH4eW
gpUS8ktpnujLFUTNDmbUvHQlFBeik7C0NWmsWeMz6WcrF4IUnLsjq3AXwJ0+1YYL
chdWXTXaKSI4+NRkJqenzW5ZCcmVu0UHhyleHXRPlUiX91LuHfnP+Xq9KBMrc2w=
=C05m
-----END PGP SIGNATURE-----

--nextPart36650129.UEeEbDz11z--

