Return-Path: <ordex@autistici.org>
Date: Wed, 21 Nov 2012 00:41:13 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121120234113.GH3129@ritirata.org>
References: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
 <75191138.5RcUHhBkvt@bentobox> <20121120092421.GC3129@ritirata.org>
 <CAG_HyLwVWZdkDqxEDfDQL0k35UHeNrAOaVqKYJsMeN4VkWucHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <CAG_HyLwVWZdkDqxEDfDQL0k35UHeNrAOaVqKYJsMeN4VkWucHQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman over 802.15.4 .
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


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 03:37:17PM -0800, Randy Graham wrote:
> Thanks for all of your replies, you have answered my questions !
>=20
> It seems that batman-adv is not suitable for a 802.15.4 mesh network,
> so I guess I'll need to look elsewhere.
>=20
> Does anyone know of a non-proprietary mesh network stack for 802.15.4 on =
linux ?
> I know that zigbee has not made into the kernel due to GPL issues.


We are going OT, but it is worth an answer. :)
As far as I know there is nothing for multi-hop routing on 802.15.4 in the =
linux
kernel. So I think you need to implement something yourself.
You can either start a port of RPL (e.g. from Contiki) or you can start an
experiment and try to adapt batman-adv to run on top of those interfaces.
I would say that the second is a really juicy topic.
If you do so, we could also think about having a mixed mesh network, part w=
hich
runs low power and part which runs common 802.11.


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCsFRkACgkQpGgxIkP9cwcgBgCfbUMXhKM2paoHvEbaRMzh2BW+
XCoAn1VjdBHqUK97VRRIsL+RpxWX9w0W
=+LFn
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
