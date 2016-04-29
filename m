Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:15:20 +0200
Message-ID: <3953178.c6GRPhn5yY@sven-edge>
In-Reply-To: <1461875848-11720-10-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-10-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1793556.bvQmMLXZ8a";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 09/10] batman-adv: add B.A.T.M.A.N. Dump
	gateways via netlink
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

--nextPart1793556.bvQmMLXZ8a
Content-Type: multipart/mixed; boundary="nextPart1885907.Mf7NfgXPdi"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1885907.Mf7NfgXPdi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:27 Andrew Lunn wrote:
> Dump the list of gateways via the netlink socket.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/uapi/linux/batman_adv.h |   4 ++
>  net/batman-adv/gateway_client.c | 126
> ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/gateway_client.h | 
>  1 +
>  net/batman-adv/netlink.c        |   7 +++
>  4 files changed, 138 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart1885907.Mf7NfgXPdi
Content-Disposition: attachment; filename="0018-missing-includes-9.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0018-missing-includes-9.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:05:29 +0200
Subject: [PATCH] missing includes 9
=2D--
 net/batman-adv/gateway_client.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 294ff09..f1b2d39 100644
=2D-- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct batadv_tvlv_gateway_data;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 

=2D-nextPart1885907.Mf7NfgXPdi--
This is a multi-part message in MIME format.

--nextPart1885907.Mf7NfgXPdi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:27 Andrew Lunn wrote:
> Dump the list of gateways via the netlink socket.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/uapi/linux/batman_adv.h |   4 ++
>  net/batman-adv/gateway_client.c | 126
> ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/gateway_client.h | 
>  1 +
>  net/batman-adv/netlink.c        |   7 +++
>  4 files changed, 138 insertions(+)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart1885907.Mf7NfgXPdi
Content-Disposition: attachment; filename="0018-missing-includes-9.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0018-missing-includes-9.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:05:29 +0200
Subject: [PATCH] missing includes 9
---
 net/batman-adv/gateway_client.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 294ff09..f1b2d39 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct batadv_tvlv_gateway_data;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 

--nextPart1885907.Mf7NfgXPdi--

--nextPart1793556.bvQmMLXZ8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7LIAAoJEF2HCgfBJntG/XgP/01njJa2jaVKt+CN2JzAsHTs
OBkxf9QWBPndZMqCc2NkS4otP0UAW8ZjnXabL2QXFsdfTXSL+Pl2AlN8ueslISfg
+w7bqz4vw7w1I73ZaMKiBOdGOeqMmzPwJ3t8MY083UBSmoZqECcj24O9oVri3q0J
mQFNnQ8GNdT+UT6+moegYDo24GTUh6SCa4fZ22IDnRH7CoIf7PYNRbOxRNOQHYJg
2VnJtFNJ+Lu2UKpjRSAlkNQLi1st3onPD1jCJ3M1OLwxHzaNk+2Je63hl1jrbbPx
P1+wgIcWEQR7hf56KzVkIzs4lblSojZ+zyOeTBDre1crrTJFJhtUSY4pRXIbGaq8
RdhPQZy3+KxtAg3zr5AC28sGeYduLEqF85zGfZ4SwhOhjHlJg+F5COelq0LuU2os
vc84dXXBs16h/obsfpn32WjVpDi3MoSefHLqb8JV7KmECAF2RbZQxpI/Hcgl/dYk
eOGCoRhLWUlYbzd4tXN79xFJIPx///kGmsGboTQeFLujBrZCjE6mlXe60zHHKqBx
FO0C3zHR/nIDBqlktFQLaSucOi8c9BJ58CTFlZZSFTfSw6cF04oc+D4TNqRyxFHI
ykgsFTZILlsD00t0zNi97BBABgGO05fFjC7GLRFHmHEEvN6lQPMsMMHErOHKjnRh
d7EfuMEksBwS5uZlvfOZ
=sf7r
-----END PGP SIGNATURE-----

--nextPart1793556.bvQmMLXZ8a--

