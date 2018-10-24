Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 24 Oct 2018 20:57:40 +0200
Message-ID: <7302424.rEnkhXZBE4@sven-edge>
In-Reply-To: <20181024183511.19902-1-jhaws@sdl.usu.edu>
References: <20181024183511.19902-1-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1793086.CGsJKq7lG1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH alfred] Request MAC resolution for IPv4
 address not in ARP cache
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>, guohuizou2000@sina.com

--nextPart1793086.CGsJKq7lG1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Please start the subject with "alfred: " when it is a patch for alfred.

On Mittwoch, 24. Oktober 2018 20:35:11 CEST Jonathan Haws wrote:
> When using IPv4, if the remote server is not yet in the ARP cache, the
> MAC resolution will fail and data appear to not be shared via alfred.
> Add a routine (modified from batctl sources) to request MAC resolution
> by simply sending a datagram to the discard port (UDP/9). This adds the
> remote MAC to the ARP cache, resulting in successful MAC resolution.
> 
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>

Please add the info which commit was fixed by this change right before 
the Signed-off-by:

Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")

[...]
> index eecfdfd..5771483 100644
> --- a/alfred.h
> +++ b/alfred.h
> @@ -213,3 +213,4 @@ uint16_t get_random_id(void);
>  bool is_valid_ether_addr(uint8_t *addr);
>  int ipv4_arp_request(struct interface *interface, const alfred_addr *addr,
>  		     struct ether_addr *mac);
> +void ipv4_request_mac_resolve(const alfred_addr *addr);

This doesn't make sense. The function is in util.c and only called in util.c. 
So it should be static and not in this header at all.

Kind regards,
	Sven


--nextPart1793086.CGsJKq7lG1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvQwKQACgkQXYcKB8Em
e0bcGQ//TMLHa4Nkp4t0wuSV5eE5qpKmGwwcYclb+FtEaWWJSKlPPkAhI9ZgfmD2
ZMzVVsCMXSdV+uTuPlDZY3cUFyMFHkDfkNXyAtW5tTketVMrzyiAup5zM3dh9d8u
g0TVJWp53NftbPXvyzLo/uMNtf8BTSMENx1xbJMi/7wLwGe97DCzfFybqVYkelx8
90S9JjI+BP6/Lv5ae0fnINITWj7rjBgLTF4jIGF4Cj+2tNXiko8LGz8fbWqqIsxZ
dPI1TzfbSAs6gO0S2YLE67u+9s2HyZutnflQ8cUCHL4N88PAHNDRG0qZjaqcwuUn
xkydqtIIriLbwA0xl6ZxAZataSLW8Z/SYq1dljU8ChhyXxCW2OHYJnsawQg5E5xm
DEaW9M0v7n2v7Ivb/c1xsBXWYiqmeIFce3hE3Ris/9DS+r+by/jusHrmPDleRoPY
ED2c0MQPyvEnpHKOnd1cimtC522jYz6bAFWJddzgw38PNXjHuNHTQCnai/aKBqXL
b6A0tigZhO5pau+45r8GAIzW/vL1GnlUyB35RXu0PfLhiAL0VDUd+wE7fTE6nIri
9qk65YxedfJ6H+dsyv2iOZ4XYM5D6txbNKNx5wMYh8SQG6qAyIBHHfmC+jEwgfA5
wLNPHqTxTSMPG0T7pDzkaivyWY+RA0A+jwnTHGrptALLrbWv5tA=
=YG7W
-----END PGP SIGNATURE-----

--nextPart1793086.CGsJKq7lG1--



