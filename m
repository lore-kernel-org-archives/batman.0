Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 05 Sep 2018 19:09:09 +0800
Message-ID: <5193548.c8HxFpEHO3@rousseau>
In-Reply-To: <20180831145629.26332-1-sven@narfation.org>
References: <20180831144648.24032-1-sven@narfation.org>
 <20180831145629.26332-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1605687.C8IaTFe3jQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint v2 2/2] batman-adv: Fix segfault
 when writing to sysfs elp_interval
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

--nextPart1605687.C8IaTFe3jQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 31 August 2018 22:56:29 HKT Sven Eckelmann wrote:
> The per hardif sysfs file "batman_adv/elp_interval" is using the generic
> functions to store/show uint values. The helper __batadv_store_uint_attr
> requires the softif net_device as parameter to print the resulting change
> as info text when the users writes to this file. It uses the helper
> function batadv_info to add it at the same time to the kernel ring buffer
> and to the batman-adv debug log (when CONFIG_BATMAN_ADV_DEBUG is enabled).
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
> 
> Fixes: ec46535b8275 ("batman-adv: Add hard_iface specific sysfs wrapper
> macros for UINT") Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek

--nextPart1605687.C8IaTFe3jQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluPuVUACgkQU1VOj+62
HMB3BQgAuuDeZwuAuUTq6iGtjnWTIw+34XFYn23KvI20I2WJwQBG9e2CEfpMHtAQ
24lOlMwcsLW0VTvS4Ty1dX3MXboWOGsPieuCTLnzHLrNDCXlMzji7S79Uo42iqpr
sNpoQvIjwBVIbAkhhDg5KcUmlV5kZ5JDvoBZeNIykY3sTssSbwBMz53C9uwabQpq
1+SdPIrX0cqzVlKJst0L0j7VTdWPP36YA26dBzAaHWBpFnp5jf35iuzdCE0P4U/x
KoEBHuqS55giNWgwbNBw+Y6u8nUNPIOsQjyA1qZ9d29qqQsQUzIQx4UVhmzNWG4h
JQ+Yo0asO0Dizyz62c56aSVPYwDJ0g==
=AN1u
-----END PGP SIGNATURE-----

--nextPart1605687.C8IaTFe3jQ--



