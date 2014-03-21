Return-Path: <christof.schulze@gmx.net>
From: Christof Schulze <christof.schulze@gmx.net>
Date: Fri, 21 Mar 2014 11:39:44 +0100
Message-ID: <17243029.zoeb9UDcFZ@lappi>
In-Reply-To: <1629001.Cx5dbnsKCT@lappi>
References: <1629001.Cx5dbnsKCT@lappi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1527696.fCjirOQTMj";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman-adv  + lxc
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1527696.fCjirOQTMj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"

Hi,

I only saw your replies in the mailing archives, I probably was not
signed up to the list correctly when you answered. The issue is resolve=
d
now but that is why I am breaking my own thread.

> what about bridging the real interface that you want to use for the m=
esh
> in the container and then load batman-adv inside LXC ?
this is in fact what I tried first. But bridiging the interface causes
the batman-adv information in /sys/class/net to get lost. Maybe because=

I have to do things in a different order or because veth is really not
the right interface type.

> > I started by loading batman-adv on the host and bridging it into th=
e
> > container. After adding the interfaces inside the container where
> > meshing should happen I cannot add a gateway because batctl
> > complains that /sys/class/net/bat0/mesh does not exist. Indeed, in
> > the container it does not exist.
> >=20
> > How can batman-adv be used from an lxc-container?

> What I usually did was configuring batman-adv properly on the host vi=
a
> batctl. And only in the end adding it to the lxc-container.  That
> seemed to work for me (except the reboot crash noted above).
what do you mean by "adding it to the lxc container"?  I tried bridging=

the bat0 interface into the container as a separate nic. That did not
yield positive results.

Unfortunately if I risk crashing the host, this option is not viable fo=
r
me yet as I cannot simply restart the machine once it crashed.

Christof

=2D-=20
()  ascii ribbon campaign - against html e-mail
/\  www.asciiribbon.org   - against proprietary attachments

--nextPart1527696.fCjirOQTMj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iEYEABECAAYFAlMsFvAACgkQpZfyPAmdZJmpfgCg1vRnH6kDvzxZyBNZ2/yVld7w
VFwAoMZNBEQ41a6f3d7Y53PBE7BqhV7J
=qFOa
-----END PGP SIGNATURE-----

--nextPart1527696.fCjirOQTMj--

