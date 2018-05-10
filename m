Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 May 2018 17:50:48 +0200
Message-ID: <2798092.n9DkCtfipy@sven-edge>
In-Reply-To: <20180510144137.32244-1-mareklindner@neomailbox.ch>
References: <20180506195559.32602-1-me@irrelefant.net>
 <20180510144137.32244-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5127176.c3I97bSTNn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v2] batman-adv: prevent TT request storms
 by not sending inconsistent TT TLVLs
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart5127176.c3I97bSTNn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 10. Mai 2018 16:41:37 CEST Marek Lindner wrote:
>         rcu_read_lock();
>         hlist_for_each_entry_rcu(vlan, &bat_priv->softif_vlan_list, list) {
> +               vlan_entries = atomic_read(&vlan->tt.num_entries);
> +               if (vlan_entries < 1)
> +                       continue;
> +
>                 num_vlan++;
> -               num_entries += atomic_read(&vlan->tt.num_entries);
> +               total_entries += vlan_entries;
>         }

Please submit it on top of the maint branch before submitting it the next 
time. The rcu_read_lock isn't there anymore.

The rest also applies only with some offsets (which sound like you have some 
other modifications in your branch).

Kind regards,
	Sven
--nextPart5127176.c3I97bSTNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlr0algACgkQXYcKB8Em
e0ZobxAAnfuyT3bY5oDc4gidq6PeYz8NOqoUZRdmS65/h7vmsEHyurk1QUkH3L9k
ezWJlBgtakE4+UEgMQsDO3fCbwy84/u2qeb02UDxg2Z6H8F5yO+KsWcfFZaWMB8D
wN7CWkMSFLk/qKS0Vtmk7dCkuiOAwmOWIXWFdYJ/ytNjtXpKaaw7+Vz+N4/taNPI
GYMdxcSnuaZgk5tKL6v1p1WVb/OUYkTdY3KljhU2I7rWBJSW5vWvTq3BpfUK0tWo
ew1BuCz3sB2rH7xct7yCXYOxGrKC/v5wBAxcbcy6YMloM2LyWlibInSLjf35pcNF
uWdb37xA9zxLn2igoJurwtWYUX9JGlACWXSvImbM0olzaKtQuu/s2kVL1/YusXO8
0kkbkhouji/0vANbWTS7aINGRPJX+nqlhrn3XQyuMibwCp9C+pnpWD3ujYwUdsYB
nkmEHP1duNitzTPM0C2t/hfBZEyWZmu5qnnHsqDGjlnXLes2oyzvIYfJE3DTA/5Q
+6wWdaKfQ9fstcrCZYShKOGMRdsIj4qIg4rXYDO6NOgZjek7elFS/FgfzL6FYHfe
r9lYLcok9EaqamF28YWUWH5LGSxlbh1HH0XhF08LY9D3u1w7bjzX9+F1qcfmUh5x
3+WJcFzlBX9bZPrgtmLzq/Fd8R9+kury9g+v26/iyVaGor3D1o0=
=SbpW
-----END PGP SIGNATURE-----

--nextPart5127176.c3I97bSTNn--



