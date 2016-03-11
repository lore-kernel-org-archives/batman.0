Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Mar 2016 18:19:01 +0100
Message-ID: <3646610.pvIIUdPUPC@prime>
In-Reply-To: <1457715768-14863-1-git-send-email-dominik@heidler.eu>
References: <1457715768-14863-1-git-send-email-dominik@heidler.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2657540.DOH6vcCRIS";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] alfred: Allow setting the source mac
	via unix sock
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

--nextPart2657540.DOH6vcCRIS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 11 March 2016 18:02:48 Dominik Heidler wrote:
> The server will only overwrite the mac if it is zero.
> Ths allows acting in place of (non-alfred) legacy clients
> by injecting their data with the correct source mac.
> 
> Signed-off-by: Dominik Heidler <dominik@heidler.eu>

Thanks! I've did some style changes (declaration up, !memcmp -> memcmp() == 0) 
and applied it in revision 58e1099

Thank you!
      Simon
--nextPart2657540.DOH6vcCRIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4v4FAAoJEKEr45hCkp6hK8UP/RoFYdMz71LilyK6t3P1jq7z
Jn4f9c9b+ZKZtoeNn4mLaNV4AbCjMNbmHVGUVqjvvuKRQLJD79xKeGOI/wNFT7gQ
shyN2FFEacsO2d3Sc16G+V1SJyVM6LO7A2a0ClHeIiMQaCDYG7Sg3Zb0+/VQxd6m
7kVUDULNbYOGLML9uZC2yjyuPLQ/lECC2txt1M9HxxylwAK/SZ/KhQw81ggpDTNh
3PyFgkTNZnuCJzBCpXM9lLqnbtnWUpkTKVS0WYUhKUGGVFeOtac9jbkxTcUKhH2D
BL3yGvTts4+f12vJDoKh4EhUN8o9bGCxUWE34QqMtGIpZ7xt782Fi5ejZdaAAUcT
3sNBNUpZZnYnKbd1RVf4bRiAYaAnjX+MoPY4Z9yj5uza97GzjosI9O3BRK93aQTG
TRwSU00euMByDsm+iJxTovOFDVAgqgqWzs+gUIM6MuiSzsg7G8RYBbERTv3nMRRA
SaZAdqR1sxA0HSX4mIGV2F9FkDEqorStgX+WyhzcTLd2M0FnSQdBz4Ekd4KkHn4q
1SzP3S0/AQksQQC/oSdwHB+yCp4x+PBV+T6z4O9BIYMMi1GCgkR049XIpjURKFpI
eXt4qFf5QfFSfjHM/fBbWBlyWK4H/EbWwRY7I7+FOXY4aZNUaT/R9xA6VUf2UTWt
t/5L4Qa8WPKzSEpmP8A5
=xd9B
-----END PGP SIGNATURE-----

--nextPart2657540.DOH6vcCRIS--

