Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 24 Jan 2017 17:05:17 +0100
Message-ID: <1595128.WQAW59UAnQ@prime>
In-Reply-To: <1485272731.2398.15.camel@sdl.usu.edu>
References: <1484884864-7315-1-git-send-email-jhaws@sdl.usu.edu>
 <4448368.uV4yijacOc@prime> <1485272731.2398.15.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2241719.3uAN2ySI4d";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: IPv4 multicast distribution
	support.
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Jonathan Haws <Jonathan.Haws@sdl.usu.edu>

--nextPart2241719.3uAN2ySI4d
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey Jonathan,

On Tuesday, January 24, 2017 3:45:31 PM CET Jonathan Haws wrote:
> > 
> > 
> > > 
> > > Enabled via -4 expert option where multicast group address is
> > > specified.
> > > This option will disable IPv6 communication and is intended for use
> > > in
> > > networks which do not support IPv6 addressing.
> > > 
> > > When this option is enabled, all IPv6 communication is disabled.
> > > Combining
> > > IPv4 and IPv6 alfred nodes is unsupported.
> > > 
> > > Hardware address handling done by submitting queries to the local
> > > ARP
> > > cache rather than forcing an ARP request.
> > 
> > Thanks Jonathan for your patch! I've just looked through the patch
> > and 
> > discussed the matter with Sven yesterday. We are both not too big
> > fans of 
> > supporting IPv4, but since it helps your scenario and you supplied a
> > well 
> > written patch which properly abstracts the address mode and has
> > separate IPv4/
> > IPv6 functions, I think we can adopt it.
> > 
> > Just two general questions/remarks:
> > 
> >  * I do not want to give support for IPv4-related questions of users.
> > Would 
> > you be available to maintain and answer questions regarding the IPv4
> > support?
> 
> I'd be happy to answer questions, but it would be best if those
> questions are directed to the list and my address is in the CC field.
>  That way I'll definitely see it and can answer.  If it just goes to
> the list in general I'll very likely miss the message.  Is that
> someting that could be added to the Wiki?

Hmm, you can add anything you want in the wiki, but it's unlikely someone will 
read it before asking here on the mailing list, at least to my personal 
experience. ;)

But if you commit to look into these issues, just try to catch the mails sent 
here to this mailing list - if you don't i'll try to forward them to you. :)

> > 
> >  * Do you plan to provide OpenWRT support as well? (This is more out
> > of 
> > curiosity)
> 
> I wasn't planning on OpenWRT support. What would be entailed? When I
> hear OpenWRT, I think of the firmware I can load onto my old Linksys
> WRT54G AP.  Would it simply be testing these changes on that device?

Basically we already have an OpenWRT/LEDE integration [1] which provides 
configuration options in a config file, which are parsed and applied etc.

Not sure if the ancient WRT54G is still even properly supported, but there are 
dozens of cheap and more moderns APs you can use it. But if you are not 
familiar with OpenWRT, don't worry, someone else can provide the integration 
if they need it. :)

Cheers,
     Simon

[1] https://github.com/openwrt-routing/packages/tree/master/alfred
--nextPart2241719.3uAN2ySI4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAliHez0ACgkQoSvjmEKS
nqHDnw//UqIjML+jElyRMzxpQgkIrOxbVR8KUI2tAwEiGr/LI96xOGo6rX4UjmwK
HVShOSApphglojOVMcUiJ6681KU20ls7sQX6s59jI/XN+6o+vI+pX0JaVmpmkuSQ
k+TvdGqjdCbjR31sWSK3lJUJcZSban5bu1UJHBa/yLwryRB8amohstojKNr/Bbyz
Qzy8m99h6oH6rURDIrNvLnOWj303KQYELMzlLLtFUhWOxsvHfaICKAvnJ4hZZSup
PGNzwrrtpZ1/BwJS+ACDm5D6hdb4q04GBraDjqrAG1T4OqFkhuH2Abnl41OCf6PJ
9fcOtNCaW9u+bdj8xFv5yNS4ICa2rCnVAoVyoNY9or+FVmm6CfqEq8SSjSimlA8C
Hufd4aPMGH/Tw1WvnnB8sb1ReKCD7oac1eNSCxydW82NKz0a8/yI6es4/e8hFGqU
KKS9Mw8HTsZzAqLIq4MzFq0nMAYJKAJe2WXglLjnoJvU3y+hhZ8eqzIVBoZqI4DR
z+ANV7rJfMBWJgWk8ai2ZNpJ2yF3upKBPUrS/cMYqD1fNE1e0tGQxPKPcqQ0ObEn
WSGdzAwRtkEYTPIEg/bMdPlDy2zZqMykyZQattUFPU/5kLZp+tG7lQ7opOeGzJZz
yb/58fqLFqWkg9DqcHKGHQOEAd5JeO/CHkojZDG/5RwEe/cR3wY=
=pDue
-----END PGP SIGNATURE-----

--nextPart2241719.3uAN2ySI4d--

