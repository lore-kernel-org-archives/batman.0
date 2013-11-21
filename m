Return-Path: <antonio@meshcoding.com>
Date: Thu, 21 Nov 2013 15:40:33 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131121144033.GF311@neomailbox.net>
References: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
 <528D81CA.8000106@universe-factory.net>
 <20131121072143.GD311@neomailbox.net>
 <528E115E.6070901@universe-factory.net>
 <20131121142010.GE311@neomailbox.net>
 <528E193B.3070701@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <528E193B.3070701@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat code for kstrtou32
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


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2013 at 03:31:23PM +0100, Matthias Schiffer wrote:
> On 11/21/2013 03:20 PM, Antonio Quartulli wrote:
> > On Thu, Nov 21, 2013 at 02:57:50PM +0100, Matthias Schiffer wrote:
> >> On 11/21/2013 08:21 AM, Antonio Quartulli wrote:
> >>> On Thu, Nov 21, 2013 at 04:45:14AM +0100, Matthias Schiffer wrote:
> >>>> You are casting a u32 * to unsigned long *? Won't this break horribly
> >>>> when sizeof(u32) !=3D sizeof(unsigned long)?
> >>>>
> >>>
> >>> It will break when sizeof(unsigned long) > sizeof(uint32). For exampl=
e on
> >>> x86_64. Hopefully nobody would use such ancient kernel on his machine=
=2E But you
> >>> are right.
> >>>
> >>> What do you think of the attached patch?
> >>>
> >>
> >> That's better, but if you care about overflow, you should add somethin=
g like
> >>
> >> if (_v !=3D (unsigned long)v)
> >> 	_r =3D -ERANGE;
> >=20
> > yeah, thanks! I'll add this!
> >=20
> >>
> >> Also, the comment in the line above doesn't make sense anymore...
> >=20
> > yeah, I removed that already.
> >=20
> >=20
>=20
> Ah, and I overlooked that you have to dereference v and take the address
> of _v;

yeah yeah, this snippet has not been compiled at all.

> adding parantheses around the parameters might also be a good
> idea as it is a macro.
>=20

parenthesis in strict_strtoul() invocation are not useful, but yeah, they a=
re
good around the rest.


--=20
Antonio Quartulli

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSjhthAAoJEADl0hg6qKeO+WUP/3wpLJB/F+KEW7qxxiyjjJKO
bEs2F78EEI4qIRe+JDyR5jSyE9lhQDuq4pIddBZ4Rahh+t7PmbdIVIFSO74KQR1V
N9zKxlM3YJQj87CxPSxnlwJ6gZldnjLo5sWcncPOz6+A6EBZZ8/VL//R6CUAhxNz
MNYJiUzmNnQuPwZNN3C5qtUm/6tfW2gi2l+TchAel2JUK60NBHYR0q0Rgf0F1phM
eo3G1gdMUvb/fbYlr/CaRUDkbQlUgu3ePYs3KhRNWLB6TWQTyq7DeQAoEhPhBr9T
XOrJZjQhPLOWjmXiU4AvbqSNWfrp9KHjmpwdxfOHM6/L3MfRo8f8B7KSozWf/5nn
FE/hn2FvxPhT0brwS/zZ8VFvVh/D7jObda3N8UDS5mxeY9TUMt5Ubd8mPCb5MyHR
04r5dhk3fFKNDsmweQvKY6kp/e1IK5VLlKDH20kW1OhPyhg58W6K1zjkniztDtEj
Me7pr9AKDX8ziNkEETIiubRBdDEmBiVV1gJdk6OxZm18YPWYzwqnMn4Y28pzSJmY
g+euJCXgyc0DmaHggCzV11yZ5FFtfkFFqrHZB88nMppwvO1/RCY5qGfuLgzYDP/X
mIE8qNCWQj9vqtwqH++SWgS2jeLJnG4hsbu1jfPi9ItTtwvW+3NclXeBsUSbw0iG
xCFvQgCrxL04J0/O+R0B
=bmD0
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
