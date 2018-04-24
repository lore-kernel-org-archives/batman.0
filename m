Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Apr 2018 15:45:43 +0200
Message-ID: <2333740.P7S8BcYFuH@bentobox>
In-Reply-To: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
References: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7028284.oJHuMbyaZl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix batadv_interface_tx()'s
 return type
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org

--nextPart7028284.oJHuMbyaZl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 24. April 2018 15:18:46 CEST Luc Van Oostenryck wrote:
[...]
> -static int batadv_interface_tx(struct sk_buff *skb,
> +static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
>  			       struct net_device *soft_iface)
>  {
>  	struct ethhdr *ethhdr;
> 

CHECK: Alignment should match open parenthesis
#76: FILE: net/batman-adv/soft-interface.c:192:
+static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
                               struct net_device *soft_iface)

Kind regards,
	Sven
--nextPart7028284.oJHuMbyaZl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrfNQcACgkQXYcKB8Em
e0ZD+A/9GMc5rOQAuWEhpa8dh3fpczfJ7E3JM30mEMbUR7+VEyW7/v3YJoIdIa9D
xPgdy847X8i7NXrfDbbIsp1XDBXrqjOiz5WAa7sBXEFCj3ZAOLXdKpuicCRp4H5W
xhGbOGcKCAjkvRYSVBtGjebTHmIlsCM87AUAR/ADuNrOVrAwzbNxPUFGTyyoxfpb
f689dU5z3C3+s3Lflq3m1H/xOpBfpdbg5Ip/ZsTVFeePJGlee6oWW6VqM99hGb/H
9cLc810PpacMQB337Lf68cNDU+m43rV0mSm+vw3HyC+ZVPDu1vxiLVZ4VZYzf1BK
OvHU84mYQMOVIJDHC4BW+1fFcF5JBSk2cDkQ5fmTXZzcGfdL0CjlCoOCmcP7mzal
JjXJNBc1w/KtaR9zjVe+MIp+ZJi0zJbmWQ5+51pEiXICTok4rNekii7lcklMIeoI
z4ehD2J/rah47KGk6I/lEg1RcN77MkdyoT7RLcqCuO68jY9inMT992pDkWAxyc9Q
tR+JkT6E22jC//opaxD4D4QGaJlVkuMxKLWfP90ETU7zG4eVW2J0WnP+1xWkZZWa
yuVVs9eCgZWUPmMXpWbXdKWZFNlCOwSoca6tQFXTyXpxyIQQJnQDxmhfMdgHGgmj
f17GctIlA7q+lUdhbdddFCGTJzTxzcn/hc3t/k5/Vojy/B+ySpU=
=jB6s
-----END PGP SIGNATURE-----

--nextPart7028284.oJHuMbyaZl--

