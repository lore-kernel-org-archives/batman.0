Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Sep 2016 06:54:58 +0200
Message-ID: <8069472.sOn1bsttGR@sven-edge>
In-Reply-To: <20160925004636.11334-1-a@unstable.cc>
References: <20160925004636.11334-1-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1669488.KRGZSYmC5W";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove unsed argument from
	batadv_dbg_arp() function
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1669488.KRGZSYmC5W
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 25. September 2016 08:46:36 CEST Antonio Quartulli wrote:
> The argument "type" passed to the batadv_dbg_arp() function is
> never used. Remove it.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart1669488.KRGZSYmC5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX51iiAAoJEF2HCgfBJntG1V8P/2FTcPCazb0yuTxT6+ZtRPh6
c/Bv2Cv/wbGa0E4xsF/2U0Kx7RYeTPeF0T//8wXCfmp/hOcD+qRIhq/YuRazMtKi
qU8DT53ztFjPu3qqWNmEwp33EMADyw9VoCArWU88V+fhfFqLgL7BC5Uar4O5AYUu
+vEJygIZMatdQ8U33NuA2Jbi+WGfns9vYmFbWjylgiEY45ck3wMw+ESOm49jsBwt
JSOFJNc1/XSimsnq30APuEF0BVNxgN7lXXgexEvPUPtrzy1gq6xSlfjh/Kqa9jgc
iPONx9FWcMUh+tDHKNKnm7ZmcX9TMyS7sekHJ2hm596bGqAxj9MxxRLLgmbAxcim
dZn26EyI7dtQ7RdkwWKUyugrbE50PVfIXLYi5KDBa1k19/0QGbqUerj1FQfhmG2x
jxOwMNzh+oPrmRlpC6ScWMaqU4ltPrxr7ZRmuIqJxMOqWtfdh86h6XEZtq9gV9FV
Gst57qIc/veHIjBt5arXvtgQ7IRfe+Ggl7JSbUkA9wzkACTZjYCn8wDWqk5x1xym
UFW7Eu4qHSqAYQthXO2kyVqwY+Ff3vXCpSAZjKj/x45V8wMjCBjQ58G3AygQRcNv
j+yaz3eoFoaHopI5skq4k90lR+vpE3XaZKvWiKTkOA1AS17lJai2zUpTOCstCYDE
PizKSrH8wZ7QBi9WW3Ia
=21Ee
-----END PGP SIGNATURE-----

--nextPart1669488.KRGZSYmC5W--

