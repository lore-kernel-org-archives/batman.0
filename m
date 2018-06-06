Return-Path: <a@unstable.cc>
References: <20180605183131.4989-1-sven@narfation.org>
 <1581047.jmAOXYUeYu@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <459d2f8e-6631-d616-9daa-a706c2878789@unstable.cc>
Date: Wed, 6 Jun 2018 12:44:32 +0800
MIME-Version: 1.0
In-Reply-To: <1581047.jmAOXYUeYu@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WmwQi9gqGCeCXP54Zz5iVSuQAwXLJIwQV"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Initialize memory for
 station_info
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Thomas Lauer <holminateur@gmail.com>, Marcel Schmidt <ff.z-casparistrasse@mailbox.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WmwQi9gqGCeCXP54Zz5iVSuQAwXLJIwQV
Content-Type: multipart/mixed; boundary="rCi4ZlIMLB5rfujHFaBEOS5ENsqO6GKxE";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>
Cc: Thomas Lauer <holminateur@gmail.com>,
 Marcel Schmidt <ff.z-casparistrasse@mailbox.org>,
 b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <459d2f8e-6631-d616-9daa-a706c2878789@unstable.cc>
Subject: Re: [PATCH maint] batman-adv: Initialize memory for station_info
References: <20180605183131.4989-1-sven@narfation.org>
 <1581047.jmAOXYUeYu@sven-edge>
In-Reply-To: <1581047.jmAOXYUeYu@sven-edge>

--rCi4ZlIMLB5rfujHFaBEOS5ENsqO6GKxE
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/18 06:01, Sven Eckelmann wrote:
> Hi Antonio,
>=20
> On Dienstag, 5. Juni 2018 20:31:31 CEST Sven Eckelmann wrote:
>> cfg80211_get_station is not initializing the memory given as parameter=

>> sinfo. The caller has to handle it. Otherwise the filled parameter may=
 be
>> set incorrectly and thus uninitialized memory is used to identify the
>> throughput to an neighbor.
>=20
> Hm, have to rewrite the commit message to something better. Maybe to so=
mething=20
> like:
>=20
> batadv_v_elp_get_throughput is calling cfg80211_get_station with a poin=
ter
> (sinfo) to some uninitialized memory on the stack. But most of the
> implementations behind cfg80211_get_station will not initialize sinfo t=
o
> zero before manipulating it. For example, the member
> &struct station_info.filled is often only modified by using a read (of
> possibly uninitialized/random memory), an OR operation and then a write=
 of
> the new value back to the original memory address. A caller without a
> preinitialized &struct station_info.filled can then no longer decide wh=
ich
> parts of sinfo were filled in by cfg80211_get_station.
>=20
> The caller of cfg80211_get_station must therefore take care that sinfo =
(or
> at least sinfo.filled) is initialized to zero. Otherwise, the caller ma=
y
> tries to read information which was not filled in and is therefore also=

> uninitialized. In batadv_v_elp_get_throughput's case, an invalid "rando=
m"
> expected throughput may be saved for this neighbor and thus the B.A.T.M=
=2EA.N
> V algorithm may switch to non-optimal neighbors for certain destination=
s.
>=20
>> Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on th=
e estimated throughput")
>> Reported-by: Thomas Lauer <holminateur@gmail.com>
>> Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
>> Signed-off-by: Sven Eckelmann <sven@narfation.org>

This looks fairly reasonable and at a first glance I can confirm that
even ieee80211_get_station() does not clear it up before filling it.

However, what do you think about zero'ing the sinfo object directly in
cfg80211_get_station()?
I think it is safe to assume that no user should store anything in this
object before passing it to get_station().

At the same time future users of this API won't be able to hit the same
issue we just did.

(At the moment we are the only user of this function in the kernel,
therefore changing its behaviour now might still be an option)


Cheers,


--=20
Antonio Quartulli


--rCi4ZlIMLB5rfujHFaBEOS5ENsqO6GKxE--

--WmwQi9gqGCeCXP54Zz5iVSuQAwXLJIwQV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsXZrAACgkQB6U8WA7y
zXRACBAAj6csPanbeeZi7kSa712lZRVOpAjHQpr1poLuRmXV1OcGxOOqdkdql6H2
RoZQtea42yrhFZ+1ylBXB2lq67eE+nAaBwdrFBoXIgeKBkov3CKkJnUI94tXMydL
DOLn9eAiJNfSCm8RehXHA5Pf4tvdsqYvrqF+RjSBlVkbU5bR2zWV5UVbgCjsz9VH
GxRJZ6JcDDBzuxQrZJjQQZmr2FgQPVTKWSkk3FLYIeaoYCS7Ebh7Qg2n7SzBGSP6
S8xFGUv5QrEcS8RjKqoQTUso5I7FJfyYoQ8o7fiff1wf1kPUxhqYPc9W+itF5NV5
kD6sJCLsVInL2V194XEksFcd6BNKDgS7ZzuGZu2b8XjRusNwMopC7MpVTOdh4U/M
pZCqUxCaYDrhdHQNJDxLiv2dazFjakcTM2ghGvbxHPXKWgXW4EpZoPzXC/zy8wMX
xxuPXiNeq4ssedKMbm/lPZAXyAOxdCxLQAWSCPiW1SA2DB+iQHuVOcFKJ1L2v9zM
aYitNe7Pi94NBeq4T7eChtnQ4n+MLmDR5bNi6OyQnNORH7bKZiFV6NshicJsunSl
LhSSC9iKsbS/uby8mo7tMT5N4M77qDTOCcXY21r6Dqvqa7r/0NIb97PSZbELhdHO
0a5NxCXa6/+d9PIgSmSJYQHY+tyhCG0ZULm0b75tMvn8rq54THI=
=gmuM
-----END PGP SIGNATURE-----

--WmwQi9gqGCeCXP54Zz5iVSuQAwXLJIwQV--
