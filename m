Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 May 2016 14:30:01 +0200
Message-ID: <56303564.iUxXQk9lEV@sven-edge>
In-Reply-To: <20160521121756.27450-1-a@unstable.cc>
References: <20160521121756.27450-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1905819.NtKr95TSvs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove useless forward
	declarations
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1905819.NtKr95TSvs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 May 2016 20:17:55 Antonio Quartulli wrote:
> If main.h is included, the batman-adv private forward declarations are
> not needed anymore. Remove them.

No, these are defined in packet.h and not main.h/types.h

Kind regards,
	Sven

>  net/batman-adv/gateway_client.h | 1 -
>  net/batman-adv/icmp_socket.h    | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/net/batman-adv/gateway_client.h
> b/net/batman-adv/gateway_client.h index 582dd8c..c74aca5 100644
> --- a/net/batman-adv/gateway_client.h
> +++ b/net/batman-adv/gateway_client.h
> @@ -22,7 +22,6 @@
> 
>  #include <linux/types.h>
> 
> -struct batadv_tvlv_gateway_data;
>  struct seq_file;
>  struct sk_buff;
> 
> diff --git a/net/batman-adv/icmp_socket.h b/net/batman-adv/icmp_socket.h
> index 618d5de..ce3ed25 100644
> --- a/net/batman-adv/icmp_socket.h
> +++ b/net/batman-adv/icmp_socket.h
> @@ -22,8 +22,6 @@
> 
>  #include <linux/types.h>
> 
> -struct batadv_icmp_header;
> -
>  #define BATADV_ICMP_SOCKET "socket"
> 
>  void batadv_socket_init(void);

--nextPart1905819.NtKr95TSvs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXQFTJAAoJEF2HCgfBJntG9vgP/iDJTBbjQrs+fPTUJUfId1H4
Xnw5S0RCDzFDIjSWaJaRLXDZJX973t0L/DtAOBq0SnXbwn1Hq6kD8BaiSQdrd1Qj
cfu0bHZ1e4UDa1w/2j2sjwSqUSBhL6vKozT28StrzL1/iRxwOHPw1eU41nYtyyJP
i4YQGqWcC52OycoABG0oWofL1kIPQhmf3rw228zCjFiMhJprD5xaVhxn00J/S0lf
CMpqeDyZfMF4nnFn+Y+UiMoL/rmaM/EgQ8pRv34zRQqExikJrOZny/DBd6KkoQss
yusXgGYWoTbSHkIm+D9HGGWUt615a4yIWBDaf6/Usy5L7yxqj45NWoJJiaT044Q3
plg5SOhbD5V3ApTh7cYqMVUsv+CT/jsrIFEXMmc3OwPRzoASUNY7a0W8oVzWqlwq
Ro8+hiF4lWkQVhR4VYOF6uAIhokAEaKkjALIkNBkc0py2DJK66G8+glZh2eJwnKi
CucMlKvI/aVL1FM0MB9iMLSYoQywkuneqVxbUjB8wKhdmunu/3giz90v1ir9d4uj
Ddtip2R7YNi5HK2hDZd4Bi9YXKb4dOeOBmMnZccKiRqsCLqEP0bXb2usjvvwf8tp
UeduYJkYsPW/tMNDRTg/GBWt2JcG3BDhcvE8brZNB+zKHlL2B7UnHQswQOOrvkJb
5uYVKyfYklxz7kd6/O1e
=LB10
-----END PGP SIGNATURE-----

--nextPart1905819.NtKr95TSvs--

