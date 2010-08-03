Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 3 Aug 2010 10:40:30 +0200
References: <1279923269-26513-1-git-send-email-sven.eckelmann@gmx.de>
	<201008011728.53733.lindner_marek@yahoo.de>
	<201008011758.54120.sven.eckelmann@gmx.de>
In-Reply-To: <201008011758.54120.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7504556.ngRsyMOADC";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008031040.31439.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Only copy skb data for
	multiple broadcasts
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart7504556.ngRsyMOADC
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Sven Eckelmann wrote:
> On Sunday 01 August 2010 17:28:53 Marek Lindner wrote:
> > On Saturday 24 July 2010 00:14:29 Sven Eckelmann wrote:
> > > batman-adv tries to resend broadcasts on all interfaces up to three
> > > times. For each round and each interface it must provide a skb which
> > > gets consumed by the sending function.
> > >=20
> > > It is unnecessary to copy the data of each broadcast because the actu=
al
> > > data is either not shared or already copied by
> > > add_bcast_packet_to_list. So it is enough to just copy the skb control
> > > data
> >=20
> > I think the reason to call skb_copy() is the following dev_queue_xmit()
> > call which will consume the given skb. If we consider a case of having 3
> > interfaces all 3 cloned skbs point to the same data while going out via
> > different interfaces ? I wonder whether that can work ?!

We discussed that off the list. This part is addressed in
 [PATCH 1/7] batman-adv: Keep header writable and unshared

the problem we found was that our data is maybe still be queued somewhere=20
after the dev_queue_xmit. This means that the header part is still be share=
d=20
and we may not be able to change it in our new clone without side effects t=
o=20
the other skb. To prevent that we use skb_cow_head to ensure that our new=20
added header doesn't interfere with skbs using the same data buffer.

This should reduce the overhead created by the skb_copy in many situations,=
=20
but still allow us to freely write into the new pushed header area when the=
=20
skb would otherwise be in a shared/cloned state.

Regards,
	Sven

--nextPart7504556.ngRsyMOADC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMV9X+AAoJEF2HCgfBJntGx68QAJemFDNBp0J/T5U5G3mKeQcf
bmDSfYcrI9u7LnLy4409bQ6uzNliXu/Fb9byd+i+Eta5OXKdisgmXv3YIMiAjpCr
u72OgqabrFaqrzYRVy8ivLHmiI9YYq8jzSXro0KtWuu4ADcIh6Dl7bzaatO+OWVW
Btp4DYpUFicOwQjjBXd2CDi/OT6ydZy/W6VdYJVlmPRNSN09JvJ+HlbiGPYQGMz1
0Cq+WbC83JgPeVYB59cFiCaTijGRHkiw3Be3pxuyZE2tkJlgA7yJd/EAroqdunY4
luTk7geoBZNNvfMbwQY+hdrvfl3H8ZC/zhHC/hyhKhFYtDt1IDq+DCO6SiPJOWCb
k1EMe6/fqYea07NKn4smolA7CPcfW/vbMOA9/NCrVMNQro2X/aMBMcN27O2Dc6us
MYFfZdd2UXKtIsmEEnpldzd3/d+FdC+l5vmbMst2d5UDnHYJeZifTskYbT6fjTU8
hlFesfS7jh6lX+6rYY2fXcaVX1caZSIMGhMLj++mE1bm8YHRWwn0AAIUGlfqqPWT
1/PhH0c/IW9WXRunySlJczWpA81vdK7vGTLodnkBTCij6wuwhwnChOkkFRxP1wNU
Li+iI5aruAGoJdl34im/mszZGdHoyFgL4g7QK+i6mtphajvn3bfzkUYSQfzDVAIS
Z9C3kKzABzdDtFtVaMGi
=LIlH
-----END PGP SIGNATURE-----

--nextPart7504556.ngRsyMOADC--
