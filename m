Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Dec 2015 17:40:45 +0100
Message-ID: <1911165.iLNu9IsRoq@sven-edge>
In-Reply-To: <CAKrZ8yfd=zBDtwkPK-TeqV9paqw3oMs1c6kEMiuTe_ZzYDOVhQ@mail.gmail.com>
References: <CAKrZ8yfKQi8qBzmC7BrEA6Sfug9JB4hb5q_M6p20Ay-V35-F4A@mail.gmail.com>
 <2050614.B3W5htgYl9@sven-desktop>
 <CAKrZ8yfd=zBDtwkPK-TeqV9paqw3oMs1c6kEMiuTe_ZzYDOVhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1526259.MYZCICeXAY";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Super high package loss and weak connection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: no name <keinepostnurmuell@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1526259.MYZCICeXAY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 18 December 2015 17:12:50 no name wrote:
> I gave the the packet stealing little bat a thought ...
> 
> I dont think the antenna is an issue, because than I would have an
> increased packet loss over distance. But I did not have that. My
> Packet loss on the same table:
> 
> 56% Packet loss if 20cm distance
> 50% if ~ 15m apart.
> 
> When having an antenna problem I would think that distance should
> matter more. Dont you think?

As said before, there is a lot more than the antenna which can be bad about a 
device. E.g. the PAs, driver, firmware, the open+running microwave oven next 
to it, ...  Just because I mentioned the miniature antennas as one possible 
problem (because they are unreliable in things like the linino) doesn't mean 
that we now have to ignore everything else which was mentioned earlier (or at 
the same time).

And just looking at the batman-adv layer might now help here at all. First you 
have to determine what of the parts is broken before finding out how it can be 
fixed.

Kind regards,
	Sven
--nextPart1526259.MYZCICeXAY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWdDcNAAoJEF2HCgfBJntGOu0P/35YUHPjSEAzlbFbmz38S6GF
YPOihGkP5hnpS1NvUrRJporMAEtSdLbHMrT4KkbLYsuzE3kVAujnvmRHWByPKtfK
zajfq7YSgR8MMh/hrPHgwPDsE7PTXHlyfWwG7ObsOGk7Mdcwjt4qAVD3as9gcUys
IvOFjM/G8+jGtaBhzXjlu2IErTiTuvzpXMvfmW+/qx2S4RSZbKlOPVm/h/tyzGwp
QBvOG3MWkmNQw5f7Ikby3OHJXxEhtAnC5yYsKHluGtvuB1cc7FXgPF2Pg1X7kvwA
Hhgm40u6Gu7++hNIHDC+U6KY7nk+TEyaAGA5V5uApjz/NFp8oyDyYa65pUQLjhU6
3HAo+ex3saGhvJ0M3S0t9mlVMwoAYLrMZTeGVWDSfbNepZnkTlR5EyuSEAQJtLXy
ytwk8qaAOuBPfOKLTN0rmXD552tSI2eD+gilcH2ffSzfLIn+lzAh1iwoHqv2Gcux
Xr18NeWpzKf94PjdgBM2kLvAps1xsMY+p4r0znGrK+Xm9Smb+Wb5dEhbXgJzbOvd
4EEvQ3qc60a5RcKskAp+eI8KrsQnUcBnus/DirEA/BX6wklA+sm8fkBUCwAHN6E9
2+C5J4sbOLT2cBK1vCtgC4T/pFkELxUGHn7iZFCBDF1U2NaB8tD0K/Cr0twyQp3G
0yJNwsXc1n5fSdadGNFR
=9iQQ
-----END PGP SIGNATURE-----

--nextPart1526259.MYZCICeXAY--

