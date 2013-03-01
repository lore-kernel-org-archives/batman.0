Return-Path: <ordex@autistici.org>
Date: Fri, 1 Mar 2013 12:43:00 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130301114300.GE20607@ritirata.org>
References: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
 <20130301110809.GC20607@ritirata.org>
 <CAP5XTDMV9dQucnRpe-fHvKUt-E3RKzEPQcNruG--fA8BnCv7UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Content-Disposition: inline
In-Reply-To: <CAP5XTDMV9dQucnRpe-fHvKUt-E3RKzEPQcNruG--fA8BnCv7UQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Implement DAT for IPv6
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


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2013 at 01:38:43PM +0200, Mihail Costea wrote:
> On 1 March 2013 13:08, Antonio Quartulli <ordex@autistici.org> wrote:
> > On Fri, Mar 01, 2013 at 12:59:18PM +0200, Mihail Costea wrote:
> >> Hi,
> >>
> >> I've started implementing DAT for IPv6 and I have a few questions
> >> regarding the design.
> >> I've already implemented a snooping mechanism for Network Solicitation
> >> package, but now I have to add it to the ipv6 distributed table.
> >> I'm also a beginner in kernel programming so any help would be useful.
> >>
> >> From what I've seen there is a lot of code in distributed-arp-table.c
> >> that could be used for ipv6 distributed table.
> >
> > yeah, I think that the table handling and DHT primitives can be reused =
for IPv6
> > (they were designed on purpose).
> >
> >> A problem in using that code, from what I've seen, is the fact that
> >> <struct batadv_dat_entry > has a field for ip with only 32 bits
> >> (__be32).
> >
> > Yes, here a way to generalise the structure is needed.
> >
> >>
> >> So I was thinking to make it more general by:
> >> 1. transforming that into a pointer (unsigned char *ip) and add a
> >> field size which will represent the total size of the ip.
> >> The ip itself would be allocated dynamically.
> >> 2. use a union with both _be32 / struct in6_addr. In this case the
> >> problem is that if we use ipv4 then all the other space for struct
> >> in6_addr would be wasted.
> >
> > correct. and for point 2) I think we waste a not negligible amount of m=
emory..
> >
> >>
> >> The second problem from what I've seen in the code is that the
> >> batadv_priv->dat field is hardcoded.
> >> For ipv6 we would need a new field to memorize the table, but I don't
> >> think it's a really hard problem to solve in order to make it general.
> >>
> >
> > I did not get the problem with the dat field?
> > Can't you use the same table to store both IPv4 and IPv6? The DHT is ma=
de to
> > store general data, so I think (with the suggestions you wrote above) t=
hat you
> > should be able to use one table only.
> >
>=20
> I think it can be reuse. If I understood well the DHT has buckets for
> each entry, so it shouldn't be a problem if
> the IPv6 hash collides with the IPv4 hash.

yeah in general hash collisions are not a problem (well it is better to red=
uce
them in order to provide a better distribution of the data).

> I just thought that they should be separated because because they are
> different concepts.

yes, but in the end they are still separated at the logical level (the data=
=20
size will make the difference). Maybe you can add a "type" field on the buc=
ket?
In this way we can easily differentiate one data type from another (this ma=
ybe
helpful for future use of the DHT too) instead of replying only on the
"addr_size" field.

> This makes it a lot more easier :).

Yeah :)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRMJREAAoJEADl0hg6qKeOxU0P/RROAvtENKWbB6wBvUjNNPAE
aeVHEh+z6IqcdG0dRa/Jf/Vh2fT1ofe4e/1HaFAfevaKsnWbLGxsC6t1wkPNa561
tCidccYlTVE0LqY75xamHt1hsGbKLvyOWSwUVSM8Sz1VJ3RjMZKHbN3yFWu+vL2B
n6UbgMbYiboEVlv8eqXZtYz672p5/L5tlLwfaGhg8lLHOZuANG2MvF3UHAaKDiY1
SdQ7TK1+YpDW2qWrbUup18fx/Wphf3VuudtxZIHjEzGoPFFxHGZeAXpy814Rbkni
zEmfnTWud2Vo+pXhEfmNmPyoory+GWkrJfvgVP8VhdSKyBSqfu3PSb0XqSgGeN0x
YtJXU1hA+Fe48TqonH/IQTc79SDuQparmNooMGY8fvmKrEwsTv8XuS2ZFAlPWnJQ
gJGtRfXV8H8IfasqV+hmp+YSe+Hafn1xvU5sxdU7gkwDQCa4Mn4kFOdINMdrQHxp
061r7rRV4JcX8BjukVq4m3Wu1G5f+dB603JizuJkwxKbSFkCkRKYVo2G8yEt9cNF
7a2xhLCVlnhVED5Jet8T0pwVcWV7BojFE9GlCNXfq3sc7hIOXLDAOVss94KYhkGZ
Gw50wXRGu5uq2ETAhRRZAXbDbRcXEJMltiU3dRPMbghbVu3Dlqsv+FRXeY+BfN2/
1ewbL/FSbMkl2+Gpt08o
=v/xV
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
