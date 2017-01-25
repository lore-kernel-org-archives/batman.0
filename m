Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Jan 2017 08:15:52 +0100
Message-ID: <2528254.P9avF0yZu7@bentobox>
In-Reply-To: <ba5c036e-e34b-2b43-4df2-bc1c8883eedd@viisauksena.de>
References: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
 <2809895.eiDvevZ9tY@bentobox>
 <ba5c036e-e34b-2b43-4df2-bc1c8883eedd@viisauksena.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2768160.S9TBcQAzKK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] limit of if per batman
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: jens <jens@viisauksena.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2768160.S9TBcQAzKK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 25. Januar 2017 03:18:10 CET jens wrote:
> On 24.01.2017 14:39, Sven Eckelmann wrote:
> > There is no artificial limit added by batman-adv. But transmitting a lot of
> > broadcasts over 255 virtual links sharing the same physical link
> > might get interesting (independent of batman-adv).
> 
> this made me curious , and i modified your script a bit - turns out
> after the 127. IF you add to batman-adv you get an Error -
> all 510 gretap links was succesfully build ...
> # ifconfig |grep gre| wc -l
> 515
> # batctl if|sort|wc -l
> 127
> the error is mainly
> *Error - can't write to file
> '/sys/class/net/gre128/batman_adv/mesh_iface': Cannot allocate memory
[...]
> [113990.684947] [<ffffffff8107c16e>] ? __warn+0xbe/0xe0 [113990.684955]
> [<ffffffffc017a804>] ? batadv_orig_hash_add_if+0x94/0x140 [batman_adv]
> [113990.684961] [<ffffffff811a7b10>] ? kmalloc_slab+0x90/0xa0
> [113990.684966] [<ffffffff811e08c5>] ? __kmalloc+0x25/0x580
> [113990.684971] [<ffffffff815ef9d7>] ? _raw_spin_lock_irqsave+0x17/0x39
> [113990.684977] [<ffffffff81432c11>] ? _crng_backtrack_protect+0x31/0x70
> [113990.684981] [<ffffffff811e0ebc>] ? kmem_cache_alloc_trace+0x9c/0x540
> [113990.684986] [<ffffffff814340b7>] ? get_random_bytes+0xe7/0x1c0
> [113990.684991] [<ffffffffc017a804>] ?
[...]

I would guess that your system mostly fails becauseit  cannot handle the
allocation of the "large" arrays which store:

 * @bcast_own: set of bitfields (one per hard-interface) where each one counts
 * the number of our OGMs this orig_node rebroadcasted "back" to us  (relative
 * to last_real_seqno). Every bitfield is BATADV_TQ_LOCAL_WINDOW_SIZE bits long.
 * @bcast_own_sum: sum of bcast_own


Kind regards,
	Sven
--nextPart2768160.S9TBcQAzKK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliIUKgACgkQXYcKB8Em
e0ZVvxAAu3i5QHjBkCpiJMmswHHXhwJ1GyBVWSkneZuWFf5GJaSnKuiQiZ/GyH4L
lgZMvR6PG/WrUTk1KYXMvwG1CIQdg65TxFbwW7nx0Xkib5VZ6jEe36dtJecaV03Z
83HiFGw69xuUljUvWlqYoa00SktK7qua3Da8kGP/iDLQBNrZxfUkf3wCTz4/IPcX
R+5kWw5C6W0rSERKKvwptPwHUbOkkygTFyZlSKiHd54HKLS8Ur+HAahenn3qw7ct
gaNgq17hCpReZz8Obk3umzUSnKsKfOeuWj3XsoN2hB0p3Xht30pK+gk5rRGDimqu
9WGYmVolwA7jbZcd8W//71sdhDjEszwFHrNqcumJPaKVZn0jB7C0p1JCxX8TSsTd
xRfHkthopY0lRdmcEk/YhpoepvmLNZYW4SGpo7D97VQVJQzvZ88VPgj974cBfAT5
zPk98Yx8Hfztg6d4y5H5A5148kUfPo5s+imEpuSwJEBYVQ8ii9x7zlGlntJaa45L
zMHbeMjpPuxJo5xtDcCFGq537hjUqg+dcBlSojwZ0hbiDkbqHV7blzFluFuB11c6
mYonCw6ZhkGkA+Px4ssfBNv2yf+eZ+RM9YhBQWOk7WdpKSQhbXbhu4+qxd2IvI7h
74zl+3gt0QIhWH8aryAo1fOAjcENn63Kc0NjsM9BpUNuOdjbSes=
=Zx8l
-----END PGP SIGNATURE-----

--nextPart2768160.S9TBcQAzKK--

