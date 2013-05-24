Return-Path: <ordex@autistici.org>
Date: Fri, 24 May 2013 11:06:43 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130524090643.GJ1679@ritirata.org>
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
 <20130524090050.GA8944@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Content-Disposition: inline
In-Reply-To: <20130524090050.GA8944@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2013 at 11:00:50AM +0200, Linus L=C3=BCssing wrote:
> On Fri, May 24, 2013 at 10:02:25AM +0200, Linus L=C3=BCssing wrote:
> > This is the second revision of the basic multicast optimization patches.
> > It includes one functional fix and many style fixes, thanks to Antonios
> > feedback.
> >=20
> > Three things were not included from these suggestions:
> >=20
> > * The default mcast TVLV flags were left as it is not as easy to
> > switch. (see answer/explanation to [PATCH 2/3])
> > * for_each_pmc_rcu() was not moved to a commen net header file,
> > only a TODO was added. Will do that after this code might have
> > landed in net.
> * VLAN support was not added yet as this will be some more work. Any
> vlan frames with a multicast destination will still get flooded
> for now so at least these patches shouldn't introduce any
> regressions for those. However I have to admit that I didn't think
> of VLANs yet and Marek suggested to check how much extra work it
> might create later compared to adding that right from the start.
> I'll have a look at that.

I think (but I am not sure) that the TT-VLAN feature that I just sent to th=
e ml
(I have to send v3..) could probably help in this direction, because a TT e=
ntry
is not defined by its MAC address only anymore, but by the couple {MAC, vid=
}.

Since your code uses the TT to store the multicast addresses, I think that =
VLAN
support can be added "easily"[tm] after the TT-VLAN code will be in.


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRny2jAAoJEADl0hg6qKeOJIcP/0YuOIsOCe6xH+zbd7DUx+Ue
MMb/5Z9crrFY/2317EPInvcJfDxwZnUIYv8pL9sM9m4WscnRIhp0FL6znf2WO+NM
fUCKGnJTAMDP7N+8VytkOjEHPbX+AiRUSSUpGu5Bcd7+AitgWyGsjOcluvhyPsOU
Ti4PxWAJydMlw+7igrJIKrP6W1y95wL+aCDkdCVtaYoA/qEZolrGQMf/0yLtkKqN
F0T05D4JmAFOHYfW7pm/VqFrOj3ZGS7ozovBjr/ayno1H/ae0GYwPiRUIXfSXcIy
MDxQplU3ccdoaAnRLg80MIMlbnHZCdZ/sb5cj1mxufSxS0xmGAgJxzV7f1rB6iFV
Gxwf6yhQ6vqsoofb5pvtDzJc8OkeifimE0uBkQu1qUA0kZWcgq6AMEeejCAQaF8M
oLJTCsXvQY9yZPNBo0Of9gYBaM6DPen1Jp3RmDGIZC6TfQwMBfKOTISYc8O6I53n
Mu0HPW/E6r2dltbkCfQoWI9Chk44qFJhl433bOMIAyqaOhSg4T7/yeFLLo7+uYKy
tVgaY8JQu8CVg0MVMWrfnGSzcKdYNpTjuIVgME9c+nEaNpD344tF+dpwPTXSTFK4
54RwW+mLv/fTzFqmLhSWFZWSO1jlGRbg7YOCBzzMHe0tGC/ZyXo8mBXeBEXiu8TN
CHX0vfgPz6bqAOJZWI/5
=jSl3
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
