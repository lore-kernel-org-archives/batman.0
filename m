Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Mar 2018 17:52:39 +0100
Message-ID: <2068153.zsGkJYxm0U@sven-edge>
In-Reply-To: <20180227081059.13234-4-linus.luessing@c0d3.blue>
References: <20180227081059.13234-1-linus.luessing@c0d3.blue>
 <20180227081059.13234-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2483508.rP0jzFxGci";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batctl: add netlink dump function
 for multicast flags table
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

--nextPart2483508.rP0jzFxGci
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 27. Februar 2018 09:10:59 CET Linus L=FCssing wrote:
> +       /* only parse own multicast flags */
> +       info_header =3D netlink_get_info(ifindex, BATADV_CMD_GET_MCAST_FL=
AGS, NULL);
> +       free(info_header);
> +
> +       if (mcast_flags < 0 || mcast_flags_priv < 0)
> +               return -EINVAL;

Let us assume for now that the kernel doesn't yet support the netlink
mcast_flags and the rest of the mcast netlink code. It will now try to get =
the=20
mcast_flags from the kernel and fail. Thsi function is now returning -EINVA=
L=20
and handle_debug_table will now compare the return code to -EOPNOTSUPP and=
=20
notice that a different error happened and stops the processing. Would be n=
ice=20
when it would not really stop and instead try to get the data from debugfs =
(via
the old code which is still in batctl).

Kind regards,
	Sven
--nextPart2483508.rP0jzFxGci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlqcJFcACgkQXYcKB8Em
e0YqOQ/+PiogLJIN6tn+ONJzKqz0WvNaExxBzzBeObri3LhyP+xkddnuV2JTo9Hl
ZHta80ve6ukpWGV87ZwhlFigU6D+AqmPt5TN9iotI56ievtQa/8vwgEvZWIPBpwF
DU5prS+MxtvEcm3yo1Bq0htxMN/f6qDU3K+qgGzqsBsCZe8eA48v1tSjnvlOd7Vw
+ekHqzCnQyMic+ZyVTH/4HsNPLoTlDPYKr3t/V3OJCD22J9HvZLu2JYZv035Yes7
D5KZqXg1vFuukCOxM4tQijqKq+0gZz2yNbTVPR7c2Z81PyDrW7c7CFgAbNglf4Zr
O6JSZEr6gWX2ab+LUXpSVp/voylIQUigZzN60VireQo1AdFbow8Bz1k7cI/qwgOJ
bLznh5HDI/Qt1321EEEyDnOvCNilaJdKHYAk6jOcNlD0FOL89lYFa3su04/tre1Y
1SyL85x5QCcCJGBxO6F1vrsjxxKSApAKXrS1kyAmuamNYMGKZBMZ49emFUQ8Dq+7
OGIYXXfWXQCHNF43+jVoivbMOS9/bsX1X+2kJR4rpa29Sp1O+JS3ASlWheBNe0Xc
l84Ux52GBOJcNUtz2JXTbDVZh7zwB88XOw1hqoWWmjCiSuUJ9VzrXPLOz5ouWeaK
dSdgBw2hk2y+4MXrqNSH7gvBBX3SkYqPKL0ljwWOMVtJJtWQsH8=
=oZMc
-----END PGP SIGNATURE-----

--nextPart2483508.rP0jzFxGci--

