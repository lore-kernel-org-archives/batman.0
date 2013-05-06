Return-Path: <ordex@autistici.org>
Date: Mon, 6 May 2013 08:05:32 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130506060532.GJ3773@ritirata.org>
References: <1366727676-23233-1-git-send-email-ordex@autistici.org>
 <1366727676-23233-7-git-send-email-ordex@autistici.org>
 <201305061131.01113.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4ndw/alBWmZEhfcZ"
Content-Disposition: inline
In-Reply-To: <201305061131.01113.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: make the Distributed ARP
 Table vlan aware
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


--4ndw/alBWmZEhfcZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2013 at 11:31:00AM +0800, Marek Lindner wrote:
> On Tuesday, April 23, 2013 22:34:34 Antonio Quartulli wrote:
> >  /**
> > + * batadv_dat_get_vid - extract the VLAN identifier from skb if any
> > + * @skb: the buffer containing the packet to extract the VID from
> > + * @hdr_size: the size of the batman-adv header encapsulating the pack=
et
> > + *
> > + * If the packet contained in skb is vlan tagged then this function
> > returns the + * VID with the BATADV_VLAN_HAS_TAG flag. Otherwise returns
> > BATADV_NO_FLAGS + */
> > +static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int
> > *hdr_size) +{
> > +       struct ethhdr *ethhdr;
> > +       struct vlan_ethhdr *vhdr;
> > +       unsigned short vid;
> > +
> > +       ethhdr =3D (struct ethhdr *)skb->data + *hdr_size;
> > +
> > +       if (ntohs(ethhdr->h_proto) !=3D ETH_P_8021Q)
> > +               return BATADV_NO_FLAGS;
> > +
> > +       vhdr =3D (struct vlan_ethhdr *)ethhdr;
> > +       vid =3D ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
> > +       vid |=3D BATADV_VLAN_HAS_TAG;
> > +       /* ARP parsing functions jump forward of hdr_size + ETH_HLEN.
> > +        * If the header contained in the packet is a VLAN one (which is
> > longer) +        * hdr_size is updated so that the functions will still
> > jump the +        * correct amount of bytes
> > +        */
> > +       *hdr_size +=3D VLAN_HLEN;
> > +
> > +       return vid;
> > +}
>=20
> This is a very useful function. Why do you make it DAT specific ? The oth=
er=20
> patches contain the same vid extraction code over and over again. It woul=
d=20
> make more sense if you added this function with your first patch and make=
=20
> everybody use it.

mh, I agree, I simply have to remove the last line (about hdr_size - this i=
s DAT
specific) and then I can export it. Ok. Actually I did not introduced this =
patch
before, because most of the code to check for a VID was already in batman-a=
dv
and I simply extended it.

Anyhow, will do this in the next iteration.

Thanks


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--4ndw/alBWmZEhfcZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRh0gsAAoJEADl0hg6qKeOlmIP/RW7zfSlnfVoYMYakuKKjNjW
FznpeXJLzK0zpaylW4atdnBdhWeOIbOd5pNuAnWajnjlYBV7CTmfLLq38cpPEk4/
3y2E9sGPGMsxlv3C3kVN8lxVLzcEU0AK8EunBYX2OG3K9xHh851AVRS0y1dXmgz3
thB9cKF0r+7+lqCkjqAha2/oM8UCNgOi50YmfFDoeA1kPZaQFa+jGuZD9rEz8j1t
ed4Q2XsFxcu3wLCyxgiEpiDfW2mDmX7SNAiK5Wjp1Td8DY/3qiyG5UxPN82JAQto
DayHtylpP96GJEjZuP0D7E9bu1dn9NttqznoeQ1QgNIZWhDpmuB5xe5UD/oo1IFh
36cEbQXN0UwJqnJbBok7nkmRo2mvTBKCjsbgsDNWku4kf6g8+QXHqq1T79CD7orz
FwNAXcRhZFPxoUmxdjto704rSxQYO8yvrnf39+oET0DiTcD/suemg/TaYI7k3GR5
ahM1E/8RHEbbP5UQ8byX0GSvRV4JYMM4Ao0Rv8626YZpPSXrPyyZN/+t7D7xL/cs
lNO6Y8d3FiQkJE5t4GxEnXkuE87btjpW2UOWmD21inuJmuf0shnxgnVtK2Nht6W9
5DivmbpXgdDOV6xBQVVhx2N9BsRPSjzkXa8PZ5i44vmk4iOtV+1T1EM4LSnG1GWm
Cd4azu6kDOj/fCfrpVT7
=IMNs
-----END PGP SIGNATURE-----

--4ndw/alBWmZEhfcZ--
