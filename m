Return-Path: <ordex@autistici.org>
Date: Thu, 23 May 2013 10:46:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130523084647.GC1679@ritirata.org>
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
 <1369133299-8325-4-git-send-email-martin@hundeboll.net>
 <20130521191926.GB3435@ritirata.org>
 <519DAB59.9070001@hundeboll.net>
 <20130523072942.GB1679@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
Content-Disposition: inline
In-Reply-To: <20130523072942.GB1679@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/3] batman-adv: Fragment and send skbs
 larger than mtu
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
To: Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@hundeboll.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, May 23, 2013 at 09:29:42AM +0200, Antonio Quartulli wrote:
> > On 2013-05-21 21:19, Antonio Quartulli wrote:
> > > On Tue, May 21, 2013 at 12:48:19PM +0200, Martin Hundeb=C3=B8ll wrote:
> > >> +static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
> > >> +					  struct batadv_frag_packet *frag_head,
> > >> +					  unsigned int mtu)
> > >> +{
> > >> +	struct sk_buff *skb_fragment;
> > >> +	unsigned header_size =3D sizeof(*frag_head);
> > >> +	unsigned fragment_size =3D mtu - header_size;
> > >> +
> > >> +	skb_fragment =3D dev_alloc_skb(mtu + ETH_HLEN);
> > >> +	if (!skb_fragment)
> > >> +		goto err;
> > >> +
> > >> +	/* Eat the last mtu-bytes of the skb */
> > >> +	skb_reserve(skb_fragment, header_size + ETH_HLEN);
> > >> +	skb_split(skb, skb_fragment, skb->len - fragment_size);
> > >> +
> > >> +	/* Add the header */
> > >> +	skb_push(skb_fragment, header_size);
> > >> +	memcpy(skb_fragment->data, frag_head, header_size);
> > >
> > > here we are copying the data right after the Fragment header. However=
 I am not
> > > sure we are accessing aligned memory because:
> > >
> > > ETH_HLEN + header_size =3D 14 + 20 =3D 34
> > >
> > > To speed up the copy, wouldn't it be better to allocate ETH_HLEN +
> > > header_size + IP_ALIGN bytes like we do for other packets? (you can u=
se
> > > netdev_alloc_skb_ip_align() like we do somewhere else).
> > >
> > > In this way the memcpy will access a 4bytes aligned memory (if I am n=
ot wrong).
> > >
> > > Can somebody else comment on this?
> >=20
> > I did a quick test by adding some printk-debugging after skb_split() an=
d=20
> > skb_push():
> > 	printk("data: %lu\n", (unsigned long)skb->data % 4);
> >=20
> > and it seems like the skb->data pointer is aligned to boundaries of 4 i=
n=20
> > both with and without the use of netdev_alloc_skb_ip_align().
> >=20
>=20
> Because in x86 NET_IP_ALIGN is 0 since unaligned memory is correctly hand=
led in
> hardware using DMA
> (http://lingrok.org/xref/linux-net-next/arch/x86/include/asm/processor.h#=
40).
> I don't  know if my explanation is correct, but refer to the link for more
> details :D
>=20
> > This was done on x86_64 virtual machines. Is there another way this=20
> > should be tested or maybe on some different architecture?
> >=20
>=20
> I guess MIPS would be a good choice (like most of the routers out there).
> Please, put the printk before and after the push(). Before the push it wi=
ll give
> us an idea of how the header is going to be aligned (which is the most im=
portant
> case since memcpy does not care about unaligned memory - it accesses memo=
ry byte
> by byte). You can try to do this tests on the x86 too.
>=20

I did some tests on my MIPS routers and the result is that with Martin's
code skb->data points to unaligned memory after reserving 14 + 20
bytes and, of course, also after pushing 20 (as we expected).

I tested it with netdev_alloc_skb_ip_align() and the result was good: skb->=
data
is not unaligned anymore.

However, this is completely useless.

skb->data is accessed only by means of memcpy and no direct access to
frag_header members is done anywhere. This means that aligned or unaligned
memory does not matter at all, because memcpy always accesses byte by byte.

So the code is good as it is, there is no need for netdev_alloc_skb_ip_alig=
n().

Thanks again Martin for you tests.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRndd3AAoJEADl0hg6qKeOjcgP/jdPs6s7dd0IuYILBckko169
c/mnETlgwlTiRPb3qmGrckyvCHa0aOaWmK7/sVTHVPqjxpQXhB++NE2G5mu59Vac
Fy+mG0DLFPUMFTF3Fc2O8+z190oZDqYrE2ifOi+oMQWFUJhP+9wMAO8M5O2tNznH
luwuXNFGsitfLBh2su7CEc2IDpLCm8Z/ts7I8/eX2qrOcXy2d2XvQ5KAKFbDJ/9s
XiIcGeu5BTaTJYy8ykO3KBdM11rFQC7hx5nxIVc5CeBhafktJmIitI/fqqE9zSmh
lWJ6OOPp8fW658FDJJjHwanBLT/qbHrC+w59xVrME0ovCHoCkrYs34AMiURMTJVz
TzF2cTfEK7UwXRn0ndI11T9TK4F7KDTjoQqOFmp/WWu6lZ9lOBcCQtzAV5Y0NGIn
62IpEnIF2qayYyvK1U6yqvGMf+CG7l3eiLgatEF+OJAxmeHuJWyEb/6RGlYR8A09
0ulfmnA8HuQIHaA6zjg0z+mUGULY89unUKEuPFw5YXaTlPVkRYMZkow5rm/K852z
0+AcEpAD3N2Ft6lIo/NTL2fjqcp5bUOQ13TlN15XFTR9Ll0LRAl7QL558tjCe5Gw
xYQdOAicSX2NeTu7RXAVL+dhbJUv508jcNRqCPSohgtj4rh8fKkUu/GSObAYFfLu
pzeBaGHHp6xtpwFfOrkd
=vdnJ
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
