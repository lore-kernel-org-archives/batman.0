Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 19 Jan 2017 12:51:02 +0100
Message-ID: <1572044.scLSiuJDnZ@bentobox>
In-Reply-To: <1484804915-14791-1-git-send-email-jhaws@sdl.usu.edu>
References: <1484804915-14791-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1619308.7h6LRSyfDI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] [alfred] IPv4 multicast distribution
	support.
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart1619308.7h6LRSyfDI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Just had a quick look at the ARP cache code while going to lunch (rest was not 
checked):

> +int ipv4_to_mac(struct interface *interface,
> +		const alfred_addr *addr, struct ether_addr *mac)
> +{
> +	ipv4_arp_request(interface, addr, mac);
>  
>  	if (!is_valid_ether_addr(mac->ether_addr_octet))
>  		return -EINVAL;
[...]
> +
> +int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
> +		     struct ether_addr *mac)
> +{
> +	struct arpreq arpreq;
> +	struct sockaddr_in *sin;
> +
> +	memset(&arpreq, 0, sizeof(arpreq));
> +
> +	sin = (struct sockaddr_in *)&arpreq.arp_pa;
> +	sin->sin_family = AF_INET;
> +	sin->sin_addr.s_addr = addr->ipv4.s_addr;
> +
> +	strcpy(arpreq.arp_dev, interface->interface);
> +	if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
> +		return -1;
> +
> +	if (arpreq.arp_flags & ATF_COM) {
> +		memcpy(mac, arpreq.arp_ha.sa_data, sizeof(*mac));
> +	} else {
> +		perror("arp: incomplete");
> +		return -1;
> +	}
> +
> +	return 0;
> +}


This looks like you are not always initializing/setting the data for mac. And 
you are not checking the return value of ipv4_to_mac. So it is possible that 
your are accessing "random"/"uninitialized" data in is_valid_ether_addr. It 
can happen that your code accept bogus mac addresses (which are valid mac 
addresses but are not actually the mac address of the remote system) - which 
sounds wrong to me.

Kind regards,
	Sven


--nextPart1619308.7h6LRSyfDI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliAqCYACgkQXYcKB8Em
e0YEYhAA1uQ3ov/Sgt7ZPyLOeB6gsnKh11bm972PGFDSODxZOdderCaaU2HGPH2U
+jmEM3G5n4brm4Yzy8AFcCO+7zUldMGosf1OPmkui00UEx7nHpDUmzIG4DtRgpdV
9rWcG3an+iXdxijm/hGR0V9cv/8PKDRMHefUsK7kPRiRMtFDKULgbSqQHskCqP1m
MsaLxwIHW4SK9Hi/8KDO10JamkB8yTKxSUg1Ow48GKZQX5ZwHlclAtWBjausKw+M
Wi76cRUWDCHBrINOFfXbu1Bg+5ewFSn6oKZE1xBURpENkD+LLz+0WrEiow7vb7Ej
JgifVKgsfPzqiOQ6SNPTen04lXvCoaVzQlusq7qLjw/giWuOU1Qt9s6PVbJTkTqw
BGL5dPSdBx6Y6X1dfyGWkMxiiaHQglOUx350IWVu1RLa1nSJLRY/DnYU4M1ekzvd
iFiwzreV9L+yQWc6oNsbIW+noSt0rPQiC7ds/8Dwf66kVmny6h/79iCzBmkrWGc2
E7+UwCALHV6TlWD04DoeX6fF8U82lc2LfyHuYfU41Z/yMVAjiNYDE0m6JMHDeeQ4
d+SqloOLACt4FkSQ3NzynnlbWL/EmsavnUJPGLNL6NNgp8ifiXCEVSFtTAPekKBp
0NR6Z1bsPAFvvfHgZDxAPUcQIdmnF1nAYO9bYe0Lr7pKsLd3qVo=
=dX+G
-----END PGP SIGNATURE-----

--nextPart1619308.7h6LRSyfDI--

