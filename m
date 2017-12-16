Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Sat, 16 Dec 2017 09:45:20 +0100
Message-ID: <2130928.Gov3uGz9Ek@sven-edge>
In-Reply-To: <CAF=yD-LSwR3ggm5Ss4sLNx08bG8ks5TT+SvryDK5ReKtv1-dBQ@mail.gmail.com>
References: <20171215182313.15767-1-sven.eckelmann@openmesh.com>
 <CAF=yD-LSwR3ggm5Ss4sLNx08bG8ks5TT+SvryDK5ReKtv1-dBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17600194.ePNuLTmzPI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 0/4] flow_dissector: Provide basic
 batman-adv unicast handling
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Network Development <netdev@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Tom Herbert <tom@herbertland.com>, "David S . Miller" <davem@davemloft.net>

--nextPart17600194.ePNuLTmzPI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Dezember 2017 17:51:19 CET Willem de Bruijn wrote:
[....]
> Thanks for making these changes. The flow dissection looks good to me.
> 
> One possible issue is that this exposes kernel fixed width types u8/u16/..
> to userspace. For posix compatibility reasons, uapi headers use the
> variant with underscores.

Thanks for the info - missed this.

Kind regards,
	Sven
--nextPart17600194.ePNuLTmzPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlo03SAACgkQXYcKB8Em
e0YhUQ/7BY6lfN2hKcwEoNcyBdmsbIIyYwxCrh1lO112QIXQhP6E8hHSD9qWe8Cw
8Fl8qYKsJ4DNLvzMFTyh9XjAHIHyxEYOn7gwhvhphnqTn2qlXkYhHM0AqN64d1Kq
egnPfaKlepLbr/x1u47Atg6KgAd6RlbILrjiVsnIniGk17Zxfjy/ZQno+UuEF8pJ
A1dEb4pJCvnhk3UpLFxCgHZqlVvzwCVMrwp0xMXCugIaGJO4K2Mxe7tmM2GiAr0z
TSreo6SPrMXDNQ48APLaNLV9zDWW/xLCACBLimE//3GTYSyBWjN8nJePEssQdVh7
pt+LdVS7lvC1H9sYkWHoG7SuZOKteQyTgIl9AbLxABlq9rtnQUSE539UeatgTVTb
Ds7YnEOPKqJYNr4QRxsBDGrOx6YoBj2ONwZLEUSzawMQH05e0NaXR+ki6fby0xGv
l5omGnvn2a3zP30vFns6sUwcXdKZSGi6biJeM+ixj/R1ujR5PL8mQGB+gy1e04YV
MEw/5xnKjCdjxtNsQ3aUv0H/PSbX0mxcjmU2LiVnvwMTZk04xD4nUVGQ1A2vU6fi
iWCu7gXuqlvsukgY6I7V9G0c1piiY6PIboPmEA4SjsZlscNFrfk/2pR5XXgUt/5K
7BNnlhxExyInCduVMjEOBFXLuXS1U+Rsszu8yey9svsftxfzWT0=
=NhkC
-----END PGP SIGNATURE-----

--nextPart17600194.ePNuLTmzPI--

