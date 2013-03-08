Return-Path: <ordex@autistici.org>
Date: Fri, 8 Mar 2013 10:33:41 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130308093341.GL1400@ritirata.org>
References: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
 <20130301110809.GC20607@ritirata.org>
 <CAP5XTDMV9dQucnRpe-fHvKUt-E3RKzEPQcNruG--fA8BnCv7UQ@mail.gmail.com>
 <20130301114300.GE20607@ritirata.org>
 <CAP5XTDNVPDVD_CXUScqc2D8D4+Xh7NFn=4YM6c8aBmjF7Lbi8A@mail.gmail.com>
 <CAP5XTDNdnZ_-BYJ+1ZtXdoBbh1kD0yD+=Cibs3GG4-yyZbSRzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NZiXfHLGvOGtDZMn"
Content-Disposition: inline
In-Reply-To: <CAP5XTDNdnZ_-BYJ+1ZtXdoBbh1kD0yD+=Cibs3GG4-yyZbSRzg@mail.gmail.com>
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


--NZiXfHLGvOGtDZMn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 11:22:37AM +0200, Mihail Costea wrote:
> Hi,
>=20
> I have created a patch for this, just that is quite big (~ 450 lines
> the whole patch, with signature, etc). It doesn't contain complex
> changes, just small changes from __be32 to (unsigned char *), a new
> parameter to functions in order to give the IP type and added
> comments.
>=20
> I've tested it with the snooping mechanism I added for IPv6 and it
> works ok (the snooping mechanism is not in this patch).
>=20
> What I wanted to ask is: it's ok to send a patch this big to the mailing =
list?
> I don't see how I could split it more because all I did is changed
> most of functions signatures and edit the code to support this
> changes.


The common rule is "one change per patch" meaning that if you can logically
split it (e.g. 1) add this 2) use this there and there 3) improve that) it =
would
be better to send more than one patch in one patchset.
Remember that each and every patch must compile.

Cheers,

p.s. if you want you can send the patch as RFC and see the others say (but
please try to think about splitting it, if really needed).

>=20
> Thx,
> Mihail

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--NZiXfHLGvOGtDZMn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRObB1AAoJEADl0hg6qKeOiUsP/302GaUS1rqai3KViogZ5jxk
raGm5Dgg2Vc6/XA9Gq8HrxAypLSf/m1WjGniHA5um5FPSBWbRuve/2Kq1D/EREmE
CXp3FhqnF2BwRY9cEqUnfFHZIfYEMi/1n4PHlS+uGXANYEN6Xu85cFvHUxBDKRJD
AX8ZGeX129sqFdO2LcFcRleVPIpYt6FiBxfDetgD2FSACkv28mmcM/lpkx10mazc
s4F0MEBwp4ghDaTrJmiyqU5NwQGy+RwI3+CHQIRAoTTYcjOQo3g2OXwA9TMm0fbm
gBuxH8GMfxPlj/7CG2kZZQuLQa5tqLTFXA7UTi5QZQ09tjldMKO50Uwu9ycWqX0H
gkUvto56Aru67CQ5WMUvLkJ9+aGF1Fho7oI00OMqUoNuwv7jSrmofB1fwXRS7aQJ
3ubFaIk2Wh+lnuuQmNJNtXW4kpv03tpKXasqoMjCB0RnMfCAQyjiDYITgUbnoFkJ
GJIdhe/No03NSX6RIs6t4tvQqiHHEv+onxoSoZ7LnzyMBxx4p1uKeIX7A2g7zPQ4
eRiUOZLlwpUjrs31Qh2rHhtF9fsyd0yaLkwfH8EfqZ4SNWlF7N950+3XVvVR7Q0w
p1/R9YTLNyNLeC4Yi7+QVn4SGQ+WDvBi5IwVFEggxAIOxFWE9ve3xLPK3Rm+tqJ+
NuP50Wp4Z7Mk96kzA7yx
=ijMo
-----END PGP SIGNATURE-----

--NZiXfHLGvOGtDZMn--
