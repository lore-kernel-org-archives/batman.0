Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH v2 0/6] batctl: Add vid support and hardif settings
Date: Tue, 09 Jul 2019 17:36:36 +0200
Message-ID: <2853563.THXLFkejgW@prime>
In-Reply-To: <20190623130709.24751-1-sven@narfation.org>
References: <20190623130709.24751-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2417226.ZZ80AUtYkC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2417226.ZZ80AUtYkC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

overall I think this is a good idea. Please see below:

On Sunday, June 23, 2019 3:07:03 PM CEST Sven Eckelmann wrote:
> Hi,
> 
> I've asked a quite while back for some ideas regarding the support for hard
> interface settings in batctl [1]. The current consensus seems to be that
> a more iw-like interface is prefered.
> 
> vlan settings
> =============
> 
> The requirement to have a VLAN master device on top of the batadv mesh
> interface is artificially limiting the capabilities of batctl. Not all
> master devices in linux which register a VLAN are from type "vlan" and are
> only registering a single VLAN.
> 
> For example VLAN aware bridges can create multiple VLANs. These require
> that the VLAN is identified using the VID and not the vlan device.
> 
> It is now possible to specify the vlan using:
> 
>   $ batctl vlan bat0.8 ap_isolation enable
>   $ batctl meshif bat0 vid 8 ap_isolation enable
> 
> 
> hardif settings
> ===============
> 
> The infrastructure for the new vlan/vid prefix of commands can now be used
> to introduce another prefix: "hardif".
> 
> B.A.T.M.A.N. V introduced two additional settings which are hard (slave)
> interface specific. These can can finally be implemented in batctl. This
> will allow to change/read these settings when sysfs support is not enabled
> in the kernel.
> 
>   $ batctl hardif eth0 throughput_override 15mbit
>   $ batctl hardif eth0 elp_interval
> 
> 
> Changes
> =======
> 
> v2
> --
> 
> * replaced (while still being compatible) -m option with "meshif"/"dev"
> prefix * added alternative "slave" for "hardif" prefix

I'd drop those alternative names "slave" and "dev". If we want to change the 
naming, we have to do it everywhere. If we don't change the naming, then I 
would say we shouldn't even advertise an alternative naming to not confuse 
users and keep everything consistent. And if don't advertise, there is no good 
reason to parse it and bloat the code.

That's my take, at least. :)

In general, I really like the tree like structure in favor of an unituitive 
option parsing.

Cheers,
       Simon

--nextPart2417226.ZZ80AUtYkC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl0ktIQACgkQoSvjmEKS
nqFapQ//XqgnZgr1hJ7pUqZsv8zAEZAiGrv2py0PKmfejCdf2bF5bZN7b0nD0u34
Y3n5QLsYSuNsiENEUnzvV2m+Y/NvaQxlZcETkV5PuKICCj418k+qZKZ8rXHcQFz1
5d7QOQAtMWvuqW1h47l6qaCk95oULEE2hjCQTYAT0K4lNomUr8MuRbk3Kl2mGzk+
QPdi27/C4dDWVe4Ms9kk2LZf7eOUZuZfJC8afeDCBRZx7+wX22c06HgpHDvNAM6L
jkiOO5kHfjGKHykgrnWAhMKhizGViklPvu+cqxvAW5JrtsjTyDzlJRRTF+3y7f4q
0LyJQktQdm/jO8pBT68DSbySD+dBh9YCgrREooSCtkgA+Cm2T8DXAZAynCARjKx1
7x1Sux+iZQwAADzXiwoEQmUkdhLWwdsB3U2kak7ceWEb9/ILjDa3hFtkjhEYk50R
yF6+V+fDCGmgUcJ3CGb+KZYYY5GIxZrqk/dPZWIH+HA7D3tVSX/gzGALaVxHUjFa
yYjaxrmIrONv91pkGFHXR+roJDbLODANljeybJnfZ7Ub13a++fYTfhGMwwGNJU9w
Y4c4YQf2zo0iV0ADp+IyfycU1iVNgG1Pd2zojF63wblA2qlAsG0wM5bBG4GkTNys
SWR7SIXsLNpJS1W3mla/kksG27LgCmim2s5hnsQAoKdf0DBLY0Y=
=Rayc
-----END PGP SIGNATURE-----

--nextPart2417226.ZZ80AUtYkC--

