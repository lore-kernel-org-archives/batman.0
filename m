Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Sep 2014 12:48:17 +0800
Message-ID: <1476633.P9Mkhp99xZ@diderot>
In-Reply-To: <CAEbDFcQ=SXy4OrUrD99Fi4nN9kLdNBTyDwr0Sr6HS5tDmUm4Kg@mail.gmail.com>
References: <CAEbDFcQQMaRNam=ZWBqV4yOke2SZjE8JbpDNTQKcTzzHEz=Vhg@mail.gmail.com>
 <541C2B58.8070703@altermundi.net>
 <CAEbDFcQ=SXy4OrUrD99Fi4nN9kLdNBTyDwr0Sr6HS5tDmUm4Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10187442.YjBrRtJ0Yx";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] traceroute help
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


--nextPart10187442.YjBrRtJ0Yx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 21 September 2014 12:27:37 Krishnathiepan Rasanayagam wrote:
> this is the error i'm getting for batctl commands like tr and p.
> batctl o is working fine though.
> 
> 
> Error - can't write to batman adv kernel file
> '/sys/kernel/debug//batman_adv/bat0/socket': Invalid argument
> 49: *   *   *   *

Try not mixing different batman-adv and batctl versions. Use batman-adv 2012 
with batctl 2012 and batman-adv 2014 with batctl 2014.

Cheers,
Marek

--nextPart10187442.YjBrRtJ0Yx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUJ5MUAAoJEFNVTo/uthzAfhsH/0kbn6QkIxtleezg46TY7fyq
ZgbSOa72WrWG8jEyu4Bnb/XfH8qLxni6Jo5/3O4N8e7yYi3IPF+H7w+1g8bLv2KF
90pTxQxfqRYVlOPQZLLUXdUdjoiTODvqbrjbotsaD32RI38dY6kfUZyUEfgXCndi
HTioJkMvdrhaG3YGoV0ImGTqNmUUX59lDiarorXrt8XAkSBSzzGa+mNQh+FrSsHs
4trs5keZPrsTA/YO//kdw0mflDxgRe4jGQrBqIBgG2QWAj2odDtk63uH03SaDlZt
zvpSWjkjrnTJZd5RcrFEyHWXlCYp5XAap5PzFYyNkM+DgJXFz8meQBVQh0tg0PI=
=+hEy
-----END PGP SIGNATURE-----

--nextPart10187442.YjBrRtJ0Yx--

