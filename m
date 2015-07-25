Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 25 Jul 2015 18:15:54 +0200
Message-ID: <1458978.v9LkvYjrHL@prime>
In-Reply-To: <55B10C8B.2030902@autistici.org>
References: <55AFAFD9.808@autistici.org> <7098754.rficnZ0CR1@prime>
 <55B10C8B.2030902@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart89873138.lXHUpe5Ud3";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] encapsulated ethernet frame format
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


--nextPart89873138.lXHUpe5Ud3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi Berat,

please see below.
On Thursday 23 July 2015 17:47:23 Berat wrote:
> Thanks a lot for the answer. (Sorry, i didn't realized that i was
> replying to you instead of mailing list.) There is an ultimate point
> that i would like to understand. If you can help me it would be great.
> 
> So, to see if i've got it right, i made this little simulation of the
> traffic:
> 
> 
> 
> C1 	    C3	 	 C4
>  \ 	     |		/
>   N1 - N2 - N3 - N4 - N5
>  / 			\
> C2 			C5
> 
> 
> 
> 
> Client C1 communicates with client C5, and i'm intercepting packets that
> are passing through node N3 and i see a unicast packet at the moment;
> 
> the first ethernet II section has:
> source mac -> mac of N2
> dest. mac -> mac of N3
> ----------------------------
> batman section has:
> dest. mac -> mac of N5
> //here i see source mac only for batadv_unicast_4addr packets,
> //which are ARP requests. for all other packet types, including
> //dns request which is a unicast packet, there is only destination
> //(or originator if a broadcast packet)

Right, only the 4addr actually shows the source.

> ----------------------------
> the second ethernet II section has:
> source mac -> mac of C1
> dest. mac -> mac of C5
> 
> 
> So if i got it right, i would like to deduce, if a computer that i see
> by the packet that i intercept is local(connected to the antenna that
> i'm intercepting) or packet is just switched/forwarded by this antenna.
> But without that source mac information in batman section, it doesn't
> seem possible to me. Can i deduce it without that information?

You could try to look at the TTL in the batman-adv header - its decremented on 
each hop, so you could find out the first one. Another way would be to check the 
second ethernet II header and see if the source in the local table - although 
there are some corner cases where this may be incorrect (e.g. when the client 
roams).

Cheers,
     Simon
--nextPart89873138.lXHUpe5Ud3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlWztj4ACgkQrzg/fFk7axbhOwCg6/LvV6r4lNGvMY9J+8kgiQUJ
Yh4AnRtoZy0GhMFqaPhiRh+Bm3OHO/42
=qZEt
-----END PGP SIGNATURE-----

--nextPart89873138.lXHUpe5Ud3--

