Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Sep 2018 20:00:35 +0800
Message-ID: <41525005.Pqo06DrDOh@rousseau>
In-Reply-To: <20180812190445.28013-4-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
 <20180812190445.28013-4-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2138794.ybTjxVXYNb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Prevent duplicated
 softif_vlan entry
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

--nextPart2138794.ybTjxVXYNb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 13 August 2018 03:04:43 HKT Sven Eckelmann wrote:
> +       /* adding sysfs can fail but it is now to late to handle it.
> +        * it can also not be in the spinlock section due to the sleeping
> +        * behavior of the sysfs functions and the fs_reclaim lock
> +        */
> +       batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
> +
>         /* add a new TT local entry. This one will be marked with the
> NOPURGE * flag
>          */

Why is it too late to handle the error ? As long as this function returns
an error to the caller the kernel will destroy the interface, ultimately
allowing batman to free anything related to this interface ?

Having debugged some nasty TT VLAN bugs which were due to missing
error handling in the VLAN creation routine make me a little nervous
about the proposed approach ...

Cheers,
Marek

--nextPart2138794.ybTjxVXYNb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluRFuMACgkQU1VOj+62
HMAoRwf/bMiplYHgMygoPDznJIYAoe1xj0AmarLcQ+Fek9kwMIwj+wBexaURMomw
fNT62AmvDwwqDTytqsfJngNPUOfT9jNVdkbxEr4BoB0jRd6PA39Ohu9aQv2RzrYn
FFjsNeBnjZw8xgep+iRy1pndnEKkSLGODu4w/gWziomdV4rfWB3ANKvngI8xlVwr
+odefJzihE7WWrdxrHm+E2xTxoCoRu/5BPa01ax0G3UwJ4YadFmdYOBDO6lZG2iH
v1nTGdc0xrD9UeGj+2PlPgXgMEJpLClzrw6uZ3IjB3YvXkpqlQ1kAIQ8BmjSwGfJ
DuxFMs5wAstWTUwA+sxTJHSdUVZ49g==
=7S19
-----END PGP SIGNATURE-----

--nextPart2138794.ybTjxVXYNb--



