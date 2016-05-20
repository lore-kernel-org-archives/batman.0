Return-Path: <a@unstable.cc>
Date: Fri, 20 May 2016 21:51:38 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160520135138.GV12056@prodigo.lan>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9Wosya/OiUJZ+2ov"
Content-Disposition: inline
In-Reply-To: <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
 snooping received ip traffic
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


--9Wosya/OiUJZ+2ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2016 at 10:58:23AM +0200, Andreas Pape wrote:
> Speeding up dat address lookup is achieved by snooping all incoming ip
> traffic. This especially increases the propability in bla setups that
> a gateway into a common backbone network already has a fitting dat entry
> to answer incoming ARP requests directly coming from the backbone
> network thus further reducing ARP traffic in the mesh.

Any IP packet can't be sent if an ARP "handshake" has not been performed. T=
his
means that when you are snooping an IP packet you have already snooped an A=
RP
packet slightly before. In which case do we really win something ?

On top of that, don't you think that snooping *every* packet will badly aff=
ect
the performance ? Have you tried measuring the difference ?


Cheers,

--=20
Antonio Quartulli

--9Wosya/OiUJZ+2ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXPxZqAAoJEJ4aZjxxc6bK6UwP/355RklNKlYXz5ZZhjxyNuK6
wlbnuBxHPt6raPyRQTwmA/O17JWYtJhUJti+DaHTU4G9vurZr+KhPpyC4WSotu4u
cDm6R9Bgh5SLdLyYovlUJjS7kusKju/6VUevUP23rpFX2uxymQLjf/iYa34vX1Si
Of/XqAXadTgU/JbtSKp136dqU/JAgfbsA1jyoNeClnt2V5Xf3Y5r22Fcbo+++pQW
ePqLpKZk+EE0iW/4Kq9zJL7+9JAXOibau0yt0k251xpdGorO5Yn+B3qQeIZRxpHf
Hs7lKtYWWMz41xVYazsmv67h4x3+abwD2mO1VmNToHqNrnjRQwrGw2GCbQkaV3wd
V/n1OC4VdQaWEa5GbMsW2sNLVoLBZwJQnyjvtjbWDp2iSqXZjCdlGFa5BsjAfiVM
xmgYdlrDHVf2qIRBSFHU4I7uTaQTEDx+oiPBVm32I9qOaubOfnpsMiCb6S7n1qMk
8Zzx43sjBaqFbe8GMHN6nz46zZnadCUPEowJDNqkeO8A6fi1rMLQd+GBoIJiodvr
5K7GwQK6LCmTL6R6apv+3b3lD/sfZulHT+MpdUbBBkyyMS4GfF8LHyLXtUFaenDl
SgxHFaEid2ywZo7lfygICeCZ9bdtNzDLchAFtSAhIjgrhPVyLAswH0t0b0QMpHpg
/AhAvwlksy4IJZjuwCTq
=0AMs
-----END PGP SIGNATURE-----

--9Wosya/OiUJZ+2ov--
