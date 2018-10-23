Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 23 Oct 2018 16:30:08 +0200
Message-ID: <1899616.l5F9IoS4bi@prime>
In-Reply-To: <CAPzaX0gNh3g6wUmZJLuJnixYNVEkYjdiL3E=06acrSDw2amtvw@mail.gmail.com>
References: <CAPzaX0gNh3g6wUmZJLuJnixYNVEkYjdiL3E=06acrSDw2amtvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1639569.Lqig7OQoYz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Additional Assistance
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
Cc: Corey Combs <combsca90@gmail.com>

--nextPart1639569.Lqig7OQoYz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Corey,

On Tuesday, October 23, 2018 10:22:29 AM CEST Corey Combs wrote:
> All, thank you for the replies yesterday.  Would you be able to offer
> some more insight into updating the 2 packages?  I have had some
> successes, but not all the beagle bones have
> recognized the new version of batman-adv when I run batctl -v.
> 
> The general method I've been using is the script here
> https://gist.github.com/marvin/186a609d1e88f7426747 with version 2016.4.
> The starting version on the Beagle Bones is batctl debian-2012.1.0-1 >

Could you get even higher than 2016.4, like 2018.x? Or is your kernel too old?

> [batman-adv 2012.5.0] as mentioned previously.
> After running this script and doing a
> $ modprobe batman-adv
> followed by
> $ batctl -v
> I get $ batctl 2016.4 [batman-adv 2012.5.0].

That looks like you still have the old kernel module loaded, or the new one 
not installed properly.

> 
> I have also attempted to uninstall batctl and batman-adv with
> $ apt-get --purge remove batctl
>  and
> $ apt-get --purge remove batman-adv
> and reinstall using the script, but that hasn't worked across all devices.

Not sure if that is right, as batman-adv (at least nowadays) comes as part of 
the Linux kernel, and not as a Debian package. You can install/deinstall 
batctl using apt-get though.


> 
> The laptop I have is running Debian 9.5 with batctl debian-2016.5-1
> [batman-adv 2016.4] and the Beagles are running Debian 7.9.  I would
> like to avoid reimaging the Beagles at this point in time.
> Please pardon my lack of knowledge on the topic, as I'm still
> relatively new to Linux and have been learning a great deal in the
> past few months.
> I greatly appreciate your help on the topic.

You can check the selected kernel module using modinfo. Like that:

# modinfo batman-adv
filename:       /lib/modules/4.17.0-0.bpo.3-amd64/kernel/net/batman-adv/
batman-adv.ko
alias:          net-pf-16-proto-16-family-batadv
alias:          rtnl-link-batadv
version:        2018.1
description:    B.A.T.M.A.N. advanced
author:         Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich 
<sw@simonwunderlich.de>
license:        GPL
srcversion:     A1221167C25642EB4E48AE0
depends:        libcrc32c,bridge,crc16
retpoline:      Y
intree:         Y
name:           batman_adv
vermagic:       4.17.0-0.bpo.3-amd64 SMP mod_unload modversions 

Here you can also see the position where the kernel module is loaded from. 
This should show 2016.4 (or whatever version you wanted to install), if it 
doesn't, something went wrong in your installation.

Cheers,
      Simon
--nextPart1639569.Lqig7OQoYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvPMHAACgkQoSvjmEKS
nqEVyg/9FsMo23KNLP2pIQQqmJdh0ChwwD3EZU6eXODkkw1bvC97ZwRBUOTLUfvm
t91Mv+WJzxM1qJj36bcXqq0s16VEFWf4ESVGah9Th60IxM40EOSqGNJpei2Blz+W
bdENfT/iR1FEF9FdF6DEpluJBEsjXLI5HJU4wKW1nDcHz1ACxEQ/JdQ4HULtb+RF
KiXhO6Jk8AzcKUl4DEaKTyYrKC0mmwoElT+3oytVNdFYChvROqQBXAjRKBsxjj3k
Kdao4jzCuttkWREF7xXtIgNlMdg7DzuG6leTkh8ZkCJDVCNrBEP+fKZID9osVYvg
ZvHaWDqbPBV8bUzlCEBLPkG4BBQBf0sGJH/kTCPDJzUCXQOHQYt5SXZIfFlS+OQV
7WQxOHlGpl5nNuOul1tr1A8y8ulrzQXxDqoqI6tQjj0ujKFaEbTN30X5gtkesp4J
yTDKnA5bTfRIfwJAigWyM/IJKYu6NVTH7Dy4mWBw4rBILTbk4drLBVTxZ6sjOS3Y
bdy271D9RFyhnnjEYmo4swyU4iXDIyRd3Dhwf+7mKNCiRQlO78ijkC01Qb6x8pbu
WAc2vTY36NW1uzvV9HwLlSL/SHBCfBAFWaVY312m7skrIqXgzNlyDQrYlzpmhJzz
CinE0YAT1ATlrw1JRgXg7CxWvWd8vN/ViG6m4KFNwtdWUYzubls=
=vVu1
-----END PGP SIGNATURE-----

--nextPart1639569.Lqig7OQoYz--

