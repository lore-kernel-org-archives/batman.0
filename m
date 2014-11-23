Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sun, 23 Nov 2014 17:14:11 +0100
Message-ID: <2037698.Rp78ARo8W2@prime>
In-Reply-To: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
References: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1589161.S3XTo1kAkj";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv9 0/4] Multicast optimizations for bridges
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1589161.S3XTo1kAkj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Sunday 07 September 2014 07:42:36 Linus L=C3=BCssing wrote:
> This patchset enables the usage of the batman-adv multicast optimizat=
ions
> for scenarios involving bridges on top of e.g. bat0, too.
>=20
> Along come two more patches adding according debugging facilities
> to make it possible for the user to check why the multicast
> optimizations might not work ideally to give hints about
> what they might change about their topology.
>=20
> The fourth one alters the forwarding behaviour for IGMP and MLD
> reports. For one thing this reduces overhead (especially for IGMPv3/M=
LDv2
> reports). But more importantly this is necessary to make the
> optimizations work in bridged scenarios at all. For more details see:=

> http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizat=
ions-li
> stener-reports

As discussed it would be great to clarify the text on that wiki page a =
little.=20
It is not really clear (at least to me) why this is necessary. Simple e=
nglish=20
and not too many conditions and integrated remarks help. :)

>=20
> Also note, that with PATCH 4/4 multicast optimizations do not build
> for kernels < 2.6.35 (net/mld.h didn't exist back then):=E2=80=AFIf t=
here are
> actually brave souls out there running such ancient end-of-life kerne=
ls,
> it is suggested to build batman-adv with the multicast-compile-time o=
ption
> disabled. Multicast optimizations for bridges does not half any benef=
its
> for kernels < 3.17 anyways.

How about you add some kind of #error in compat.h if multicast is enabl=
ed and=20
the kernel is too old, and ask to disable the multicast feature? that s=
hould=20
be better then just failing with "mld.h not found".  Otherwise we could=
 add a=20
stub mld.h and stub compat functions as we do for newer kernels which d=
o not=20
yet support all the multicast fun.

Thanks
    Simon
--nextPart1589161.S3XTo1kAkj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlRyB9wACgkQrzg/fFk7axaxcwCghBjO6rAdxqzv4ELfylzWkpJ1
QCwAoNRQO0qYnMz7JiW4thSO1oMHi5C9
=ivbv
-----END PGP SIGNATURE-----

--nextPart1589161.S3XTo1kAkj--

