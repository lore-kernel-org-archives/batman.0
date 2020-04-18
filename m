Return-Path: <moritzwarning@web.de>
Subject: Re: batman cpu usage of multiple instances
References: <97bf748d-16e5-d088-118f-6f3678300191@web.de>
 <11503500.qvHmQplXmE@bentobox>
From: Moritz Warning <moritzwarning@web.de>
Message-ID: <6467ca72-a8af-0a85-f490-57ffe4763794@web.de>
Date: Sat, 18 Apr 2020 09:49:05 +0200
MIME-Version: 1.0
In-Reply-To: <11503500.qvHmQplXmE@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JnHHbHhz9FgtcIuX6bkVjxE0Bu3ikfgk4"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JnHHbHhz9FgtcIuX6bkVjxE0Bu3ikfgk4
Content-Type: multipart/mixed; boundary="gKXBTivO4fyTsNeSiv0uVJVSZ552Rhzt7";
 protected-headers="v1"
From: Moritz Warning <moritzwarning@web.de>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <6467ca72-a8af-0a85-f490-57ffe4763794@web.de>
Subject: Re: batman cpu usage of multiple instances
References: <97bf748d-16e5-d088-118f-6f3678300191@web.de>
 <11503500.qvHmQplXmE@bentobox>
In-Reply-To: <11503500.qvHmQplXmE@bentobox>

--gKXBTivO4fyTsNeSiv0uVJVSZ552Rhzt7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/17/20 7:51 AM, Sven Eckelmann wrote:
> On Friday, 17 April 2020 03:23:23 CEST Moritz Warning wrote:
>> I have many batman-adv instances (~1000) running on one computer in a =
Linux network namespace each.
>>
>> Top shows me that a single kernel worker is handling batman-adv:
>>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ C=
OMMAND
>> 29251 root      20   0       0      0      0 R  99.3   0.0  18:03.27 k=
worker/u32:3+bat_events
>=20
> This bat_events is mostly for sending the OGMs/ELPs/BCAST-retries. Usua=
lly not=20
> a bottleneck but your configuration is rather special and thus can be a=
=20
> limiting factor.=20
>=20
>> Is there a way to let those multiple batman-adv instances make use of =
the other cores?
>=20
> A quick way to change this is to go to batadv_init in net/batman-adv/ma=
in.c=20
> and change the create_singlethread_workqueue() call to create_workqueue=
().
>=20
> Kind reagrds,
> 	Sven
>=20

Thanks for the idea, but it turned out to make the situation slightly wor=
se.
While bat_events is only consuming very little CPU resources now,
now the ksoftirqd/X instances take up 100% of each CPU thread.

The maximum of traffic is generated at 170 nodes producing 14KB/s traffic=
 send per node,
which is much more than expected. This is a grid of nodes, maybe a differ=
ent topology will do better.

I am open for new ideas. :-)

Thanks,
Moritz


--gKXBTivO4fyTsNeSiv0uVJVSZ552Rhzt7--

--JnHHbHhz9FgtcIuX6bkVjxE0Bu3ikfgk4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBtNBFtOYRL0Whm9U5yAWyf8FrDwFAl6asPkACgkQ5yAWyf8F
rDyhBhAAvSPJ1KdnpWnRd2arzivhUpVRfdszYqVLxdjs9YFoy4ECldyprJ2o7/bd
+hEhiE/D5SNkELsgMER6iOXISWoXhWP9mC1MSzlJBytXe0PDoht0KGEK4PphqIFE
xRQVeKFjCbgBa/ukP3P3cDjEs2NFjtrrKvJ7ZYUZZ4DnDPXE54gObsTSd9k4tG9e
QYp54S21sr6J8QEB7Wt39KRQKhZ6977nkbK6hKCdnnoD3jUBOYIrhZM/+plsdoAM
f0Ys9aVjBE+baFKZtJEuZZyF4jCbgHadA0L5HFEVnUcQq2dVJkXanMcOKTQbgUxr
AtWBdlrMsm6ob2CRqf7HC94H3IKgmCLR8Adj1pZTlzSmH82IwGWliW7hIuuNheLI
z7cFghhoNVM1tL1gdyOn2EvkmKJf1ol7Q1cYKDfobqGJR1rx0346U4mKLKDxo7dv
14IqjEKKWjvCGr/k6UH0K60L9dEvnWdnG7a89DnwaKUXP0mwa7/+OR3nwoQPa/T8
m/lOOh5W6zdbPAYkOMU2WnTDAITf/TGoPynKF/Ec72x2JcC1Fk2K5r1f6im2uqJA
66XGOEYq5Jy/Qf8Tfkx89qOMs7pXOHy/fBhY/0wZgiXXXDjzLbrQI68hhpm/Q6U7
4nSjomeKOhiRj8okTvnm0B0G+kE3DPdz/jYVojg+IA+Si2MWEw8=
=GLxn
-----END PGP SIGNATURE-----

--JnHHbHhz9FgtcIuX6bkVjxE0Bu3ikfgk4--
