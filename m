Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 11:48:37 +0800
Message-ID: <2849660.eB6RnOYSlL@voltaire>
In-Reply-To: <1429292430-30883-3-git-send-email-sven@narfation.org>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <1429292430-30883-3-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6271998.Us0NboAZo1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 3/4] batman-adv: Remove unused
	IFF_BRIDGE_PORT live patching hack
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>


--nextPart6271998.Us0NboAZo1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 19:40:29 Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4:
>  * rebased on top of master with merged patches from 
>    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012985.html
> v3: no change
> v2: no change
> 
>  compat.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/compat.h b/compat.h
> index 35e3dbd..9871a23 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -59,8 +59,6 @@
>  
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 36)
>  
> -#define IFF_BRIDGE_PORT  0 || (hard_iface->net_dev->br_port ? 1 : 0)
> -
>  /* hack for dev->addr_assign_type &= ~NET_ADDR_RANDOM; */
>  #define addr_assign_type ifindex

The macro is used in compat.h line 55, is it not ?

Cheers,
Marek

--nextPart6271998.Us0NboAZo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAABCAAGBQJVNciWAAoJEFNVTo/uthzA+y4H8QETqaXcVrlriSrfhnXOR1wy
CPfAbUAbKtvSTb/+KYAZkaj9vfnVKIROgJs3mHyKcsAGl3quJHMYO12qotrE/V2+
3uLgwL05Rx9ZyXJ8sxY0OZczhX3rUQIjwiNp2WyD2U6vPWrzTMRBvZlmrdUqktlo
Zd1RTwmKth0yue8iukGEswEvFC0W8GZ7Se9ves0RFamJ2r0k1t9kr+jPrLozoj0y
dTWTI/XJmkkVPpRoHDTkYh9+Bho3bANOPop6uNQsLhQKCx0pnpTxrFoBlhSTjBEe
UXQsBAG/CsmDOFnHjOUfFl+qOb5p24pT5pXBmgLswtqAB6UJJa6axZZZv0leAA==
=LVmc
-----END PGP SIGNATURE-----

--nextPart6271998.Us0NboAZo1--

