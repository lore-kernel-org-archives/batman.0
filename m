Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 12:02:52 +0100
Message-ID: <42883547.GmOm9E46Iz@sven-edge>
In-Reply-To: <1456867148-31883-4-git-send-email-andrew@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2510033.6O6RCNlSoV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
	interfaces in a different netns
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart2510033.6O6RCNlSoV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 01 March 2016 22:19:07 Andrew Lunn wrote:
> batman-adv tries to prevent the user from placing a batX soft
> interface into another batman mesh as a hard interface. It does this
> by walking up the devices list of parents and ensures they are all
> none batX interfaces. iflink can point to an interface in a different
> namespace, so also retrieve the parents name space when finding the
> parent and use it when doing the comparison.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@untable.cc>
> ---
[...]
>  	return (dev1_parent_iflink == dev2->ifindex) &&
> -	       (dev2_parent_iflink == dev1->ifindex);
> +		(dev2_parent_iflink == dev1->ifindex) &&
> +		net_eq(dev1_parent_net, net2) &&
> +		net_eq(dev2_parent_net, net1);
>  }

Just spotted this:

"(dev2_parent_iflink == dev1->ifindex) &&" and all following lines are not
correctly aligned anymore (7 spaces vs 1 tab).


[...]
> +	const struct net *dev1_parent_net = net1;
> +	const struct net *dev2_parent_net = net2;
> +
> +	if (dev1->rtnl_link_ops && dev1->rtnl_link_ops->get_link_net)
> +		dev1_parent_net = dev1->rtnl_link_ops->get_link_net(dev1);
> +	if (dev2->rtnl_link_ops && dev2->rtnl_link_ops->get_link_net)
> +		dev2_parent_net = dev2->rtnl_link_ops->get_link_net(dev2);
[...]
> +       struct net *parent_net = net;
[...]
> +	if (net_dev->rtnl_link_ops && net_dev->rtnl_link_ops->get_link_net)
> +		parent_net = net_dev->rtnl_link_ops->get_link_net(net_dev);
> +

My proposal is there to move this in an extra function [1] so adding compat
code is easier [2].


Already said this in an earlier mail but just for completeness:

Include missing in net/batman-adv/hard-interface.c

    #include <net/rtnetlink.h>

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/blob/aef6842ec0facda9ec52736f8a6ce8ca4110e91a:/net/batman-adv/hard-interface.c#l87
[2] https://git.open-mesh.org/batman-adv.git/blob/fb7b5eb8c81969dc8bea356d0a3f0b5e72d2da49:/compat-patches/0001-get_link_net.patch
--nextPart2510033.6O6RCNlSoV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5UjcAAoJEF2HCgfBJntGEZYP/jSo0IlXY95+H6Oc36uUjVSE
M+DqfIDirVkI5fdrbNNzF0l9x9yYyfd05WnX/8EnFU69bKw/oJ920ne3TEvK1N2l
lVR+MAt6OC31QcobnhchvfobgXvgz/NSLBEvAMKayz9R/KUhbWQZDHAd+bdw3ZAa
nikCBijXCTvSWFvJolwlssc/9JPZimHXjJ5mDVufrw5h8Ia6PX4YcFu81oDd5k33
wIjA1ebkfm8dT4+nw3pPu0wkyfXasrsVdVHEkchw9K1TvfK9Yb6puHjtucTS4YMF
77UYTeJv9IirtyDlZdGG+jAdWwH5BWrXI1/LsQAZP9CiBp3FzgVATn3tuxgIu8IV
K8JY3Yc+3SEqkzaD+q6fVRhIRDpsRv2taVcy4hE1KLMbBnbWvBpKN7khEuxeKT8Z
PTbl/ogUk1Dh4ce/2cf97HYqh28Za4oMQnOHjIAUIQIxMhZmIAeb0oPmK2/qyze8
jHEO/++vr22lsQwfiLEO8H2lWVkGb6SA9qIipp//p+igPWvvZyBR4oIxe/mjLxG9
f+cPgx5xWCLtQztVZXRnsWRfUmNRzXnsEWlU0Itk5aaIvI8mlzKiPN/ygqYJwqeE
hZfJGQEuhSxmN+3w/dFktNZERn9HzO5/sATUX9UZjfDmenv7OV1l4a4yXbyA1z6B
R5+4E2by5V6El15C7dn0
=knM5
-----END PGP SIGNATURE-----

--nextPart2510033.6O6RCNlSoV--

