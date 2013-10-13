Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 13 Oct 2013 16:36:49 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20131013143649.GA27965@pandem0nium>
References: <CABQkniC4b-CEdx9-7rNBuG0p5a5tM1fptsKjida0vThVUYVtug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <CABQkniC4b-CEdx9-7rNBuG0p5a5tM1fptsKjida0vThVUYVtug@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman-Adv : Hops and Throughput with Collocated
 dual-radio
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Zaki/Jack,

On Fri, Oct 11, 2013 at 11:11:04AM +0800, Zaki wrote:
> Hi,
>=20
> I am a newbie in batman-adv.  I got a question regarding Hops and
> Throughput, especially in regards with a collocated dual-radio device.
>  Hopefully somebody could offer some help here for me to fully
> understand batman-adv operation.  I have 3 devices, namely A, B and C.
>=20
> A is only having single radio (operating at Freq 5.20G in AdHoc mode).
>  Put this under bat0.  Bridge bat0 with eth0.
> B is having dual-radio (radio1 operates at 5.20G in AdHoc mode, radio2
> is at 5.24G in AdHoc mode). Put these under bat0. Bridge bat0 with
> eth0
> C is like A (single radio, operating at 5.24G in AdHoc mode). Put this
> under bat0.  Bridge bat0 with eth0.
>=20
> So, the wireless link will be like this :
>=20
> [A]::::::::::::::: [B(radio1)---B(radio2)]::::::::::::::::[C]
>=20
> 1) If i were to ping from A to C, how many hops is it considered?.  Is
> it 2 hops or 3 hops?.

that would be two hops. One hop is considered traversing one link, and
you have two links here.

> 2) If my Iperf TCP throughput from A to B is 40Mbps, what is the
> expected throughput of Iperf from A to C ?.

That depends. If the links are not interferring, you should get approx.
the maximum of both link throughputs. So if one link is 30 mbit/s, the seco=
nd
is 25 mbit/s, that whole path would yield 25 mbit/s - there might be tcp
effects further decreasing throughput (latency etc).

However you use two frequencies adjacent to each other. If you use omni
antennas, expect a lot of interferences (even if the channels are not
overlapping). If you use directional antennas you should be fine.

Cheers,
	Simon


>=20
> Thanks a lot.
>=20
> Jack.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlJasAEACgkQrzg/fFk7axZHvACdFY+KgyliEy1Nnbbdwb4evSsW
o3UAnimNtforTeGChf//AxC9dNnsQN5v
=bzrA
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
