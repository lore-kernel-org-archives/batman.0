Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Sep 2018 18:07:31 +0200
Message-ID: <4480795.5zyD5zoaLD@sven-edge>
In-Reply-To: <20180831144648.24032-1-sven@narfation.org>
References: <20180831144648.24032-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2475877.oqfgmHBij8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: Fix segfault when
 writing to throughput_override
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

--nextPart2475877.oqfgmHBij8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 31. August 2018 16:46:47 CEST Sven Eckelmann wrote:
> The per hardif sysfs file "batman_adv/throughput_override" prints the
> resulting change as info text when the users writes to this file. It uses
> the helper function batadv_info to add it at the same time to the kernel
> ring buffer and to the batman-adv debug log (when CONFIG_BATMAN_ADV_DEBUG
> is enabled).
> 
> The function batadv_info requires as first parameter the batman-adv softif
> net_device. This parameter is then used to find the private buffer which
> contains the debug log for this batman-adv interface. But
> batadv_store_throughput_override used as first argument the slave
> net_device. This slave device doesn't have the batadv_priv private data
> which is access by batadv_info.
> 
> Writing to this file with CONFIG_BATMAN_ADV_DEBUG enabled can either lead
> to a segfault or to memory corruption.
[...]

Added both patches as ddf99b78e255 [1] and 848be9859b01 [2]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/ddf99b78e255530cbadc0f67656a549e19520280
[2] https://git.open-mesh.org/batman-adv.git/commit/848be9859b0109a6e428f92f21f2e660153b1c75
--nextPart2475877.oqfgmHBij8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluP/0MACgkQXYcKB8Em
e0YEORAAnxjbcuvbrissE6jI9sHkkR8oeD4sqL1td73gwRwzeud4fpo5eKpVZvfz
ysD6mJ8iuwo8HqX7bPxRABp8J5hoHAl58vToRbz9jTO4RwSUVDKr8kNPYY35ReGT
RzgiGpKNn11JKjtB8rz+kV0rXvwdGL9y7btJtrtChyWTjlI3m5NzHUL2gJ272YSu
5bObH0mvoX5eIC7AuCO06WDrafzNp/1MV6knSCyFDuAS2vPLFUaYtXvhnJpD+WXj
zsDKE0eTHHhlXaDWTP+5Qoxqpg1R39HBIUa2hWnel8UsNY+cs+mhpkU4icYS1vNY
Mjs3GN3O/PW7mw2VaUEwgRGSqb326B2GBOUZNQbsnzXwRn5yLFheEWL+mCCSqVt1
Ad9rV4xiSL5648Pi0pzmXy5PH2UaqW8QXGx93LhpGin4yy0PV9pfRpkbFKkiErtm
WV8Qv8JhFKcvpFrdEVnL8+/KGruDDhOjYszU/NUjysvWzS0Xg3kQRlhw88rG1OsB
m9RXXKMQHXzskehXdWirBhF3VhP+LIDwXQGnhqMSkYOLQXsx1NHDxb3pSXpXErNb
0LNNsEEMswpIOM8Mv6zWE+rUZm7Nar0y4PT4BaxZNctQvFIag4wceKUBbHCLw8zP
x1pZC7moNEBNRju/lfTLS00aJ2EjEdYTlJ4kHOn+OjiFt4jR4+c=
=4vqj
-----END PGP SIGNATURE-----

--nextPart2475877.oqfgmHBij8--



