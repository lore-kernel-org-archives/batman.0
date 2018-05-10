Return-Path: <a@unstable.cc>
References: <20180506195559.32602-1-me@irrelefant.net>
 <2915136.3Ycz4JW85f@sven-edge> <1896302.CpHabpdRIs@sven-edge>
 <2913969.huEjgAY5Wz@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <e46dacd0-0b26-3d5a-3fc4-f15bec1da336@unstable.cc>
Date: Thu, 10 May 2018 17:12:56 +0800
MIME-Version: 1.0
In-Reply-To: <2913969.huEjgAY5Wz@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t9xZNgW7wk844Y2jXxyLJQq6WePIbhIuv"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: prevent TT request storms by
 not sending inconsistent TT TLVLs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t9xZNgW7wk844Y2jXxyLJQq6WePIbhIuv
Content-Type: multipart/mixed; boundary="9Kyk4bfUOhJuKfomvN2GSh1RNeomTxwFf";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <e46dacd0-0b26-3d5a-3fc4-f15bec1da336@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: prevent TT request storms by not
 sending inconsistent TT TLVLs
References: <20180506195559.32602-1-me@irrelefant.net>
 <2915136.3Ycz4JW85f@sven-edge> <1896302.CpHabpdRIs@sven-edge>
 <2913969.huEjgAY5Wz@sven-edge>
In-Reply-To: <2913969.huEjgAY5Wz@sven-edge>

--9Kyk4bfUOhJuKfomvN2GSh1RNeomTxwFf
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 10/05/18 04:38, Sven Eckelmann wrote:
>> Let me rephrase that: Are we sure that this is from intermediate nodes=
 or is=20
>> there still the possibility that it is from the actual originator? Reg=
arding=20
>> the latter: Should batadv_tt_prepare_tvlv_local_data be modified or wi=
ll you=20
>> wait for Leonardo to debug why it happens in the first place?
>=20
> Wait. When it is a problem of an intermediate node that doesn't have (f=
or=20
> whatever reason) not a valid copy of the entries, shouldn't the interme=
diate
> node just ignore the request and not answer it? Otherwise the next OGM =
with=20
> the data from batadv_tt_prepare_tvlv_local_data from the actual node wi=
ll=20
> just trigger the next request by the receiver.
>=20
> And the next thing is that your commit message is talking about OGMs al=
l the=20
> time. But the OGM TVLV are not filled by the=20
> batadv_tt_prepare_tvlv_global_data but by the=20
> batadv_tt_prepare_tvlv_local_data. I am unable to find out what you act=
ually
> doing here and why you do it.

I believe batadv_tt_prepare_tvlv_local_data() was the actual function
that Marek wanted to modify. But we probably spent too much time digging
into translation-table.c these days and I managed to confuse him enough.


Thanks for pointing this out, Sven!


Cheers,

--=20
Antonio Quartulli


--9Kyk4bfUOhJuKfomvN2GSh1RNeomTxwFf--

--t9xZNgW7wk844Y2jXxyLJQq6WePIbhIuv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlr0DRwACgkQB6U8WA7y
zXTjvg//RiwLrrlJUG+wxc6zULmSjvUPQD9E2NBQ8hdlPji0qIkSbWw6hZClyx+5
21dsLIe8HCiNfEBDWWzzpty/XEaN+pFOtIcSBAejhG+TRRdX53yDt2SGK3n+jZfd
rdWb2BVkOR/TwrpQpy0192sucHfNKldgkBZz6nrLHgvN4Kc1N7Q3ikhriGFt1hKF
hIxI43+8psiTRIzU5A5+ate925SdCq+ANwlYEJrViproxhnUY9hCWGpGcP1PJZgg
hyoIo1JhVztgFTs18ywyq3ebeSR53tEVdn8xay3pCkXUiTq/sNxMY5npFN7sulDy
+fZfZPCAvIe6m1ZrFEaWjYEJ9al/zlRrQcpnUCTPV2l9iRqnt1eQC9PDiTvRdMlv
E41IBWCouzdyWYlgN4yg60gogbfliqkMGUZhPckk0oshAFeB04/mBgVrfD2swtnJ
TeCV3YZVaUcbEonkuktebF/iJbcV9HMzacWcfizVuF6UUYc0lgDD63sFYoRqUvVh
5FpCYMo3/FvLFlUUMnx7QAscgFW0iA3+TX8varhD5WCTwWdxumq1JmOe6NSxVZxx
m6+oQpndDolUClWYkkMFab+j26B8Fiu6NhDZWPTgW6CMg9TvLr2zIWyuMgY2GwyT
ZaTeOlL5r7+d2G9rN9ZeRAr4ci2fIRBrmY/FpDKNgl2fZtTv6dY=
=8lf7
-----END PGP SIGNATURE-----

--t9xZNgW7wk844Y2jXxyLJQq6WePIbhIuv--
