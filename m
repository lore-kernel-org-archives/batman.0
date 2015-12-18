Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Dec 2015 18:30:13 +0100
Message-ID: <3922831.NrCxltvcVr@sven-edge>
In-Reply-To: <CAKrZ8yffDYcr6UCw2Yv7hqUFEBNZQ+nTU09dovL=PO3+Zqy7ig@mail.gmail.com>
References: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
 <1911165.iLNu9IsRoq@sven-edge>
 <CAKrZ8yffDYcr6UCw2Yv7hqUFEBNZQ+nTU09dovL=PO3+Zqy7ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3415516.FVshsbqxkn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Super high package loss and weak connection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: no name <keinepostnurmuell@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3415516.FVshsbqxkn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 18 December 2015 18:22:40 no name wrote:
> I made a little table were I tried wheezy against jessy and 802.11 as
> someone suggested earlier in the mailing list to me. I placed the
> raspberries next to each other on my table and tested through different
> settings:
> 
> ad-hoc+batman-2014.X@debian wheezy:          1m distance  .. 200 pings, 0%
> paket loss, reply time -> (min,avg,max,mdev 1.2ms, 1.8ms, 6.4ms, 0.8ms)
> ad-hoc+batman-2015.2@debian jessie:             1m distance  .. 200 pings,
> 6% paket loss, reply time -> (min,avg,max,mdev 1.1ms, 170ms, 1400ms, 370ms)
> 802.11s @debian jessie:                                  1m distance  ..
> 200 pings, 0% paket loss, reply time -> (min,avg,max,mdev 1.05ms, 1.8ms,
> 14ms, 1.5ms)

Your "table" is incomplete. adhoc without batman-adv and meshpoint (802.11s 
without fwding+ttl=1)+batman-adv are missing. You also mixed two different 
batman-adv versions. Either you use the same batman-adv version everywhere or 
make sure that the kernel+wifi driver doesn't change. Changing multiple 
variables between two tests tests make the results more or less useless for 
comparisons.

Kind regards,
	Sven
--nextPart3415516.FVshsbqxkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWdEKlAAoJEF2HCgfBJntGiOIP/29tdf7gIpSdpi7xcU8CAAN7
eXuJ1zZXoLtSq2ucG2JyHuI3TshEHvkcUpAW8GpymGJxjbv8fOlZvueVXfrT+sJ0
uc9kcZJcCN9QlaPOuGxOi/WziVvyIQZkmGoAitY/HvT0ZodvHtdNOLtJMUbbH6hN
0KA3Nx27bJ4xhU2L2y3bDN44rn0nENcq9gU9SDbIC6tJOuRUN3rYaEMMP66066vL
Y0XWPmZ41LrGv8ewEt73iaWXerR9HnHcez0Criosb4DOLQC7HkJwYf0oo76CfRfq
AYxmvl1ijDugOav+/D9S8fluNa2SD1zLtgCdn7EGypPeHK3J12cwidttRnYHDaK4
BkPk1xo7y0CPtSkujpQF8Owyc/NNyq/Hr6niB04wmwMAJ9TpbRf/7h6yIILK25zj
CwBHLcXdKXnlFWUDfuWGPJr+QE1hOndS4bIo9mRM3g/K2UF6bARd9xhn1dCbBdgt
j3QtvFtG9gUVcOUGlOQeoBn4sVap8TB0h6baVykZFZeoDK0eDLtIIWPVbqfi/55E
R2uSc92wVoancuHTNjNJvGtLYfy9DzltIfWpe6RNjCOA1W20t/L9BxHiFqbXBzMw
E69A5AVaZ43Cp7esjZG13Eo52RIOFqDJTueBz200igOPjzOKaa+WkLCgoRyvFcfh
L7S/fjHSG9CBQpOYc98m
=5b2r
-----END PGP SIGNATURE-----

--nextPart3415516.FVshsbqxkn--

