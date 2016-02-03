Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 03 Feb 2016 18:14:55 +0100
Message-ID: <5257267.1LZJPcyIcQ@bentobox>
In-Reply-To: <CA+5PVA4HVjsEw+j+HMDzO0gnQb4xTRwbAu4H2do3MU41QWvOvw@mail.gmail.com>
References: <CA+5PVA4HVjsEw+j+HMDzO0gnQb4xTRwbAu4H2do3MU41QWvOvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2329807.jhdNh6WYTb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] ibss.c backtrace when batman-adv adds wireless
	interface
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
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Marek Lindner <mareklindner@neomailbox.ch>, netdev <netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Larry Finger <Larry.Finger@lwfinger.net>

--nextPart2329807.jhdNh6WYTb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 03 February 2016 10:24:43 Josh Boyer wrote:
> Hi All,
> 
> We've had a user report the backtrace below when loading batman-adv on
> his machine.  It looks like the cfg80211 layer is complaining about a
> null bss returned, but I cannot tell if the rtlwifi driver or
> batman-adv is in error here.
> 
> Thoughts?

About the attachment "batman-adv oopses with kernel-4.3.4-300+debug". Sorry,
this was my fault and caused by an copy+paster error while adding some
lockdep_asserts. This caused too many lockdep reports. It was fixed a while
ago upstream in 008a37448707 ("batman-adv: Fix lockdep annotation of
batadv_tlv_container_remove").

Kind regards,
	Sven
--nextPart2329807.jhdNh6WYTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWsjWPAAoJEF2HCgfBJntGXngP/1AnZSxN9oDkZmkDbanuHvdL
7JUaza7ghgK8Eofs6Hp5vIfJGTODpZeIQ7uvfZwj3/LWIxsil5PIrDSIfuwthJLA
FyU8JKLHezcZ0SPsK7oABtWREHdARTpe/EYngru6KWVpPTdK2Jscf1YEVGleqx7Q
UEHoKo09mYBrIL+9O+ekavLFC/O9PbsMuu2nF2W+0MKyXVB6TTE/4wF8ZBlS2BHp
VwFBilXmJAPtbs1Mo6M7gC9kCjoqWOHVT5S3ZHDqB839Y2XAiSLMJD28ck60n9zb
RbkxhQYwGGUxQ95OkGgzFtTbkG6NC3WWTckNUuoipn04ls7V2yJ9ZNIaxsQIcu3l
0w5M2ITBYF6Pvo2KUvOwy3xT+CNAXvzXh3ZeOQfMgYWfRP65qw5qjOxGc5DdFm+U
hOvmu6B01v27+vr9+KFEqjFUOYNgA4dY2fok6B8d3UmKmQwaDvuWk3880cO03Y5Z
spiIIqrutKpsziPnM98/F52E+aYssQuvBSHT5TatP1WWVOiCuOgHORJhejGCZHaN
4UmKYe00Eg1fAtemR33yHF+5VdJnohY2adAcMUU2dZ6uID39w60dIs1lb2DeEHdF
LRTWsnIYAJWv4UVOLEqMn1g+d/YuowgzmGrYUdvIPrydBlAeOJbEPmxdR15ZLdal
xBYGHhyjp43Vre/EiSVC
=66Fg
-----END PGP SIGNATURE-----

--nextPart2329807.jhdNh6WYTb--

