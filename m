Return-Path: <ordex@autistici.org>
Date: Thu, 23 May 2013 09:29:42 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130523072942.GB1679@ritirata.org>
References: <1369133299-8325-1-git-send-email-martin@hundeboll.net>
 <1369133299-8325-4-git-send-email-martin@hundeboll.net>
 <20130521191926.GB3435@ritirata.org>
 <519DAB59.9070001@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <519DAB59.9070001@hundeboll.net>
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


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Thu, May 23, 2013 at 07:38:33AM +0200, Martin Hundeb=C3=B8ll wrote:
> Hi Antonio,
>=20
> On 2013-05-21 21:19, Antonio Quartulli wrote:
> > On Tue, May 21, 2013 at 12:48:19PM +0200, Martin Hundeb=C3=B8ll wrote:
> >> +static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
> >> +					  struct batadv_frag_packet *frag_head,
> >> +					  unsigned int mtu)
> >> +{
> >> +	struct sk_buff *skb_fragment;
> >> +	unsigned header_size =3D sizeof(*frag_head);
> >> +	unsigned fragment_size =3D mtu - header_size;
> >> +
> >> +	skb_fragment =3D dev_alloc_skb(mtu + ETH_HLEN);
> >> +	if (!skb_fragment)
> >> +		goto err;
> >> +
> >> +	/* Eat the last mtu-bytes of the skb */
> >> +	skb_reserve(skb_fragment, header_size + ETH_HLEN);
> >> +	skb_split(skb, skb_fragment, skb->len - fragment_size);
> >> +
> >> +	/* Add the header */
> >> +	skb_push(skb_fragment, header_size);
> >> +	memcpy(skb_fragment->data, frag_head, header_size);
> >
> > here we are copying the data right after the Fragment header. However I=
 am not
> > sure we are accessing aligned memory because:
> >
> > ETH_HLEN + header_size =3D 14 + 20 =3D 34
> >
> > To speed up the copy, wouldn't it be better to allocate ETH_HLEN +
> > header_size + IP_ALIGN bytes like we do for other packets? (you can use
> > netdev_alloc_skb_ip_align() like we do somewhere else).
> >
> > In this way the memcpy will access a 4bytes aligned memory (if I am not=
 wrong).
> >
> > Can somebody else comment on this?
>=20
> I did a quick test by adding some printk-debugging after skb_split() and=
=20
> skb_push():
> 	printk("data: %lu\n", (unsigned long)skb->data % 4);
>=20
> and it seems like the skb->data pointer is aligned to boundaries of 4 in=
=20
> both with and without the use of netdev_alloc_skb_ip_align().
>=20

Because in x86 NET_IP_ALIGN is 0 since unaligned memory is correctly handle=
d in
hardware using DMA
(http://lingrok.org/xref/linux-net-next/arch/x86/include/asm/processor.h#40=
).
I don't  know if my explanation is correct, but refer to the link for more
details :D

> This was done on x86_64 virtual machines. Is there another way this=20
> should be tested or maybe on some different architecture?
>=20

I guess MIPS would be a good choice (like most of the routers out there).
Please, put the printk before and after the push(). Before the push it will=
 give
us an idea of how the header is going to be aligned (which is the most impo=
rtant
case since memcpy does not care about unaligned memory - it accesses memory=
 byte
by byte). You can try to do this tests on the x86 too.

> The next revision is pretty much ready, but I will keep it back a bit,=20
> until someone clarifies this align stuff :)
>=20

Thank you very much for these tests!!


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRncVmAAoJEADl0hg6qKeOPREP/REq17DsbEIKW0ut0pS7DdSM
XQFeMtIjbNAcjLJjbraTidLFhRcwNEFLTf7gsRctX0pN6n3ifbAd+Ho7gJ6Uu9A/
cG7WVVXaP0giEzSoWIElkv3J4eqEtlVcGoHw5KkL5PVVn5bEs7O4umon7LQurvUC
i3Zr7KC45ntxxv6KGJ2+KyxkQ4e0rWTCH9YMbAOqGnUAcTYbi1otsZL9Za3iXiaW
0s2M8lZRXlu0Y2wjRNnYMnzKbI/t+LaqX2Z5PtAlf1AdPebArIe9lwGReY2cjh4u
vwdH2KFTHhAthrLWETAZW1l8/JuM9yvB4fML0kFHLmBTC7NGqIk5PVTK+aZEi2ar
ScxF+flB7g3RbQdVTG1kxhirZVHhnOLkaH4126ULKAtKvnZsna9DRshlRP3Kn/rS
J243uIJmX07aeE5FAoPPGk2666/kC5kQA27oACNdhgMZ2nVHPDTTKMUTFwhszzau
JZff4lZ7BUjZsP1su9uRIvgL2kpxXJfXYPhny05H+r44rPFfAldnk51tZIHzmjeZ
7orpqdecvvyq2yQ/D3CeX5J0DxBUo2smQuabjPDj9Y5Q8L9689/QVJqsgfRZKvmw
kOC8jJmXrAO3jESKLSW3+F12lk3q6Vp0Jvrd4E9cehYmoFDESEpnb0HKwsrQOYx0
PJTWYn2KD13IwEsR3moq
=kFGE
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
