Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 26 Feb 2016 17:10:54 +0100
Message-ID: <2122610.W8SJPdlrko@bentobox>
In-Reply-To: <1456492768-29861-1-git-send-email-apape@phoenixcontact.com>
References: <1456492768-29861-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2536423.kDXE1mbPCx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 6/7] batman-adv: bugfix for dat
	optimiziation patch
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

--nextPart2536423.kDXE1mbPCx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 February 2016 14:19:28 Andreas Pape wrote:
> Make sure that claiming of devices due to dat handling is only done
> for non-local mac addresses. As dat is handled after the normal bla
> code this does not break the roaming client scenario for bla.
> 
> Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
> index 739f80f..32a6168 100644
> --- a/net/batman-adv/bridge_loop_avoidance.c
> +++ b/net/batman-adv/bridge_loop_avoidance.c
> @@ -1959,13 +1959,19 @@ bool batadv_bla_handle_local_claim(struct batadv_priv *bat_priv,
>  					primary_if->net_dev->dev_addr))
>  			ret = false;
>  	} else {
> -		/* If there is no claim, claim the device */
> -		batadv_dbg(BATADV_DBG_BLA, bat_priv,
> -			   "Handle claim locally for currently not claimed mac %pM.\n",
> -			   search_claim.addr);
> +		/* If there is no claim, claim the device
> +		 * but only if this isn't a mac address
> +		 * out of the local tt
> +		 */
> +		if (!batadv_is_my_client(bat_priv, addr, vid)) {
> +			batadv_dbg(BATADV_DBG_BLA, bat_priv,
> +				   "bla_handle_local_claim(): Handle claim locally for currently not claimed mac %pM.\n",
> +				   search_claim.addr);
> 
> -		batadv_handle_claim(bat_priv, primary_if,
> -				    primary_if->net_dev->dev_addr, addr, vid);
> +			batadv_handle_claim(bat_priv, primary_if,
> +					    primary_if->net_dev->dev_addr,
> +					    addr, vid);
> +		}
>  	}

What do you think about inverting the check and as jump to out when
batadv_is_my_client(bat_priv, addr, vid) is true?

The debug output change looks like it should be in patch 5/7.

Kind regards,
	Sven
--nextPart2536423.kDXE1mbPCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW0HkPAAoJEF2HCgfBJntG8qIP+wTKhF4810X9xxC6rLRPvM8a
k+rc1I9oNeC1a7Sk+yB0H0a1KiKQ/3kOo2XCp8RRb6JBXAz1xPEEkM9/mK/qM4Ut
a7yNjZRcqyOUC06vxvP7nGXKdiDzYbLg8OrXuWouQ/b3y7/getODNOP4/7E6zd97
LcYyYXt0NzX5K+4OPstiksx+iUlKELtaEPFGPlWDUYPWcGsJiKqK05vBLgdglVc2
J4DdRYA2GS+L9blNu6mebZma/9uBGZkxUxM17pM2j1d6sOT1InUJRwIHoZ+nLTOe
fsaeSstp0VFZQoGEIdBNdJlG8nf/ObHSvmUlsqgIKr1MwVPCQuUzqVLoM8lXrV5B
iOeCUEjoo0gNi1DvcmnccoCv+WCm7rAENhcTYruXD1fjvmNetUfKZW7ePhY0h6vJ
W2CKtrRe6W0xeDCPIbO8KANQ1oYPud5K/xMGkGAJmPzVG4MjvbaA8J0ZCH5P4Dx9
rXvKDoXWOydEwaCVn0rHvu5cy21740m+5U1DO7Zf6nEkjCntSVXZ6mBWFLvSJK/M
7BrFHBPtpRhrYYwwtYEmUdyxG4amTYRoHuEEyTYiILxK0Z495BnZgqO3jlaBvVWT
WXEBY8Zx5MTVLF/4pPehp2e2KIiF7Jv9VOc5djcEO42kilZp9RzJD1ctJBAyJCFE
qEPB4kz6OI3WiDk1kPzD
=9ADA
-----END PGP SIGNATURE-----

--nextPart2536423.kDXE1mbPCx--

