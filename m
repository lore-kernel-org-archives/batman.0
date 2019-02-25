Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 25 Feb 2019 08:35:52 +0100
Message-ID: <2667717.mmYbNj13ue@bentobox>
In-Reply-To: <037B7BA7-8D64-4B46-BDA8-C4D45AC9E61A@altermundi.net>
References: <20190224165113.15726-1-sven@narfation.org>
 <037B7BA7-8D64-4B46-BDA8-C4D45AC9E61A@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6602972.0pSBhlhQLQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC openwrt-routing] batman-adv: Split batadv
 proto in meshif and hardif part
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Gui Iribarren <gui@altermundi.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Matthias Schiffer <mschiffer@universe-factory.net>, openwrt-devel@lists.openwrt.org, Moritz Warning <moritzwarning@web.de>

--nextPart6602972.0pSBhlhQLQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 25 February 2019 02:24:56 CET Gui Iribarren wrote:
> have you considered, to simplify backwards compatibility, to keep proto 
> "batadv" as it currently is (hardif) and naming "batadv_mesh" the new proto?

It was one of the goals to *not* name the batadv hardif interface proto 
"batadv". And I wanted to have the batman-adv interface proto named "batadv" 
because this is the rtnl kind string. So you actually create batman-adv 
meshifs using:

   ip link add dev bat0 type batadv

But we can call this proto also "batadv_meshif" if there is a strong 
preference for this name.

Kind regards,
	Sven
--nextPart6602972.0pSBhlhQLQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxzmtkACgkQXYcKB8Em
e0aBpQ/9EKLR2ZG1gCzAX6z6YvjVJUFMcRXaDw8gS0GX6bcpCdCbHmp073V2zV9u
ZjX70s/kQ+4lAmcKVFFFiRhyNidgTmXbioFuP3yxKQqbjLJBZn9xy7TGHQAFEUGf
W5/dZvcvXggdm8tTQQ86ofcUREQK/RWeJebO6oFFln4pDPViA8wzC/rjl2y8gtEI
dd4Fj/+56Vyn+5snhhlsiCC7AIdN0qUqAFydmdQ5g0u3yh6iwgkLgN43qjKhwCow
sC0CfycUAnnG7wmtB62otNf9TPF1YQP+2cw7xGHwBQaGJJushdAMlRd22yAkMgeA
pSVjAa0q+VfA+2+gMF4UfAUI3FXrGZ6Ge+w1atWeJzswQ/bWJ73ZF4i6W8LvdCmL
ds5lYFa/J38t4mSYc8zyx/g3pOGIPuIt269qddElkJgh9WeMiqm9w/dosBXGzMtG
dRnn60CEXwDClcvd8LjRtZhGyQQJIiTTM3vWJVdadz7lQa8HbZkxI3OByv9L7eFo
JfeoI0JCOqeC2o6YZ/CAnXT6kb1VQBv09FfXz/7gQPEZ+AG1ThhJzTC6uF+PqJES
0piNFD3MnT/QQJgOhrCMHL+UEQN9Drm32ZiKhbhr+/qi0oOfptBdV31p9QHN4cKE
1qqQHy6vVsfM3fo9MQ0HyYEFoBR+VbiELUJ5UZPjJagd7oNSf1w=
=PDe6
-----END PGP SIGNATURE-----

--nextPart6602972.0pSBhlhQLQ--



