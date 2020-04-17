Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: batman cpu usage of multiple instances
Date: Fri, 17 Apr 2020 07:51:17 +0200
Message-ID: <11503500.qvHmQplXmE@bentobox>
In-Reply-To: <97bf748d-16e5-d088-118f-6f3678300191@web.de>
References: <97bf748d-16e5-d088-118f-6f3678300191@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8969437.ebcY6J3fPl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart8969437.ebcY6J3fPl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 17 April 2020 03:23:23 CEST Moritz Warning wrote:
> I have many batman-adv instances (~1000) running on one computer in a Linux network namespace each.
> 
> Top shows me that a single kernel worker is handling batman-adv:
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> 29251 root      20   0       0      0      0 R  99.3   0.0  18:03.27 kworker/u32:3+bat_events

This bat_events is mostly for sending the OGMs/ELPs/BCAST-retries. Usually not 
a bottleneck but your configuration is rather special and thus can be a 
limiting factor. 

> Is there a way to let those multiple batman-adv instances make use of the other cores?

A quick way to change this is to go to batadv_init in net/batman-adv/main.c 
and change the create_singlethread_workqueue() call to create_workqueue().

Kind reagrds,
	Sven
--nextPart8969437.ebcY6J3fPl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6ZQ9UACgkQXYcKB8Em
e0YdKw/+M28sadML36PaWo1WyMzyh6EblDTVPzRc3diBGVEF9ZTKSrUuykGhtK+6
Yicz7D5QPPztLyrdlElTjS7Vf1E3qaJOpA/yo74hEcKXV+H6fQmF9C+ysFFEWskY
V4PCVMGczm+c9okkkLDg02vKNqtVIBILsy8gGm+6C/us1LrZey4QHdVSnq4bkDwh
T81lssjXG/KgQgaRK1syfaoOzlJRO5gNgl0U23daelsWXQP+vaKeeZflHvuKSgsK
Yx3OF9ROywqM/eghlSa4137QdTqJtutFOTGMng1nojZeflUzQ8Z+sqtmOFI85Oyf
vkNuECBOlDGP85eT9yLip7fIMnJLNhavkvc8bW5hne2USLWI/W843zu9NMZFzRvc
9W+VARPqKVGJ5TiqB3L5k2E2miXSBGvB4AmYa3h/ba88IMGAZFHP7Lx4KJzVDyLn
fT2Hq0sZ9BQocTRV38pjd+rfQvhFQwyPKcCNvUS3DoH9DjzHXwAJh5r5BFLDf6Af
s1FhyUxQxWI4HfMff2qskETwWpiHqNzjGSNjOOUgnwFBzYhhJp4lp7NgI5Km2vun
5ggCgDk1ffVh5mNy/6X6V1g7XE+ILtp7G/Q1IMbpY7cHulzee15Ne8rWZf+WGiC8
wDnmEBHgWCux9cQNCK0s9TbzeB2NhkRwTJlXvQP/QZlQ4En5Sgs=
=8bXF
-----END PGP SIGNATURE-----

--nextPart8969437.ebcY6J3fPl--



