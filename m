Return-Path: <antonio@meshcoding.com>
Message-ID: <5463259B.2020704@meshcoding.com>
Date: Wed, 12 Nov 2014 10:17:15 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAEbDFcQegtyVxsHUYjF5NL8mrL62LdkQNWtNikLtscodsGG1Ow@mail.gmail.com>
In-Reply-To: <CAEbDFcQegtyVxsHUYjF5NL8mrL62LdkQNWtNikLtscodsGG1Ow@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="clv1kaAXRE3taQ2bmOaKdKTGd8CdU7aCf"
Subject: Re: [B.A.T.M.A.N.] Threads in batman-adv
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--clv1kaAXRE3taQ2bmOaKdKTGd8CdU7aCf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/11/14 09:19, Krishnathiepan Rasanayagam wrote:
> Hi All,
>=20
> Has anyone considered using threads in batman-adv?

did you mean kthread? I don't think this would bring any real benefit.
You should probably read/understand the rest of the networking stack in
the linux kernel to understand how incoming/outgoing packets are handled.=


> is is possible to use fork() send.c file?

fork() is a function that is supposed to be used in *userspace* to
create a new *process*.
This is neither available nor conceptually possible in kernel space.

Maybe you should read a bit more about what you can do and what you
cannot do while developing a kernel module? :)

--=20
Antonio Quartulli


--clv1kaAXRE3taQ2bmOaKdKTGd8CdU7aCf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUYyWjAAoJEJgn97Bh2u9e8bgP/1IFxYgx2SAgaTpaAeo6+Fe4
ClhR/VGNEFPWHhC+le01Yxjt7T34AUJZk8j3K0F9rKNGLMMxuBvSV+s6usCz2R48
j1wFdspQFkzbIBAgGCp+1ReAAJGzrPUZaF6v14KClGB4TORV/+6cQEDuahVLGqbd
y5prb79wurBEUDEzr/S7ZMopXsnrHoapfFBLSED3iRYfORkJNCCbZAPALCcAziAS
kE5tHM3gm2KuBRt94h7czkAhNEdQERj0zydrX+LBufGBK/apRlHnXTGcgfFBZoTV
Mk0FAFGQCzWeP7XW4cWO7C77SADRtxxMkPQXy9BzczB5i8qEn0vCsXP/N7CqnrZg
tsh8KpncSm+tdrpo6ygFJ6B7rk6ordJ+SxpOgfucnnZpahv28E5LNKDPtV2Qdj6m
RK2h5uVuYbZ/RNDMxtX8iAwDEVNeFCyEqTbfnu1KYoWnEZCljJlvZ/Zm9YbWpg1y
/RonPalK2rX3OYKzWxXNgPTEIvM1kAmZLpeeoAUXG/TX1Ee+F90XKWt2h1gPbBwY
8t77uiIx653P1wYVMR0SbVKIGaCaW3UrA/oQHXCYT+vKLmCVFT1Je33MdAsF6WQs
JJedjr9DO5/eiB8urVdDdV35BQsi+4uFP8CLSWbDW6uHcbtUfXBjVGRFugX7fvMU
6xbjf8xCL8Gx/ByOQ1z3
=efT1
-----END PGP SIGNATURE-----

--clv1kaAXRE3taQ2bmOaKdKTGd8CdU7aCf--
