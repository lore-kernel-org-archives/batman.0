Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 25 Dec 2017 20:24:47 +0100
Message-ID: <3091209.OFEMCjJbTv@sven-edge>
In-Reply-To: <b00b8bd2-68bc-54fd-4d1c-cd3f9655fac1@wifibot.com>
References: <b00b8bd2-68bc-54fd-4d1c-cd3f9655fac1@wifibot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6568613.LWMlrtIcFN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] cannot recompile my openwrt image with last
 version of batman-adv 2017-4
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
Cc: laurent <laurent@wifibot.com>

--nextPart6568613.LWMlrtIcFN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 25. Dezember 2017 18:36:56 CET laurent wrote:
[...]
> I am able to compile alone the module in the build forlder:
> 
> /home/user/gateworks-openwrt/build_dir/target-arm_mpcore+vfp_musl-1.1.12_eabi/linux-cns3xxx/batman-adv-2017.4/net/batman-adv/bat_iv_ogm.c:734:2: 
> error: implicit declaration of function 'skb_put_data' 
> [-Werror=implicit-function-declaration]
>    skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
>    ^

Please use a batman-adv package which is compatible for your OpenWrt version. 
Or use LEDE (master) with openwrt-routing. Don't try to compile 
openwrt-routing master (which is for LEDE master) against OpenWrt Chaos 
Calmer.

Kind regards,
	Sven

--nextPart6568613.LWMlrtIcFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpBUH8ACgkQXYcKB8Em
e0ZhhxAAs/zg7NoxPg9m3/zReAcymzYJsDiDtDpWNkzg+J/aWDTS0ZC8cO/1XoKP
Og1q1es/n0tBWwaFMG28U+gRVT8Q6SPX1is2vasmOOwi3iIeQ+aLXvqCmnKaWsIg
xMUooXNLMv77aRSzNcZEscaWA7ZE5muqrpFa7j+FNY97iLbzpV94pMAzlKTo8bIb
HFY9DkVNeNzYKyw/CoDWAKrvgi07aiplTZbBeyUTyAbDtxj8Vi5S9jiFY6Ef1YUq
6pzRQ7SPpvZcO9AS4Kyrb1CuSIZmuiqvgdjWc/m+OEvnr2poCCqsPPnov5kXfwX6
T4FVcdTUhXLWKu0R50lLW7K+8nmLoWSqY7eBCuBsXTt/3Pt9UVLwEpebq9p10W41
wtMz19yqajqIZOK67ZA6DDmYVnazvUGwkPURmroq7xvAAC4XdHEKZlA7ksKO7ZCB
E/X3QzX1oFeDIB/fMZykc8AsCSnWW4mTGhOWC/OjannPXfcaX0T8IQbYWfZHfKcN
xV9fPowzQ9j33KrZaez77dOAdKipBnYE+OS0+HvND0+174qYtBK/F9g3t7w/dACq
BtsiiIuVlfUf3I4bmiBl1TyfNdgtUTFqoKWThY9LXu9Gdl/x0mHeCZy5P4pubMez
3tZ5FOP7KmjCzV3GnaT4mn0kQPstde2aHUfgORuGtjbMVX8bQSo=
=0hlU
-----END PGP SIGNATURE-----

--nextPart6568613.LWMlrtIcFN--

