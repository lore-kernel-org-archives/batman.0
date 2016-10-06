Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Oct 2016 09:28:36 +0800
Message-ID: <2047209.au5fF7qEnu@voltaire>
In-Reply-To: <CAGghcR5MNrmmeHWZBFFsHC88+Qj+-SW+kf548O23iOu963ZNTg@mail.gmail.com>
References: <CAGghcR5MNrmmeHWZBFFsHC88+Qj+-SW+kf548O23iOu963ZNTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14768910.u4W9EZHJbV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Help in setting up mesh test bed using qemu -
	BATMAN adv
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

--nextPart14768910.u4W9EZHJbV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, October 3, 2016 7:44:47 PM HKT Kaushik N P wrote:
> https://www.open-mesh.org/projects/open-mesh/wiki/Emulation (I am not
> sure if my qemu is set up properly for there is no confirmation
> methods that are provided to me to check if its working properly)

What do these 'confirmation methods' you hope to find look like ? I guess to 
most readers it isn't easy to help you because it is unclear what you find 
missing. Another way to go about this is to state what you have done and what 
you found not working. Then we have a clear starting point. 


> Clarification for my doubt regarding the different types of OpenWRT
> images (like Kamikaze, Chaos Calmer, Attitude Adjustment,etc), what do
> they do and which one I should use for working with standard Batman
> adv setup.

That's quite broad too. As explained already, batman-adv is part of the Linux 
kernel. Most of the releases you mentioned run a version of batman-adv. If you 
want the latest batman-adv with the latest kernel / user space features go for 
the latest release.

The image names you mention simply are different releases (Chaos Calmer being 
the latest).


Cheers,
Marek

--nextPart14768910.u4W9EZHJbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9ajEAAoJEFNVTo/uthzAfSYIAI0ZEMkXTp3g6E59fxN443/G
EySgTv6ru4nfw7IgSZPHyXDJ1af+5rB2UWK4BQJKacDiUDWbNrpnw9DUH7xVs25x
aC4DMFCkPtb3x2YKS0r6LrBjMLtQ1A9bu+S0P1739OcVmGyNS4iaCRiQdA1hsshJ
G2a6psEuofnlQI8MZ/y7Fh/utWBxVADzKQB70njHzwgSr8seXnSE14XdRxzs79QI
VmPicMJZPPJB8hpYrBt6fvxuQABMr3aCbWwrkGUM8nYlg7aPbB7HzZJUFgTFJ+FR
UDoDv5bltck56EKkztSlD5a9Azc0liNmTy8asAtm8RyCOFQaiBVc1FwwkCSGcdU=
=ij9n
-----END PGP SIGNATURE-----

--nextPart14768910.u4W9EZHJbV--

