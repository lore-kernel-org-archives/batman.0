Return-Path: <a@unstable.cc>
References: <CAHuRCtSXTMBekv95iaoxVQtxGWLvk4HOz_SbOsn4WdXT9HpaFg@mail.gmail.com>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <2f0d6273-90fe-6fdb-6b96-639ae5c26dea@unstable.cc>
Date: Tue, 19 Dec 2017 05:07:58 +0800
MIME-Version: 1.0
In-Reply-To: <CAHuRCtSXTMBekv95iaoxVQtxGWLvk4HOz_SbOsn4WdXT9HpaFg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="txbSbpbLrlK8Q4tUCtl33c6hto1wedPgs"
Subject: Re: [B.A.T.M.A.N.] Batman -adv no longer backwards compatible with
 kernels Pre -4.0???
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, jorge power <jorge@alumni.ufl.edu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--txbSbpbLrlK8Q4tUCtl33c6hto1wedPgs
Content-Type: multipart/mixed; boundary="r69M7N0Lw1VbviIQddWq8WpggqbSS7FRT";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, jorge power <jorge@alumni.ufl.edu>
Message-ID: <2f0d6273-90fe-6fdb-6b96-639ae5c26dea@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] Batman -adv no longer backwards compatible with
 kernels Pre -4.0???
References: <CAHuRCtSXTMBekv95iaoxVQtxGWLvk4HOz_SbOsn4WdXT9HpaFg@mail.gmail.com>
In-Reply-To: <CAHuRCtSXTMBekv95iaoxVQtxGWLvk4HOz_SbOsn4WdXT9HpaFg@mail.gmail.com>

--r69M7N0Lw1VbviIQddWq8WpggqbSS7FRT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 19/12/17 04:55, jorge power wrote:
> I am running kernel 3.3.8 and trying to use batman adv ver 2017.4.
> I am getting error:
>=20
> net/batman-adv/hard-interface.c:101:28: error: 'const struct
> rtnl_link_ops' has no member named 'get_link_net'
>=20
> get_link_net is not part of rtnetlink.h in kernel v 3.3.8.
> Is 2017.4 not backwards compatible with older kernels per 4.0?

It's there in compat.h:


134 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
135
136 /* wild hack for batadv_getlink_net only */
137 #define get_link_net get_xstats_size || 1 ? fallback_net : (struct
net*)netdev->rtnl_link_ops->get_xst    ats_size
138
139 #endif /* < KERNEL_VERSION(4, 0, 0) */

not sure why it does not work for you.

>=20
> get_link_net isnt added until kernel 4.0-rc1.
>=20
> I saw a previous message from 2016 saying:
> "Just to let everybody know: This patchset will break batman-adv compat=
ibility
> for kernels older than 4.0 (see d37512a277dfb2cef8a578e25a3246f61399a55=
a):"
>=20
> Msg: https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-January/014=
306.html
>=20
>=20
> So was the backwards compatability broken intentionally so its no
> longer backwards compatible with older kernels?
>=20
> What can i do?
>=20

--=20
Antonio Quartulli


--r69M7N0Lw1VbviIQddWq8WpggqbSS7FRT--

--txbSbpbLrlK8Q4tUCtl33c6hto1wedPgs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlo4LjIACgkQB6U8WA7y
zXS+nw/9Hfk/3UequDQk3YSApHgNPsCIKUiWDIOVuhJHwgHXmXjDWOUnKedB0a3i
/eMyGRr0eMVKZCKRzHOJk6a3unerM0Zp1HPr4gUCdjJPUjHNQ8krL89mdyChhFLQ
1P6PnEB3VGzLxrgi5H5uFg9Lpxr8UTv6ReuHcadfYBU7YFoz/qBFFKwp4ZlgY3j/
GfurnwxPheR7JHlb6f4v9AiWMYWJfZxlMBitHujlIb4ej3lKDIhTYz4azQWILmmq
ALR4vn8IiaHY3CBOFsKzUPAXMNLBNqXIhvvtp4/CjGmSnJNuoZQgxXoXeYTV74p4
tbB6+M0OySdbqBdeKObpCsdQglVDcItUpjcBgaCHDqX9zJ6Vix1RydM0qObZhdxr
3R0ldG468aANQNxXUmXMalCJYt1B7Jsx5PS462oferDh3fmvgaaGjre+ZQ/nlrdg
ENESwMckqLsW97ZtGHrXIcwlu9Sbw9WF5Q+o7GDXnuUkE9FUc3uIxi+F3Y+jr+jR
WSqq7cojX99KaLhV12hdPYO0kcdniMKkyGL+WI+T7+dXkvl49di4fKh3dR+KSRO8
QwPpPcHnz1HoiIdTtnRDyCbJRUllS12+/0khCOuGw89MDJbtkvxRPPCCVA2d3OpM
FsLVxKdnodA9Ur+FcLbkKD0P1LQdlmvyQMbXR8BnnZm4V68YOyE=
=nXys
-----END PGP SIGNATURE-----

--txbSbpbLrlK8Q4tUCtl33c6hto1wedPgs--
