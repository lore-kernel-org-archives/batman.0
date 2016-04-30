Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 30 Apr 2016 12:04:29 +0200
Message-ID: <1587584.QTsZaL7yKl@sven-edge>
In-Reply-To: <1461970765-24615-3-git-send-email-andrew@lunn.ch>
References: <1461970765-24615-1-git-send-email-andrew@lunn.ch>
 <1461970765-24615-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2580392.58ERdOCIEe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 02/12] batman-adv: compat.h: Add
	workaround for get_link_net()
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2580392.58ERdOCIEe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 30 April 2016 00:59:15 Andrew Lunn wrote:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
[...]
> --- a/compat.h
> +++ b/compat.h
> @@ -137,9 +137,15 @@ static int __batadv_interface_kill_vid(struct
> net_device *dev, __be16 proto,\ #warning cfg80211 based throughput metric
> is only supported with Linux 3.15+
> 
>  #endif
> -
>  #endif /* < KERNEL_VERSION(3, 15, 0) */

And this line removal is also most likely just an accident.

Kind regards,
	Sven
--nextPart2580392.58ERdOCIEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXJIMtAAoJEF2HCgfBJntGEi0QAIrToBZdb2+bEUWiV42jP305
7hWygUGmbEkUMIefJt3O3S0wCUPjoLd9pm4U3y7wUbeUCSboJn5SS7gZLnjKJdAv
TimZhnmtVScZrw8Rp35zGXfR7W1x9qzytkSK0xc6xlVpJ5m1KbPGmgSjm5mSPzRG
oVpvZAE1ZMc9/8qiIr853Rn8t+R5lmuY05X4xdCkgExFtcD1Wfiw2OeUpFZ2HZV9
7iDOXEcoPxvimygXcZGxsoRMMoIzQmRV/ZxUd7KNy/fDg82P1k3geTlh+5IEds9f
9fzazLJQZgXuAAL0ChQpL5KPoDD/fVjRacVZYKkgYdbVoewZE1OSuHblZa8UfdGf
2ftxOJgGvAyuxfo8GtGB3b+IV1hcTzwRI8xaDVUwl3q6Zt46fdqOw2eAGv/8LrPL
YvwbpQWc7kZ5Z9Ed6P8Ndo+4CBN2uxm0mcB4g+Itbx4/lhVHUHCRzMCH5XhEhM0J
lCLF03WnK0HIj+D6z7Zrzex4H15a7y4jy3KnzwBWEI4whHU8KInPQDJBECuyCo9w
gZ47HQ7fAA40wsyCx41reFpNgpADb19KBoPQtdYAssDoWK7ncXEzrpBUWCT87Cpr
A+r2EhV3ZoWGTIL/40FF+XsWWV8p2HfoIh4sny9D7kmHG1fzuOpvUYt1VzLH+pY/
BboCm94djebPZYPFvcZN
=80K0
-----END PGP SIGNATURE-----

--nextPart2580392.58ERdOCIEe--

