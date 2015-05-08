Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 08 May 2015 08:33:43 +0200
Message-ID: <3376805.a4VXV4btx9@sven-edge>
In-Reply-To: <4837729.AoYrTN5tco@prime>
References: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
 <4837729.AoYrTN5tco@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2570888.rEQNEca43q";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] FW: using Batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart2570888.rEQNEca43q
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 07 May 2015 19:25:11 Simon Wunderlich wrote:
[....]
> There is another suggestion: You could increase the multicast rate to a high
> value, e.g. 36 MBit/s or even higher. Higher rates only work with good
> signals, and since batman-adv uses broadcasts (which is multicast for
> WiFi), this will have a direct effect on your network.
[...]
> Batman-adv is open source, and so is mac80211 and hopefully the WiFi driver
> you use. However, it'd really suggest to start with tuning the multicast
> rate.
> :)

I definitely agree here. This should tested before trying to hack the TQ
calculation with some own RSSI based submetric.

The mcast_rate trick is currently only shown in an old OpenWrt wiki page [1].
Maybe it should also be mentioned in the main OpenWrt configuration page [2].
I will leave this to the interested reader... or I will change it when I
have some time to confirm it with a current OpenWrt.

Kind regards,
	Sven


[1] http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config-sophisticated
[2] http://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config

--nextPart2570888.rEQNEca43q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVTFjKAAoJEF2HCgfBJntGC0kQAJJs1WyE9cbwcbPak8sHxS2q
faAtM0L5soFSFEaDbkmFRMSQdZtIUKksHU8m08IKfyUnuuQiTuBy2QvzMESD+DqP
malbLvAMkirozjFNfMG+znOCniq0uH+hpCJVVg3sRHuhUJmAYzU9Sc4F6YqdPxAK
73CeBjToHDioqEFR29ZH2EgUOTJKmApT7fXtiTO+6YRpM+LINnwtRKVhqtfAwfVx
I3FR+5PHjJ7bdDu/Qd6j30dDG6QEvS50ylCDnNz5eAoxCiAbaYrk57CU9Qy0TND9
z6LjKp9ttoFvM90h93vPVAbxPuo9Pj3WSevB3ld8Pwx6CRlrfUq8U4I0XHIUalcc
5E0xo/1+BNZSXr8ZORdpuhT52S/5fkQzAsZwG+N7DBVLKDdn7g36Aa4uxBFgXtoV
HkwG48Fdf2cA4lLfc5s4ogBxxElVGweOzHyiE/e717vDsQiQSe/HOBZSXSDsm2L9
pJMI826R7eR0njRuhImMT9z2bspVmwM2E4t1Fr63aUu0k8Sgee0qQwhYtoZfAJz/
W8qCBBIVbtnKqms8RMUoVwHTKDrFr4GMIzgG5+9ppHi/P+RXoRrPJ+SyxWqqjg68
3femZr3Fe5p4Xt1g2TKlYs19UsqmPO3RSfIBkZEJiEfLoCChyB2A3km1XX55yMqB
LKbKJ/3KFT3EqWDB0Tc8
=MMNt
-----END PGP SIGNATURE-----

--nextPart2570888.rEQNEca43q--

