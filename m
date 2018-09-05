Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 05 Sep 2018 18:55:46 +0800
Message-ID: <2732366.0R38ZFdr2M@rousseau>
In-Reply-To: <20180831144648.24032-1-sven@narfation.org>
References: <20180831144648.24032-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6800968.MokvI62opg";
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

--nextPart6800968.MokvI62opg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 31 August 2018 22:46:47 HKT Sven Eckelmann wrote:
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
> 
> Fixes: c513176e4b7a ("batman-adv: add throughput override attribute to
> hard_ifaces") Signed-off-by: Sven Eckelmann <sven@narfation.org>


Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek

--nextPart6800968.MokvI62opg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluPtjIACgkQU1VOj+62
HMCkyQgAtsvX9uxUP0rsoPhB+2pX/pNmQLq7HzhmJGGg/YhSWGh78065BYTDh9gN
mdG3rWC6a1Tdv7cwypNTYTq+xUl2dOowE9FAOp3os1M8p3Jl8zvyJqjHZiAdn8Dp
EZ6tajyehyND+LXpUGsAF1d/gOSjjrSXVe2aLPzCe0D1aRJFgHMa3k4xa/RT9kD5
xHfCAxaG3LaIOd2hyD7blojOn+Iveyaffk7/ojI99XToIvh9SCqA6RgjGzLYyWhO
qSzQeIZLRJTgz0nK98HgvBNzOEAo0HfGnxzJLfc6kFGLgz2QHKzrnl4qyHsIRBhS
el8+QxL6NDSDbowTdjwcm+0NsreXHQ==
=mJvp
-----END PGP SIGNATURE-----

--nextPart6800968.MokvI62opg--



