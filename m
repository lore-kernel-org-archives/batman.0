Return-Path: <antonio@meshcoding.com>
Date: Thu, 21 Nov 2013 08:21:43 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131121072143.GD311@neomailbox.net>
References: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
 <528D81CA.8000106@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <528D81CA.8000106@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat code for kstrtou32
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
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--+JUInw4efm7IfTNU
Content-Type: multipart/mixed; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 04:45:14AM +0100, Matthias Schiffer wrote:
> You are casting a u32 * to unsigned long *? Won't this break horribly
> when sizeof(u32) !=3D sizeof(unsigned long)?
>=20

It will break when sizeof(unsigned long) > sizeof(uint32). For example on
x86_64. Hopefully nobody would use such ancient kernel on his machine. But =
you
are right.

What do you think of the attached patch?


--=20
Antonio Quartulli

--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: quoted-printable

diff --git a/compat.h b/compat.h
index a050bb8..fe64820 100644
--- a/compat.h
+++ b/compat.h
@@ -153,7 +153,14 @@ static inline int batadv_param_set_copystring(const ch=
ar *val,
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 39)
=20
 /* cast last argument of strict_strtoul() because we have a uint32_t */
-#define kstrtou32(cp, base, v) strict_strtoul(cp, base, (unsigned long *)v)
+#define kstrtou32(cp, base, v) \
+({\
+	unsigned long _v;\
+	int _r;\
+	_r =3D strict_strtoul(cp, base, _v);\
+	v =3D (uint32_t)_v;\
+	_r;\
+})
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
=20

--veXX9dWIonWZEC6h--

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSjbSHAAoJEADl0hg6qKeOL7wP/3bL9eP5T1NahDq5uAQa2PO7
IVws0NoXeRiqng+LAiWobI6KujuRYnUvZjsjtECVwub/TzB5YkIAi+2n4gTdV+nU
hnbieXbpNeV6oBzVjt339eQufXWAuwDTMNPuM4UVP58k0eLMX3qHcdioeDmCMEme
5uv9S8QXVJOgR0kdf1J1fdH3TuagaHE5WSjVOZVLzet9RJibWcHieg3462+Z9FZl
rJiQXWTs9pMsRtO1m5l0phbhDZPfVJaYeGAemqPn+x+5uHUCUgIiwMSV2zvKGm1e
O3rOTFrOoljIiFLbmCmeg5ACRfHMZPq5w3Eu70SA4UWfN90aISKSIQvLufGxhyw4
pXT+wPQQ1+dVrGBo0gyljDXJVJUsA55mbyfTpXZIOJQfLgDQkufjCf2+ldGlDH5A
N6Gh/JX3nwDdsmQSpqZMGlxhjwpCZTlyDCmxF1qB74D5uz0EeeRoptW1uFI2au/r
oq0HugqbUuAq7rhkVoNFqebzTuxPaxBOT10neG4i8LaiiTCgi17iJrbMTpdT6Gjg
YZgwix2RH4Lbvj1NQHfb8tQf2gYSK+lDZCUHxbt01EPrsIfkyVVlUSroBjGCQRVZ
KuGjnlBv0uy6V6qH5hvw4PISnWEhm1ueRiMDsGRXP4ouWC04qmd0RFVl4SRK2HiQ
g/4APbGkE7KpIvz5GJMx
=k0vd
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
