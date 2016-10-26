Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 26 Oct 2016 08:07:11 +0200
Message-ID: <4752844.Su7blveJaV@bentobox>
In-Reply-To: <580FFD64.7020704@yahoo.com>
References: <580F251E.7060400@yahoo.com> <580FE89F.1090808@yahoo.com>
 <580FFD64.7020704@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3462261.D6j6aRhJqZ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Whether Batman-adv need suitable wifi network
	card (support interface modes ( mesh point ) ) .
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: johnzeng <johnzeng2013@yahoo.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3462261.D6j6aRhJqZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 26. Oktober 2016 08:48:36 CEST johnzeng wrote:
> 
> Hello Dear SIr :
> 
>                           I am testing between RTL8188CUS 802.11n WLAN 
> Adapter and Rt2070 now ,
> 
> 
> 
>                           When i ping hostB from hostA ,
> 
>                           hostA show ping info  , ( From 10.10.130.66 
> icmp_seq=211 Destination Host Unreachable )
> 
>                          and i catch some info via tcpdump at hostB.   i 
> guess it was caused by not suitable RTL8188CUS or driver .

Please check if the underlying link works. Check `iw dev wlan0 station dump` 
and add an ip in a separate ip subnet to the wlan0 and try to ping each other 
via this ip. Also check `batctl o` to find out if the batman-adv nodes can see 
each other.

Kind regards,
	Sven

--nextPart3462261.D6j6aRhJqZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYEEgPAAoJEF2HCgfBJntG7tIP/RYUj6cYor0rZFA88VX80nzb
EjHrRhLRPv+uP/5DCC8Nl8b30bhGhkxxCpgDZdjSYQwjwUkAdlM1SjarXyNGdnNp
o9b0TQWThHKNeX33ipSvXLT8to9zqd5IqO1Mh/ljqNU+e8e88FUabfBanZn8Ihbs
joTZuP2ljUhPk4txrPFEGZ6bMR/nZfw+/XX1wknsGx23PHHQq1P+Ia7PykzVlvCt
+QSv56g1t9koVi4gWTaiGNqj0/JMWxDlIxxRctsCFvCLranjnWgyJovVrYxSGtCK
LnlNVpAbJLvh3r2ut4jWM7zdP/9PnDvrCBPO3L8HEkyAY1kdhyhuk232UrrCLOtW
MQ7LYKHgOTT6GOTaMzrSz6Glp5tqMGCDKyyo9BfqKmAeC0k9TI5ftF/kmir49yMS
hG2DLL9NjrUFgPb0rYiqIrzDVaSpio5lcALlvltI5331MV896UDirwf+Y7mwUYYc
R0mFMcmusLORZR9sEqkHraQbVA2XzQbj4aymBM8gsHDwBRb/IxJNFTQAcduXp3CI
g1OtjmA0pAa9XQWet0ZMGsxHhuqE30bXg9cXW+GXkK4xL0jTjrAe2UJJaI49Qrgi
R0sKcnoK+ZIqGg00ZNS1w27R/K4eMI9zE2rSB21ajEAM2CEkggPsITshYP3rX/sP
B6BsNjk83Wx/WT6aSeMS
=0/fQ
-----END PGP SIGNATURE-----

--nextPart3462261.D6j6aRhJqZ--

