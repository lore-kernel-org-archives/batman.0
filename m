Return-Path: <mschiffer@universe-factory.net>
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <33aefc13-e1a0-cef5-74f1-d21d7112b7d3@universe-factory.net>
Date: Sat, 7 May 2016 14:15:57 +0200
MIME-Version: 1.0
In-Reply-To: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Rt97rQduPfTeE5DuFUnvxJGvL6O3NJ2Cv"
Subject: Re: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rt97rQduPfTeE5DuFUnvxJGvL6O3NJ2Cv
Content-Type: multipart/mixed; boundary="SkLF07ipolN5GTU2IwetFH59oGr174FUM"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
Message-ID: <33aefc13-e1a0-cef5-74f1-d21d7112b7d3@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
In-Reply-To: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>

--SkLF07ipolN5GTU2IwetFH59oGr174FUM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/06/2016 10:45 PM, Jonathan Haws wrote:
> I am trying to get familiar with the Alfred tools and downloaded versio=
n=20
> 2016.1.  Unfortunately it didn't work - I couldn't get past a bind erro=
r:
>=20
> root@sierra1:~# ./alfred -m -i bat0
> can't bind: Cannot assign requested address
> Failed to open interfaces
>=20
> I had setup batman-adv with the commands:
>=20
> batctl if add eth0
> ip link set up bat0 (eth0 was already up)
>=20
> I rolled back to 2015.0 (per a hint at=20
> http://wiki.pinneberg.freifunk.net/alfred) and alfred started up just=20
> fine instead of giving the error.  However it periodically gives the=20
> following message:
>=20
> announce master ...
> Error during sent: Cannot assign requested address
>=20
> I also tried alfred -m -i eth0 with the same results.
>=20
> Is there something wrong in my configuration?  Can anyone point me in=20
> the right direction?  I've read through the Wiki for both batman-adv an=
d=20
> alfred and am out of ideas.
>=20
> I'm trying to prove this setup and get familiar with it in a virtual=20
> environment, so I am using VirtualBox to setup a network of 4 nodes in =

> my mesh.  Should be simple enough, and batman-adv seems to work just=20
> great - once its up and running, all nodes can communicate one with=20
> another as expected.  Only issue is I am trying to get alfred to work=20
> with batadv-vis to give me a graph to tell me it really is working righ=
t.
>=20
> Thoughts?
> Thanks!
> Jon
>=20

alfred explicitly binds to the link-local IPv6 address of the interface
since version 2016.0. I suspect one of the following caveats might be you=
r
problem:

* The link-local IPv6 address must match the MAC address of the interface=

(here bat0) (derived by flipping the 2 bit of the first byte, and adding
fe80 and fffe); this ususally breaks when the MAC address is changed afte=
r
the interface is up
* The link-local address must not be tentative when alfred is started
(duplicate address detection must have finished; this usually means that
the interface must be up for 3 seconds before alfred is started)

I hope this helps...

Regards,
Matthias


--SkLF07ipolN5GTU2IwetFH59oGr174FUM--

--Rt97rQduPfTeE5DuFUnvxJGvL6O3NJ2Cv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJXLdx9AAoJEBbvP2TLIB2cmm0QANsa6mcc4rpMrfKglKBCIjNi
XAkL9hvKigafxBXKBaUfnTEMfXSRlrixFesRD/VaT9x/fhjQCpRblJQNxRshWFt3
16Y+FTp8D+u0G+ugyo1EzkSAUXxe/IsWWAn8l8LPM3r+Stw8bXoaYFBDJHCHSv6k
Cdb+Trfievc0dk14prxwEnw07UU3QojpsEZjWBcVd56ede0K9UVhvHdzL63e6V9l
II22dT0pXiXYHRntr/qk4nA0pAyaj81ViR3+yuBEZ2dzXiRVqBcS8E12vHKtW3z5
DMupTjNfywiCFCI365DPJKSL6dpMlCpZRnRUc4b2NQSatDt87gwz6ycHPc5by85s
s1+zJ/tkF7Yo9cuhJf75wBxt7QPEnIls6fCnH+0lnxSNGZ1JzUaGj7Oc6saT8Q8k
ZbRgmbNfr1+iaIK499XDlGHZjIqwd7p5KXUf+qLY+6vohaOn81TUnvh0NDRX0QE1
3o+u69uYV2cWZQ+mDPyBBgCv3EGAf9BWtLB6VdliqZKnAHNLVqDGxk89lk9WiRxf
210/X99nxuPn7gW1qXyC+ID9o58EbJXhJBb9KZ1qKKePer6iVTH2oPj/Q4oD2g7x
CzEWI4kNatFvCeLyds/bjtnKty6zu68x/7LvD7B46OjazgH5IygV+Czr32IxxCKg
H9YEFdWj0+9GC91MiyVb
=bu2t
-----END PGP SIGNATURE-----

--Rt97rQduPfTeE5DuFUnvxJGvL6O3NJ2Cv--
