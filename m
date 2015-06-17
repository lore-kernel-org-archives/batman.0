Return-Path: <antonio@meshcoding.com>
Message-ID: <5581911D.1020604@meshcoding.com>
Date: Wed, 17 Jun 2015 17:24:13 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434542995-22376-1-git-send-email-mareklindner@neomailbox.ch>
 <558169C5.7050700@meshcoding.com>
In-Reply-To: <558169C5.7050700@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SgmxhEDNSf4qJUrpimkQL9DoKUiWufJw8"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: protect tt_local_entry from
 concurrent delete events
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SgmxhEDNSf4qJUrpimkQL9DoKUiWufJw8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/06/15 14:36, Antonio Quartulli wrote:
> On 17/06/15 14:09, Marek Lindner wrote:
>> The tt_local_entry deletion performed batadv_tt_local_remove() was nei=
ther
>> protecting against simultaneous deletes nor checking whether the eleme=
nt
>> was still part of the list before calling hlist_del_rcu().
>>
>> Replacing the hlist_del_rcu() with batadv_hash_remove() provides adequ=
ate
>> protection via hash spinlocks as well as a is-element-still-in-hash ch=
eck.
>>
>> Reported-by: alfonsname@web.de
>> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
>=20
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>
>=20

I was just going through your other TT patch and I realized that if the
element can't be find in the list (because it was already removed) we
should skip the batadv_softif_vlan_free_ref() below because the
reference has already been decreased by whom already removed the TT entry=
=2E


Cheers,

--=20
Antonio Quartulli


--SgmxhEDNSf4qJUrpimkQL9DoKUiWufJw8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgZEgAAoJEOb/4TMchkvf4EMQAJcUg71TTOVblNINPD9o9m8B
oo0dk53TALW7AkJE6Q9tX7nivvC4KcX0AemZm6rGwmL2jUEZj0T6nFh/bkLJRFQY
UWkoCA+PJCWlJJFIIWweVmxspoXTnOFzIyQni90l+anAvwqccWwBb9axvwl/+JN1
f4hkhVApCIXoYoeqhF1109hG444nUYPv0KVZLUxfhA0kb91Ug8GpKzEDLCDNCsGl
OIyWbbe+3SUaZbnF855lLG1sWP4UJBQ5i2yaHhYP93cDP5PmZ3Z8xSJw9Do1hps5
4MBySaspOkuvnuNl6Ceg0gau4jj6AoM7h/bKNnhM4GfSl46lG879+ArgtNmUrdAX
QSpYF7VRVc8kfqr/EStN25JhPTfvpVM+41bfsWo8+tI9zeRzMwBtNcndOi3Q6rk9
4yK4ch7+c/lQluvGKAQPBuX8lXh/BchiUJqmx0hSxTBhWbk2YJIQQpWjCb8jHnWp
5KhyW54D7elqIQz+39nTP5mzLBbYBQmo1JRImjyRlIY7ZOcesbN/QwiY63TSMXuP
8qdeiaWMv862BZs47jlmAn+fNEs5oND8nfEA5TodLdhpqht+yKbNNudA9ycI3fqe
eyoA/xeUCg9smZty6f1dB+iYvRK6e6RrQw8LDPgtiiWPQF8mZSkAgfgMwlkUH0rA
gTUfFjA4LrTSOO35tsBw
=+Gz9
-----END PGP SIGNATURE-----

--SgmxhEDNSf4qJUrpimkQL9DoKUiWufJw8--
