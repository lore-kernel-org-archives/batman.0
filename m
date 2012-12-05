Return-Path: <ordex@autistici.org>
Date: Wed, 5 Dec 2012 12:06:42 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121205110642.GD27828@ritirata.org>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121205103527.GC26922@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+OcHDfVcPO70+1iC"
Content-Disposition: inline
In-Reply-To: <20121205103527.GC26922@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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


--+OcHDfVcPO70+1iC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I have a few comments on what you wrote:

On Wed, Dec 05, 2012 at 11:35:27AM +0100, Andrew Lunn wrote:
> Hi Sven

[...]

> We don't have anything like a master tree.=20

Yeah, I think this is exactly Sven's point. In the end, the whole email from
Sven can be concentrated in the suggestion to think about this direction, i=
mho.

>=20
> The BATMAN master tree, if i understand correctly, is to allow
> releases for older kernels? Maybe turn the process around? When Linus
> makes a release, pull the mainline code into a branch, add in the
> compat stuff and release a tarball from that? If any stable patch
> touches the batman code, again, import it and make a new tarball.
>=20

The master branch is used to create the out-of-the-kernel-tree package that=
 we
release every now and then (Actually together with each kernel release).

I think the major advantage here is that, whenever a person sends a patch w=
hich
is not going to work on older kernels, he must also send a patch for compat=
=2Eh/c.
This would be impossible if the patch was directly aimed to the kernel tree=
, or,
to say it in other words, we should each and every time run behind the comm=
itter
to ask him to send another patch for compat.

This is my feeling about the master branch/repository. I also asked to do i=
t the
other way around, as you are suggesting, in order to also simplify (and red=
uce
probability of making mistakes) the process of creating pull requests. But,=
 in
the end, we are simply moving complexity from one corner to the other.

However, I think this particular topic (patch against package vs kernel tre=
e) is
orthogonal to what Sven is proposing.


Thank you for throwing more ideas on the plate :-)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--+OcHDfVcPO70+1iC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQvyrCAAoJEADl0hg6qKeOFIcP/Ryn7Web2p9w0KDzORPR9rFz
F9wleQFFA4snRRh8KHExvZmXIG/vvbeF5VBIp5hFVh1iIJ/Nf+2OG7mdQB/OXaR0
b9icMuFo4aMSEPjvJ3M90mdjPioILf5eVPAWG85C+JpiqqGh0EEsdKuEXIaw+kfU
mtAn30cBcygD9emP6Tw/dYc9RZKwaJEmxDNNMeM5lqNTFHPZlK0j8ytxHZi3N+0s
nYTiSRvJWNFFRlnoPfk/ch0l7pBXNAF3/5bQ88lxT4DWCrrBYqj54ZpH3C9QIEz+
vsT6JIl5zcIs/ljhV7vPpSfSUROXmo11kLDTcqrWdgmj4YerI/tXble9q5H09by4
SLCnthP46dZYoDxra0xY2q7ixebZz5pGe5IPD5USHgpR6zyJ3x2QbKk8M51pEW7N
ofV6WelBYN4Bu3PkvNvtmcXZ7Q72HSenwh4cTzxzhlyL2akZULhAfICMWt8yCw/A
LHzMZwHSQ1xn5jquDW4rZ+eBQ0zstPYPrmp07qv5soYvmUk/8U40tnEidOZtHKML
X22fEDFDC8vByDWQfDfr8T9qnenqnc1e+XbFGMhgIdNi1dERSU5Lz4tI8M4GkI5t
F0DCB2qHnbuLrPsatBMQSekV83qBjZ60nWGbKWiUSnwODd8Ybp/MvfiuNQUgjwfm
Vk2vasprPpB+mrg0OZuu
=pRCf
-----END PGP SIGNATURE-----

--+OcHDfVcPO70+1iC--
