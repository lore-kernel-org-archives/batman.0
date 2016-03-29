Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 29 Mar 2016 20:55:41 +0200
Message-ID: <4605306.DPF6tJRphQ@sven-edge>
In-Reply-To: <20160329175957.GA6539@r2d2.s.lihas.de>
References: <56F5AF2F.6060904@t-online.de> <3883397.RfpiZdWGix@bentobox>
 <20160329175957.GA6539@r2d2.s.lihas.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1973903.NK1f101OOU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
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

--nextPart1973903.NK1f101OOU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 29 March 2016 19:59:57 Adrian Reyer wrote:
[...]
> > It would also be interesting if it should be a simple flag or some if
> > exporting the num_bcasts via $something would be sufficient. Or if the
> > num_bcasts should be split into num_bcasts_otherif and
> > num_bcasts_sameif and then exported.
> 
> It is two different things, the num_bcasts in my understanding is about
> how many times the originator sends out its packets to assume everyone
> has received it.
> The flag we talk about is about if anyone receiving that packet on an
> interface has to send it out on that very interface at all, e.g. it is
> about everyone reachable via that interface sees the same neighbours
> (e.g. switch) or a different group (e.g. wlan adhoc)

Thats why I said that it would have to be split into *sameif and *otherif.

And btw. it is not about the originator. It is handled in 
batadv_send_outstanding_bcast_packet at the same place where you want to have 
the no_rebroadcast check. no_rebroadcast in the patch we are talking [1,2] 
about is currently just ignoring the num_bcasts of a hard-interface for some 
situations (when forw_packet->skb->dev == hard_iface->net_dev).

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/3434/
[2] https://patchwork.open-mesh.org/patch/4384/

--nextPart1973903.NK1f101OOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW+s+tAAoJEF2HCgfBJntGUE0P/AlEmNgV8CoPNqoWlQiDMX06
wkv47vKHTeqOj/GO5tvB3AJ3XdB116pofwUjKei8U0G6XvDgPpi8e7IRht7LBxyO
bDPmJGoTcaMGCIPSFDKbIWeeKBFXxtO09dUhh+QD26sZUtJjEY774luiuuqzh7eS
J0apRJ8U9At5TNbY6uPSiMLYjGL+77jV7v+E08IvxD2bojBADkIrZqyRfdC9xwpA
3oN099QltL4UlZ1UrYrpKeoYhsbZ7puKcKhtqBHUf/F3QfedXK72Zm55N9jFJgzW
xsGboYKC+IA6zJEXPNc7dLMoQ4Wk6rTHtE9lUxtDUOSm3YFcuLqZNsgsdJX3L/qW
NKoZIwtCD+B30XizYpi6SqulsgJivhwZExTilYUUkR0wHLoyvIxSru5SsKONTK+a
f6GSZOQ0yz6K7abpP8XAQJoX3qipM+45YtmIsMu3ZoOcKiB3f4YL6+bmD9tGTh9P
DNYkpiu30r6zjMcc7O1yEmPYOZ74H9KZxN9ZoY3EgiLZoKGOPU4nHgHDYX8DiqcX
d8fqHfRjYSyz6Gk4KD4AihT/DmVR7eV0JoWLK5G+zoxk3JRn2ePbaZ9ehEJgN/mj
rquo3tclIreHyfflaojUXja9OOPETLFenuRmd6lXWf3WcBB1ncBVwMyj6Fpt4N85
ylOv2wdmQtVMFG5I3nnr
=wM90
-----END PGP SIGNATURE-----

--nextPart1973903.NK1f101OOU--

