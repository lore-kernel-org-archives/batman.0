Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 23 Oct 2018 08:29:05 +0200
Message-ID: <2008119.62L72lsrl6@bentobox>
In-Reply-To: <e287b33a075cd802539d75d95319805eee0010ea.camel@sdl.usu.edu>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <03b201d46a7c$dd0b47e0$9721d7a0$@sina.com>
 <e287b33a075cd802539d75d95319805eee0010ea.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3962130.Z4tyKqcQ0V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: "guohuizou2000@sina.com" <guohuizou2000@sina.com>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart3962130.Z4tyKqcQ0V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 23. Oktober 2018 04:04:42 CEST Jonathan Haws wrote:
[...]
> > I have a doubt for the issue.
> > Alfred should send the info by multicast packets. So the packet's dst
> > mac address should be multicast mac address.
> > The packet with multicast mac address should be received by all group
> > member, isn't it?
> > Why does the mesh point need peer's mac address for sending the info?
> 
> The rest of the devs may be able to answer better, but I believe it is
> how alfred does its data storage and mapping of the source.

Correct, alfred is storing the data from each server using its mac address. It 
is also looking up the TQ of master servers via the mac address. And the mac 
address is expected to be extractable from the EUI64 based link-local IPv6
address.

And of course, Jonathan's IPv4 implementation must get the mac address using 
different methods. It is using the function ipv4_arp_request to get the 
information from IPv4 neighbor table. And it looks like his implementation is 
missing a reliable way to fill this neighbor table.

Kind regards,
	Sven
--nextPart3962130.Z4tyKqcQ0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvOv7EACgkQXYcKB8Em
e0a2/A/+NZpL9i32cxnk1v9Jz8C3CmpsHvY9hodD++babAF3XxMPMqrQs+Ids3KC
jfq+B1KQuOzsZaTRGL0zWMkwMRJRlor2UMhyyaTCO9UOlrLbOckAzV2m2o2FPixB
4oUGqL6TegKgVtLg4beI/2HaO65IzpaDe9XArmTR4uDRDg6SdW8jicHbsMR76SK2
dU62DiWbNGWrnZ3ACKt3uTpuBXjsOH+6F+zS2bBlBGrFrGSNPXmG+9UKXljUSVBj
eyV+106fjfdhXBnxI0PeqV+1zRe3Zp5VCX85jdD/Vr1A9iKoPOOI3zfGP/NpExrr
CU3LWLLNkm5QwIvl9n68SZBYvg/ZZ+s+MqgadAx+1Ya/VwY+wgdw1Q79/me7ukpE
/+i2m2u2Q/UApC5HoBozSP1NZwpNJMO+27u99afZLhhcrvt86tPh85mNgCWZUPIY
8gKFhLaqpwST+Euqw5Bx4fU1RjjmzAn0QEnSA8Hx/Ab9bVDWbEcdbGRkMNNV0Ain
ZF0km1dSL7vt+jL++TAPMYnla0mIH05y3mWxSHFOSljulTp1lBO1Klt7UWBdiSwC
g7PjIRhkYffRD3OoMVAU31bSldfrL/NrX8b6UZhNwW8PbHxioOK3LQp9eZog1v40
oY/UoIFN12gpM41P4jPt3mP1cxXzh6WgLTYFsLwmQN7xLDHLOO0=
=c9Mb
-----END PGP SIGNATURE-----

--nextPart3962130.Z4tyKqcQ0V--

