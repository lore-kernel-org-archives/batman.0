Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 May 2018 21:06:26 +0200
Message-ID: <1883169.6MDR23bMJo@sven-edge>
In-Reply-To: <20180521131711.GK7162@otheros>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521131711.GK7162@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10319805.VOa3s2kyAH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Marek Lindner <mareklindner@neomailbox.ch>, "txt.file" <txt.file@txtfile.eu>

--nextPart10319805.VOa3s2kyAH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Montag, 21. Mai 2018 15:17:11 CEST Linus L=FCssing wrote:
> > +               throughput =3D total_bytes * 8 >> ilog2(test_time) / 10;
[...]
> -----
[...]
>=20
>         throughput =3D total_bytes * 8 >> log_test_time / 10;
>=20
>         // Straightforward approach?
>         throughput2 =3D total_bytes * 8 / test_time * 1000 / 1024 / 100;
[...]
> -----
> $ ./test
> Result: 80000000 (log_test_time: 13)
> Result2: 156
> $ file ./test
> ./test: ELF 32-bit LSB pie executable ARM, EABI5 version 1 (SYSV), dynami=
cally linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, Bu=
ildID[sha1]=3Dd18f32829cdd2bc42cf744cdcafde7cdbd315cb0, not stripped
> -----

Thanks for this small example program. Yes, there are parenthesis missing i=
n=20
the calculation. Right now, following is calculated:

    (total_bytes * 8) >> (ilog2(test_time) / 10);

But the author most likely wanted following precedence:

    ((total_bytes * 8) >> ilog2(test_time)) / 10;

And together with the fixed unit, you would get:

    (total_bytes * 8 >> ilog2(test_time) / 100;

Your example program would then show following result because the shifting=
=20
stuff is still the wrong approach:

    Result: 195 (log_test_time: 13)
    Result2: 156

The calculation still has to be changed to something like this to get=20

    // when 0.1 Mbit/s =3D=3D 100 kbit/s
    throughput =3D total_bytes * 5;
	 do_div(throughput, test_time * 64);

    // when 0.1 Mbit/s =3D=3D 102.4 kbit/s
    throughput =3D total_bytes * 625;
	 do_div(throughput, test_time * 8192);

    // when 0.1 Mbit/s =3D=3D 100 kbit/s, and 1kbit/s =3D=3D 1000 bit (inst=
ead of 1024 bit):
    throughput =3D total_bytes;
    do_div(throughput, test_time * 125);

Please keep in mind that we must do a check of the divisor (for 0) before=20
doing this do_div.

Kind regards,
	Sven
--nextPart10319805.VOa3s2kyAH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsDGLIACgkQXYcKB8Em
e0bSog//W/5dSxyd4HP7zOs2wI322PHuVQPGDUqATR57Hd3e0tn46lLQYGwyfPz8
Fr8TDxAeCJMF8iZYQWM3mZThzMaMICfdt8mZkJYzjFxZzVE0ZnhtA6g9R0YTzm4U
Uq2XkKETNKrPw/IMfv0gYB+rFizwDEvTGrqdPQPR8phr8mrqyPZtGMaQa9PpApcQ
wqePY9ZbQkZvlNzS4dpKwxgRl0919ISMIaNtpBjU7jsMpbvHbq59KS7VFvn8kAKY
blCELojjGYk84RH43vsBzIexBWsWWueU9GoJmyAA1E53N62nXZhM1D6DjQKKIg36
oTQ+DjxKv1N/tbEH/LZEPEeTr6t9WZ/2FDw8w2NmoEJZ67JoJYXNcEGi2EeUw19P
0dUQS6zNb6G0vmh84btF7bXTc3hVvnemRxr7iPcQH38+7crhik3dAy9seAvOuHy7
lEycNrRO2p5i+T1l6fbmVTaV+p4/IrWQ1wICZ+ZCZQb9UaKcd6pUZK0HNbI9dv60
6tYiY3jzJG403LBTrUX0zHZTc9Tq5zqeG+AJY4H/8YnYALgkNZ8qYYH5jXntj6HJ
fytu7su6RK7W/zDEXwU2YAkb5S4q2/aUj0/6mAeZCoe6fCteHjELF5tEogcR3Fej
sCfnhxF8FVoBGisjyp1gNddd/kkt5PH9htd2Y8ujTyKRUFlyKUg=
=fsG8
-----END PGP SIGNATURE-----

--nextPart10319805.VOa3s2kyAH--



