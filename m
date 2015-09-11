Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Sep 2015 13:27:34 +0200
Message-ID: <2577570.dDtkYHOgor@prime>
In-Reply-To: <CAGa=++S6fv_+JvpuQ_OJj7XfnF6M7xBOAJN_rQhbGYLB8nH2+A@mail.gmail.com>
References: <CAGa=++S6fv_+JvpuQ_OJj7XfnF6M7xBOAJN_rQhbGYLB8nH2+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15181263.iuPx3hRrL7";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Quickly setup a virtual B.A.T.M.A.N. network
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


--nextPart15181263.iuPx3hRrL7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hey Germano,

please check out this webpage:

https://www.open-mesh.org/projects/open-mesh/wiki/Emulation

we use this for developing stuff, too. The idea is to interconnect a couple of 
KVM virtual machines running OpenWRT using vde_switch. With that, you can 
easily run ~20 nodes on one PC with arbitrary topologies.

Cheers,
    Simon

On Friday 11 September 2015 13:15:15 Germano Massullo wrote:
> Hello, I need to setup a virtual environment with various nodes that
> is ready for testing B.A.T.M.A.N. and Alfred. Is there anything that I
> can use to quickly create such network?
> I successfully created and runned Alfred and B.A.T.M.A.N. on a Fedora
> virtual machine, but I cannot setup a real batman-adv network with
> real nodes right now but I would still like to be able to test and
> work on Alfred.
> 
> 
> Best regards
> Germano Massullo

--nextPart15181263.iuPx3hRrL7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlXyuqoACgkQrzg/fFk7axbPIwCgthGG8iiR/k9FM03Rp2ATDCNg
W6oAoLJsnsFWs4t31Fe2w7KI1bQ+ojKI
=kPkp
-----END PGP SIGNATURE-----

--nextPart15181263.iuPx3hRrL7--

