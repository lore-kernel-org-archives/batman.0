Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52E5322D.60202@wirelesspt.net>
Date: Sun, 26 Jan 2014 11:05:01 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net> <86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net> <52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org> <52E51A04.8020800@meshcoding.com>
In-Reply-To: <52E51A04.8020800@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WuTvbBbxIUrbeH6pV6gr9FGR0ObLQsXXF"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
--WuTvbBbxIUrbeH6pV6gr9FGR0ObLQsXXF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Inline:

On 01/26/2014 09:21 AM, Antonio Quartulli wrote:
> On 26/01/14 13:57, Daniel wrote:
>> I now built OpenWrt trunk/BB r39365 with batman-adv 2013.4.0 instead o=
f
>> 2014.0.0, tried with all possible settings, no memory leak what-so-ove=
r, happy
>> uptimes of more than a day by now :)
>> all other system components and settings are exactly identical to my p=
revious
>> setup with batman-adv 2014.0.0.
>>
>> On 01/23/2014 04:35 AM, Daniel wrote:
>>> On 01/23/2014 01:10 AM, cmsv wrote:
>>>> what version are you using ?
>>
>>> out-of-memory every 20 minutes or so on OpenWrt trunk/BB r39365 on tl=
-wr841nd-v8
>>> with batman-adv 2014.0.0 from openwrt's routing feed with "batman-adv=
: fix
>>> batman-adv header overhead calculation" and "batman-adv: fix soft-int=
erface MTU
>>> computation" on top.
>>> A sample node is (occasionally) reachable via DN42 at 104.61.99.104 (=
feel free
>>> to ask for ssh or any kind of logs, serial access, remote gdb or what=
ever)
>>
>=20
> Thanks for testing guys!
>=20
> I found something wrong in the code and I am going to send a patch soon=
=2E
> I'd really appreciate if somebody could test it!

Will this patch also be relevant to attitude adjustment ? The reason why
i was if because with AA right now i do not experience the reboots.
I should also add that i am using mac80211 r39150 and hostapd r39155 on
top of the latest AA.

Can you explain in what exactly your code findings have an impact on ?

>=20
> Thanks!
>=20


--WuTvbBbxIUrbeH6pV6gr9FGR0ObLQsXXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS5TI4AAoJENmyd4cVxLOCeGAP/1DjFhq5KnnKmLcwgJpU+zAO
sJ6LCG8rAhewwE2W0crA5+wRY4nkk6vy7ZNEB31FECUgIugOSJEoKcFj1I1NGuAd
rtRtXq30ultaMHFkGRe5sJTSQ+zBxPdrRLdFaQ/1QsYBSJzBfnCN+KsblXJv6uVZ
d8PFfNf1pbUdKtqpjgeEpc4+clOatihGjOELeUKbiCIkeM1Tzm6uQIicckdrNb4Q
jrMrKfxS5OtYIEux+f9IoQbY5u+TxPM+xsOtoIVxe/GNmFtPGH+IiX53fZLrHYZu
3iLFdFr8OqDINDPwQvABSpyP8x+DDSsprWAM7GnwPtAVa7NoppGSJPYrBHtfMEsG
06ZIcMrTt9H0Ui2jawTGj0imwRnCCkvibxneblx8zYWrow3/+tt0jrEN9JtklRtP
MZ4VYiNV5OCwwy2QUnztLLPVeRTzf73hXSI5ZsAvjbvJETJPUc4QmAl0U1fuQOLo
0RnouTKxczGDO6ZhwZdgX0FO7m+Ib9AxM/bnqOxzVQegGebzfPNikOzY9t/mXhoQ
VPmX7tXtjVdAPRC/ro2VPXTmFoYQACIm2WeYdunDRn2iiZ1QKdjuDE09IooytLqX
X1LCPI8LbF1GwIh0q6iBpmUK1inOgL8cSNV1inVfBeZR/nV2q73YeMSzaCvhnp0R
SP+j+S+jpk9uuv5upb+p
=mJ5V
-----END PGP SIGNATURE-----

--WuTvbBbxIUrbeH6pV6gr9FGR0ObLQsXXF--
