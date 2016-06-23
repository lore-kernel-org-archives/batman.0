Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Jun 2016 12:17:40 +0200
Message-ID: <1556113.sacdk50hyr@bentobox>
In-Reply-To: <CAM3k=87WXavPXTCZ9SaTbE62-qK=9SvHmtZQ5A-hSXEF=t3w2Q@mail.gmail.com>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <2544329.jNlMzIK2XD@bentobox>
 <CAM3k=87WXavPXTCZ9SaTbE62-qK=9SvHmtZQ5A-hSXEF=t3w2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart45836088.Zg2b4eilp5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sailash Moirangthem <sailashm@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart45836088.Zg2b4eilp5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 23 June 2016 15:40:53 Sailash Moirangthem wrote:
> My wireless configuration is:
> 
> config wifi-iface wmesh
> option device radio1
> option ifname adhoc0
> option network mesh
> option mode adhoc
> option ssid mesh
> option bssid 02:ca:ca::ca:40
> option encryption none
> 
> So, it is almost the same as mentioned in
> [1]  https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config
> 
> Yes, I tried batctl if add adhoc0, and when i put batctl if.. it days
> adhoc inactive.

Please show the output of "iw dev", "iw phy", "ip link" and "batctl if"
after you did the "batctl if add adhoc0".

> Nothing critical says in dmesg. One line is to increase the mtu from
> 1500 to 1532 for eth0.

Hm, this retracted information is not telling the whole story. You are
most likely not telling us about the other batman-adv messages. These
for example would tell us what interfaces are added/removed/activated/...

Kind regards,
	Sven
--nextPart45836088.Zg2b4eilp5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXa7dEAAoJEF2HCgfBJntGZMQP/jNWKeyNnodHQtTEPVV/5dx9
EskvqKT+42OM4MmipBqT9sZTQMe/ys6n+kbVgL8qygaRDd++Ls+CRzVh28udB2XD
TgHUnz6uCeNowZ+AOlUaGaqj+3Y+lbLeOIouqEGtETqbsz8nwjignvYu+vYh/P+/
2Pzx+TsPZZFgZRBTTszlw0BCMrQKIhdG/wee2UOcYhnVl2l4Dh/mpZro6Ae54gv9
hAZjnSo0r767/iXSwNOAznfWrMNQE61I1777VETfMzHQvqr1ABZi6+YyhURkgVE9
ddWJvZTOQpOqN/MmGjCGdJjss8JoEBwR2ZgvjxWODAi36FTmsFrvp5NkiAPWJsZb
fCt857SxmmFJ4b5EkCLd2USkaLcEbYsPLVQR9qGsAY8ZYe1JE68jWuu5Bi8QdpEW
8Yv9gHYamb4tC+f4TYyBSisfJjlzfoxaASpFCrjR75JaUMNRu2fMck8jgsOJbNKF
OaZmGFmYkYt7ujCN03uXvKiekdauSn9TiidFL6NvFaDk63BxReB4tW1q5ANse0IU
or2pJRWJHI7Pvk83b8qtjSD1wl6+mHRnzdMPybejgbXinDLyESoMJRXYui7uzxre
Tj0EllG+QIHvbNuDoJIp/BBKFCCYM5WiCW30sHBAcAsIyFBgR1f6MaNPlzat4/YQ
tez9iZfotZiHI47Oe7Yh
=rgEu
-----END PGP SIGNATURE-----

--nextPart45836088.Zg2b4eilp5--

