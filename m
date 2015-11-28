Return-Path: <antonio@meshcoding.com>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <1448305042-5806-2-git-send-email-sw@simonwunderlich.de>
 <56591657.6070401@meshcoding.com> <8889525.bHy7H9IMLu@sven-edge>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <5659A497.1070805@meshcoding.com>
Date: Sat, 28 Nov 2015 20:56:55 +0800
MIME-Version: 1.0
In-Reply-To: <8889525.bHy7H9IMLu@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OKMMbxJfdGb5XjVxXtjAdsHg4ew7MC2W9"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when
 doing mcast_free
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Simon Wunderlich <simon@open-mesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OKMMbxJfdGb5XjVxXtjAdsHg4ew7MC2W9
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



Sven Eckelmann:
> Maybe the relevant parts of the Oops can be added to the commit message=
:
>=20
>     WARNING: CPU: 0 PID: 238 at net/batman-adv/multicast.c:142 batadv_m=
cast_mla_tt_retract+0x94/0x205 [batman_adv]()
>     [...]
>     Call Trace:
>      [<ffffffff815fc597>] dump_stack+0x4b/0x64
>      [<ffffffff810b34dc>] warn_slowpath_common+0xbc/0x120
>      [<ffffffffa0024ec5>] ? batadv_mcast_mla_tt_retract+0x94/0x205 [bat=
man_adv]
>      [<ffffffff810b3705>] warn_slowpath_null+0x15/0x20
>      [<ffffffffa0024ec5>] batadv_mcast_mla_tt_retract+0x94/0x205 [batma=
n_adv]
>      [<ffffffffa00273fe>] batadv_mcast_free+0x36/0x39 [batman_adv]
>      [<ffffffffa0020c77>] batadv_mesh_free+0x7d/0x13f [batman_adv]
>      [<ffffffffa0036a6b>] batadv_softif_free+0x15/0x25 [batman_adv]
>      [...]


I agree

>=20
>> I see it calls batadv_tt_local_remove() but this does not really
>> requires the lock. Maybe you wanted to perform *all* the removes befor=
e
>> TT could do a commit ? Or is there any other reason?
>>
>> Cheers,
>=20
> mcast.mla_list is protected by tt.commit_lock (see batadv_mcast_mla_tt_=
add,
> batadv_mcast_mla_list_free and batadv_mcast_mla_tt_retract).
>=20

ok, this makes sense :)

Simon, I'd suggest you follow Sven's suggestion about adding the
oops/stacktrace and then you can also append my

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

note that this patch is a bugfix, hence it should target maint.

Cheers,


--=20
Antonio Quartulli


--OKMMbxJfdGb5XjVxXtjAdsHg4ew7MC2W9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWWaSbAAoJENpFlCjNi1MRAEIP/j+j/DuVR7QbnaZV+jM3QURT
1KsnLBHihPQm3VZ0a20hT8LXmB/UEN4T5IEmOic0Kzedw5mvJEnFb8/lqxuplbAk
KFlbw43VKhtM+D+5O0QoddyOI/X3P92ymW3eoucu5WL5yIM3zvncf4G7ywYHwT4W
jwzVJsXi9mSAm7wfYKxYI2IYXo/3mm6Rxkw3v7ziaXqS7pw2WR6IVz6y71QYx5X6
QtEfs5ZJdRgfZiSNYq8Pamy8SK0RdfHtP2cxgKheE6K2q/r8vE6GffwK1YFsj6xL
HzW7c4r1YfU9M/+uOb7TbNFr/YpYAsmjySmxrDhQ8USbRAgs76JgYKqrIMHVl3Al
9Vvp5jiXy2CseTjwkzFr2UAgb3Q4VSmVasZ2Fb5gVv4YJC8LcUC2vWg4tIQpPLOt
jab8eZiZhzm21z2o5RF0UD1fCuWlW8mL8HAHNx84z8EIYrZpEsSTOV1EuHX3BwdG
s4wkxmj8s/iZU6aq5AdA6kc3TIqxsBeoQ+kuYk99R+LQJ8LX/XEuBE0Ds+KuTShy
HgToVXwcOA5fJjP5Vsb1/AvSkwgMcVvPewmwXw5oL/Z1yY4jWYdOpSqIRIexn9g9
2AQCWCJjR/TCUxibUCVj6VpviYVNYQZaRcUjwxQ+L5A5DVysG7IAEXBimDJsCQed
Htv3sA1abXdL1S04TWiw
=yebS
-----END PGP SIGNATURE-----

--OKMMbxJfdGb5XjVxXtjAdsHg4ew7MC2W9--
