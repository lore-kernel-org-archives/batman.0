Return-Path: <a@unstable.cc>
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
 <3604216.NcQoz811mF@rousseau> <20190210150959.GD1477@otheros>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <497454a6-ed48-2e48-2508-056147447c42@unstable.cc>
Date: Mon, 11 Feb 2019 08:21:22 +1000
MIME-Version: 1.0
In-Reply-To: <20190210150959.GD1477@otheros>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DfSkZ4yfYF7cflQiPoi5jPn5dN188TyMn"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on
 DAT DHT candidates
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DfSkZ4yfYF7cflQiPoi5jPn5dN188TyMn
Content-Type: multipart/mixed; boundary="7eb7fRGcRivjzseNqnc28PD9vi1BG5IqD";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Message-ID: <497454a6-ed48-2e48-2508-056147447c42@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Increase purge timeout on DAT
 DHT candidates
References: <20190111210208.29139-1-linus.luessing@c0d3.blue>
 <3604216.NcQoz811mF@rousseau> <20190210150959.GD1477@otheros>
In-Reply-To: <20190210150959.GD1477@otheros>

--7eb7fRGcRivjzseNqnc28PD9vi1BG5IqD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 11/02/2019 01:09, Linus L=C3=BCssing wrote:
>> Furthermore, don't jiffies overflow at some point on some architecture=
s ?=20
>> Initializing a jiffies field with 0 appears error-prone.
>=20
> Hm, good point. Assuming 32bit and 1 jiffy =3D 1ms it would overflow
> every 49 days (2^32/1000/60/60/24). The time_before() macros
> should accomodate for that (as long as the value to compare with
> is < 49/2 days apart?). However you are right, the 0 value would
> probably lead to faulty results for 49/2 days then...
>=20
> Anyway, removing that new timeout thing should fix it, as
> last_update is always initialized with "jiffies".

+1

the problem is on last_dht_update that gets initializes with 0 (for
locally cached entries).
If you agree on removing it and using a bool (I like this idea too!),
the overflow problem should be gone.

Regards,


--=20
Antonio Quartulli


--7eb7fRGcRivjzseNqnc28PD9vi1BG5IqD--

--DfSkZ4yfYF7cflQiPoi5jPn5dN188TyMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlxgo+UACgkQ9FVsWUWD
Dm3o9g/+K2N5jZfXzshzcFrlYoRJBYl2uBp7uO+cyHqPEX48Ndvd4KlFMOBCWNup
3ZYQD2Hz2iqIYaCvsNwoL7nvAv2j2RMU3Nu/HE7mfoFZD8zOa/myYJmEA4XLL3zw
JhJ1//qFJPATcT87G5ybvnhBBoXjHES8KNc/R1OZvXAxdeyQpwUdDzap+DMfithx
4x4OhyMXngyVL88JmKpt+52mGNQDV5k54KarI1wjvo7luKkLWradHlqHASHesjCM
451Gn+u0VK1NnZBuyj/4KRYd4YcjdnvYoajurQpiOwnHgdAS8Ol/QY7AOCOHZKXa
HbzGvqZj2C6REzjVCWrqepuEBSGiRsDIXWk0Bid/WQwyHwSMzQxeVWJRqX6sEceF
nUvRqLp3DnQO59IHz6FiphXn1VoCglPOklKhcXwvamsaL030HCkC+WNh7P7SHO+T
a3RbYvru/D9EtHjQb8EiSdOpD5IIEH3gPzKGLcE9aWkEKKk6clM0VXpqJZXam9YI
mzYWgkEwG4mU4qHriZuK9UBNrlB7H6Do7swtUzkiLAXyEq0a+AdmhckAs/HemZ9S
pSQqcJ5Sr9fD5sxZTBXiQyTB8o9q7efz2Ca52huXKVP6Uu3HqwCZ2zfcqafdHUHr
eOCga9FjTkuU9AQxCWg6VEbegIm/aT25ynzNDSywNdH9rUvLu1g=
=w4pH
-----END PGP SIGNATURE-----

--DfSkZ4yfYF7cflQiPoi5jPn5dN188TyMn--
