Return-Path: <antonio@meshcoding.com>
Message-ID: <52E51A04.8020800@meshcoding.com>
Date: Sun, 26 Jan 2014 15:21:56 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net> <86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net> <52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org>
In-Reply-To: <52E5063E.3080408@makrotopia.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hDWWdIfsMOUNd8skBmKNC3eB6GBkFMJui"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDWWdIfsMOUNd8skBmKNC3eB6GBkFMJui
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26/01/14 13:57, Daniel wrote:
> I now built OpenWrt trunk/BB r39365 with batman-adv 2013.4.0 instead of=

> 2014.0.0, tried with all possible settings, no memory leak what-so-over=
, happy
> uptimes of more than a day by now :)
> all other system components and settings are exactly identical to my pr=
evious
> setup with batman-adv 2014.0.0.
>=20
> On 01/23/2014 04:35 AM, Daniel wrote:
>> On 01/23/2014 01:10 AM, cmsv wrote:
>>> what version are you using ?
>=20
>> out-of-memory every 20 minutes or so on OpenWrt trunk/BB r39365 on tl-=
wr841nd-v8
>> with batman-adv 2014.0.0 from openwrt's routing feed with "batman-adv:=
 fix
>> batman-adv header overhead calculation" and "batman-adv: fix soft-inte=
rface MTU
>> computation" on top.
>> A sample node is (occasionally) reachable via DN42 at 104.61.99.104 (f=
eel free
>> to ask for ssh or any kind of logs, serial access, remote gdb or whate=
ver)
>=20

Thanks for testing guys!

I found something wrong in the code and I am going to send a patch soon.
I'd really appreciate if somebody could test it!

Thanks!

--=20
Antonio Quartulli


--hDWWdIfsMOUNd8skBmKNC3eB6GBkFMJui
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS5RoHAAoJEEKTMo6mOh1VHtUP/0v7Ijkp6BsQAERgSipLXcH8
zFDg7OvpW/gtQ8Kp3ebT/uPQEOkku3BfEoOyVoUK/k56lRI/1DToOK/kR/1te1op
TlaKJ3knj3qth6Z+QyupXopx95tnupBx/nqLqAxnRQmM7UeJ1shfq4lIDYPBlc2O
DINOjWWnFMTL9uDjrWakpMHHEmxwgxUO2C+UluoEOWoH2ZZEeSFAg5caZW7vyxcB
c4ELSPrGqSlplHME/8ovEvpwo5dL4lwjHitkZpPc1oRhsb6p94xV5c72mUVI/+BY
mlaIIZGvXeHIHJYArj0MIQfkq7UNdoX6MFNu9AYy/XOVI4H27hv1yfYlrLXmIr6f
kb6SabHBnVdfgcO9NVTio44IxPpRHAYK/u2FXXG4yNa4stjx0sS+23B9xNvQQvC6
AGSAhT+k7qAFK56KIODztfSDvluACp+EZi7kDYxfst/59eHN5cW16GRhsyf2L8gn
xYvJbIU/CunGbno7ACOlyHbcLamc/6b70rn4TyOmStdA0DmQ+bPzQuKJfVy+Xueu
6JLLmZTZR7WDw28NapLowkBEC9xplyDeioxmZ4zbhGrlpoVY7M47FwNnib2gbci/
WZk3yMGpGizRj9F5AMsnIRWGXY15F8qSFr+vTf0Kcpqr9UHR+LCDHw8Iqxl8cQPo
E5eofSLMZKa9o4Awxyb7
=gQ/W
-----END PGP SIGNATURE-----

--hDWWdIfsMOUNd8skBmKNC3eB6GBkFMJui--
