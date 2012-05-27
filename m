Return-Path: <ordex@autistici.org>
Date: Sun, 27 May 2012 18:04:37 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120527160437.GB15532@ritirata.org>
References: <CA+wR77oJFdK9RZN+zoJ0wL30bv-K=ifwU2tLbFUaNKNecx2YaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <CA+wR77oJFdK9RZN+zoJ0wL30bv-K=ifwU2tLbFUaNKNecx2YaA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Questions regarding the Emulation envirnment
	setup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Spyros,

On Sun, May 27, 2012 at 05:00:42PM +0300, NorthPole wrote:
> Hello everyone, i'm trying to setup an emulation environment and i
> have some questions:
>=20
> * although i downloaded the vde2-2.3.1 source and the appropriate
> patches (vde2-2.3.1_colour.patch and
> vde2-2.3.1-wirefilter-ethertype.patch ) the wirefilter patch could not
> be applied giving the following output
>=20
>  $patch <vde2-2.3.1-wirefilter-ethertype.patch
> patching file wirefilter.c
> Hunk #1 FAILED at 59.
> Hunk #2 FAILED at 524.
> Hunk #3 FAILED at 1391.
> Hunk #4 FAILED at 1402.
> Hunk #5 FAILED at 1421.
> Hunk #6 FAILED at 1475.
> 6 out of 6 hunks FAILED -- saving rejects to file wirefilter.c.rej
>=20
> any tips on how I can find why it failed and how to apply the patch?
>=20


Have you tried "patch -1 <patchfile.patch" ?

>=20
> *I ran the script without the wirefilter patch and I got a blank
> terminal,is this expected?
>=20

what script? Wirefilter is a "daemon" that run and gives the link some
properties. By the way using it in your testbed without the colour patch do=
esn't
make much sense.

> * how can I get the dmesg(and generally any command) output
> from the qemu instances?
>=20

you could directly enter the VM console and use it like you were on that "P=
C".
Actually each VM should run into a screen instance. So you can use screen to
decide which console to attach to. "screen -ls" should give you the list of
instances and "screen -r <pid>" will attach your terminal to one of the
instances (man screen for further details).

>=20
> *provided i have built open-wrt with batman and have put the
> appropriate script in wrt's  ./files/etc/rc.local batman should start
> as a daemon right?

Daemon? You know that batman-adv is not a daemon :) If everything is proper=
ly
configured (i.e. openwrt configures bat0 the proper way) then yes, batman-a=
dv
will be properly running :)

> given that, I should be seeing batman packets in the capture, right?
>=20

I think so. Sniffing on tapwrt0 should enable you to see the batman traffic!


> *wireshark should recognize that a given packet is an ogm packet or
> there is another way to filter only the relevant ones?
>=20

If you use >=3Dwireshark-1.7.0 then you will be able to correctly parse bat=
man-adv
traffic (COMPAT_VERSION 14, which is the last). And then you can apply what=
ever
filter you like :)

>=20
> Thank you for your time

Thank you for asking!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPwlCVAAoJEFMQTLzJFOZFVpwH/RzpOkeDkpHerk4s5cX4EjJE
YMzTVGKAlBtlNuszxVVISHinn0YTuWsj7H/hBQJxD/k7z+lcol8OC1qpiEsCQ495
+2Oglb3KVJW7dXhIWWZpl/Shuj9WDlOZ3j253/0NeSi6kyj++733SYoHhxhHShJI
LgeOARbK9NHsDw2emlU7gTaOU08339eI/FS82zd4QWZ/EuX2oBrHI1wNofOnmAll
BolsHRqgOJctKuIhJ9sWvUR3iZQMiQzjKbFs0u0dzkdpinn1LUvaB/GQB7zPBbmb
foDcgsrw92NQYdmAdSaqRKySuN3dtIW27Pm4sx09G1HXYLV1o0qeCvVbU/tCZZc=
=BZ/+
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
