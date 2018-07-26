Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 26 Jul 2018 09:12:41 +0800
Message-ID: <5556611.7sBE4ScoTE@rousseau>
In-Reply-To: <CALb7xhwsssLtKnT+Y8pmVch7OOUdUQ_n+yN61tUfQx7RE0KOCw@mail.gmail.com>
References: <CALb7xhwsssLtKnT+Y8pmVch7OOUdUQ_n+yN61tUfQx7RE0KOCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1884281.cxl7uFzuXr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] ICMP6 flood or nodes limit ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1884281.cxl7uFzuXr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 26 July 2018 03:50:10 HKT Nicu Pavel wrote:
> Everything works fine with 31 hosts when I add more (34 max)
> everything stop working, hosts start to drop, I do see a lot ICMP6
> neighbor advertisement/solicitation. I increased the default values
> for elp_interval and orig_interval to 5 and 10 seconds. Once I power
> down  the extra host(s) everything goes back to normal. The actual
> traffic in the mesh beside the ICMP6 is low a few KB sent once per
> minute.

There is no hard-coded host limit in batman-adv. It is more likely to do with 
your wifi driver. What wifi chip & driver have you deployed ?

If you check the mailing list archives you will see the wifi driver issue 
coming up on a regular basis. This example discussion is merely a few days 
old:

https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-July/017952.html

Cheers,
Marek

--nextPart1884281.cxl7uFzuXr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAltZIAkACgkQU1VOj+62
HMCJiQf8CUCQZkqu+R8crIpyciIMcr2fWDt+oiF8EClXE5d9cCmLheTnFNkaZApz
O3pdn3pjE9V9UCDKiMTsBut6RlKFX4rKRiqzrcxj2qjvebasqijwRqgsiO2qrQBY
M/VKEqAzkRWcX+zd76Ezg8hRcbzp8JoEQzqu8ZxXgt55KhXH66I/R3gXF3aBfRF1
I6G7hgWsMzO8Izbk51mNBxkyroGt9gciWhEPGrY9/HGkzpe99x11pynv7VXZc5gi
P+4AC8Q/WZSDfp0Lr9Gijwohqs3RrJL5wgaNPPZpRei35Wos4Zn3qTGCldBwGqOm
ReeyMfo8UlwAH/8H1XmdprKrcRytrg==
=cPI2
-----END PGP SIGNATURE-----

--nextPart1884281.cxl7uFzuXr--



