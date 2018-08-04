Return-Path: <a@unstable.cc>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521131711.GK7162@otheros> <1883169.6MDR23bMJo@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <41a3ff9a-d673-7114-f32b-5644e21b02cc@unstable.cc>
Date: Sat, 4 Aug 2018 17:31:27 +0800
MIME-Version: 1.0
In-Reply-To: <1883169.6MDR23bMJo@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="47QfXUdu38DNKhPaYexUXS397Y9xsDMRk"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: "txt.file" <txt.file@txtfile.eu>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47QfXUdu38DNKhPaYexUXS397Y9xsDMRk
Content-Type: multipart/mixed; boundary="zsqnDOo0OpNlN9Py4YWHG3iJOB6wbz4X2";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: "txt.file" <txt.file@txtfile.eu>,
 Marek Lindner <mareklindner@neomailbox.ch>
Message-ID: <41a3ff9a-d673-7114-f32b-5644e21b02cc@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521131711.GK7162@otheros> <1883169.6MDR23bMJo@sven-edge>
In-Reply-To: <1883169.6MDR23bMJo@sven-edge>

--zsqnDOo0OpNlN9Py4YWHG3iJOB6wbz4X2
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/05/18 03:06, Sven Eckelmann wrote:
> On Montag, 21. Mai 2018 15:17:11 CEST Linus L=FCssing wrote:
>>> +               throughput =3D total_bytes * 8 >> ilog2(test_time) / =
10;
> [...]
>> -----
> [...]
>>
>>         throughput =3D total_bytes * 8 >> log_test_time / 10;
>>
>>         // Straightforward approach?
>>         throughput2 =3D total_bytes * 8 / test_time * 1000 / 1024 / 10=
0;
> [...]
>> -----
>> $ ./test
>> Result: 80000000 (log_test_time: 13)
>> Result2: 156
>> $ file ./test
>> ./test: ELF 32-bit LSB pie executable ARM, EABI5 version 1 (SYSV), dyn=
amically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.=
0, BuildID[sha1]=3Dd18f32829cdd2bc42cf744cdcafde7cdbd315cb0, not stripped=

>> -----
>=20
> Thanks for this small example program. Yes, there are parenthesis missi=
ng in=20
> the calculation. Right now, following is calculated:
>=20
>     (total_bytes * 8) >> (ilog2(test_time) / 10);
>=20
> But the author most likely wanted following precedence:
>=20
>     ((total_bytes * 8) >> ilog2(test_time)) / 10;
>=20
> And together with the fixed unit, you would get:
>=20
>     (total_bytes * 8 >> ilog2(test_time) / 100;
>=20
> Your example program would then show following result because the shift=
ing=20
> stuff is still the wrong approach:
>=20
>     Result: 195 (log_test_time: 13)
>     Result2: 156
>=20
> The calculation still has to be changed to something like this to get=20
>=20
>     // when 0.1 Mbit/s =3D=3D 100 kbit/s
>     throughput =3D total_bytes * 5;
> 	 do_div(throughput, test_time * 64);
>=20
>     // when 0.1 Mbit/s =3D=3D 102.4 kbit/s
>     throughput =3D total_bytes * 625;
> 	 do_div(throughput, test_time * 8192);
>=20
>     // when 0.1 Mbit/s =3D=3D 100 kbit/s, and 1kbit/s =3D=3D 1000 bit (=
instead of 1024 bit):
>     throughput =3D total_bytes;
>     do_div(throughput, test_time * 125);
>=20
> Please keep in mind that we must do a check of the divisor (for 0) befo=
re=20
> doing this do_div.

Thanks for the code and the correction :-)

Yes, we wanted to avoid 64 bits explicit divisions and we assumed
test_time would have been a power of 2 (otherwise we'd accept a small
error).

Anyway, the last case brought by Sven depicts what we want to implement.
The patch will be changed accordingly.

Cheers,

--=20
Antonio Quartulli


--zsqnDOo0OpNlN9Py4YWHG3iJOB6wbz4X2--

--47QfXUdu38DNKhPaYexUXS397Y9xsDMRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltlcnAACgkQB6U8WA7y
zXTt4RAAm3jCwwskCGtkOFv/ZkGbqpCZL16UGUS4CW+XCuuu+6vvevmmfG9iVNr/
zEmwr7Ag6VD/0wi8D1GpF+WMx3P6ZioZHcyTW4SHwG9RQRcsmrRwdn5ZSvx0spjW
hkw8KNrzoI5B7MTX1Ur0AmhBEt1VnvCfyX39hcQdcXNM3kkUI83NV/gPiarKg7oL
3JSlKxf5kFKY7hcu4sMGb2xXok1nI5iUy8o1Gv15isbYpBl2M8b+6XmCwVUKAUbM
JSO3RWARw5Rz20BK0iLuD41GCQGfes+1yVMQm8CNYs8T+6GXzVMj0+RYzXvEXVCp
zAfJrTr1P+NXpF3cK+8W7flD+lApBfBcfZ+LsB8FmDtPYVMk7ylIS3nwq+9R+cMO
odD9llk1NzNn+pmpxv7V1i3TC76UvpGlnw1m/ZPzYHVrgBSd3dcCIGHfxZni1Nux
f1QacMh30vW0k3LpznCUieDdB0PuaKdp10Scm2iRM4jUqIQhYES8Qm32AtlzfbeB
oe8PKQICnl2uTaz3GKMozyTOZr5SzV2vSkHRrWA1NGCor7i0pxqlSkPTNKNMNzOO
i7/ULSRqIoA9dswMJxZ2vAIODPcWEy/vu6R0PTPOXRi6vkpsAtHiIldYjuCHm/Xk
YC698VNX/JtkXlxfe9K8AI4fVgtmeM2Bl4Rnola2dpPmhH/A/yU=
=wOiE
-----END PGP SIGNATURE-----

--47QfXUdu38DNKhPaYexUXS397Y9xsDMRk--
