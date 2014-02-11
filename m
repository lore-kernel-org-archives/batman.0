Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA5928.2060505@meshcoding.com>
Date: Tue, 11 Feb 2014 18:08:56 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-7-git-send-email-antonio@meshcoding.com>
 <20140211165923.GD24633@lunn.ch>
In-Reply-To: <20140211165923.GD24633@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SV6uwhUlPqdLh8JuvDDQNSFqfV1INM0ta"
Subject: Re: [B.A.T.M.A.N.] [RFC 06/23] batman-adv: ELP - adding sysfs
 parameter for elp interval
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
--SV6uwhUlPqdLh8JuvDDQNSFqfV1INM0ta
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 17:59, Andrew Lunn wrote:
> On Tue, Feb 11, 2014 at 01:48:06PM +0100, Antonio Quartulli wrote:
>> From: Linus Luessing <linus.luessing@web.de>
>>
>> This parameter can be set individually on each interface and
>> allows the configuration of the ndp interval for the link
>=20
> s/ndp/elp

thanks!

>=20
>> quality measurements during runtime. Usually it is desirable
>> to set it to a higher (=3D slower) value on interfaces which
>> have a more static characteristic (e.g. wired interfaces)
>> or very dense neighbourhoods to reduce overhead.
>>
>> Developed by Linus during a 6 months trainee study period in
>> Ascom (Switzerland) AG.
>>
>> Signed-off-by: Linus Luessing <linus.luessing@web.de>
>> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
>> [antonio@open-mesh.com: respin on top of the latest master]
>> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
>> ---
>>  sysfs-class-net-batman-adv | 8 +++++++-
>>  sysfs.c                    | 7 +++++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/sysfs-class-net-batman-adv b/sysfs-class-net-batman-adv
>> index 7f34a95..2884c98 100644
>> --- a/sysfs-class-net-batman-adv
>> +++ b/sysfs-class-net-batman-adv
>> @@ -1,4 +1,11 @@
>> =20
>> +What:           /sys/class/net/<mesh_iface>/batman-adv/elp_interval
>> +Date:           Mar 2012
>=20
> Might make sense to update this to 2014?

I kept it as it was when the patch got merged in our repo.
But I think it should match the month it gets introduced in the kernel.

Thanks=B2!

--=20
Antonio Quartulli


--SV6uwhUlPqdLh8JuvDDQNSFqfV1INM0ta
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+lksAAoJEEKTMo6mOh1V9hYP/3YLH72RvoVlN01mvoBDK3QF
/ZJmJUjg2zHfXP34XhU30mwzCnZ/yWt/b8ZCFELndD4rdzvTq0Oq3+pOMiWwz0h5
lGUUeetMp6xeC91SUg+h66U9rez7qUQDsjvUclzxqyOhDTF1InHM16WAM148hGpL
CXe9vbnRKKK8F4UpdxzGik+4+0Uu6tkUnyRXFg2HXhqPvWWtFCFGflSm/Rh+9hup
rjhnvuDqgN2rnuLNA5uRUzIFMV3Lie/tm+E6FFms0c1r+oDLkiwuT3Q0JDtIZrhm
REN+8QfHnBZbslVjroISUIp1hoq5K2k26oKiiuLxIsJ8g9ZIFIyWjG/SHeaQ0daI
SC/nOQ89FThvK2k+9H+EFlJS4ufKg2tC3HDNaxfvlVUV8LoSZcYm9H95sGE3Op+t
HojPhxFuEEILZigWHw7qJg7428yaGG+IhpA9LUPwuOnveRvglYDfjXccp9nteTs4
vyWnlj0QrbxAdzxG5vSYpNyiyoBC566tsEI8JUWa8hxbVNWZ1btFRE92sMiny+bm
7pQHuNhKyA49TgqjeA/MkgfzuQlA3B88AON/2AGqS15ovrcEln6Wu0H3nRQOmWDg
8W2dWJOrtFHsfwx3iqd0yzQcFhc27NR64IHpZINl7GgeRPYW2a+UxY8XArtR1Un9
b/roRcapFU0q2kwnbUZm
=lUWg
-----END PGP SIGNATURE-----

--SV6uwhUlPqdLh8JuvDDQNSFqfV1INM0ta--
