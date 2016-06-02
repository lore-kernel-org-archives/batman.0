Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 02 Jun 2016 08:39:33 +0800
Message-ID: <1486656.g3lhHQC2Ly@voltaire>
In-Reply-To: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
References: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3852049.LoqjZHiEBr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Non-batman Clients
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

--nextPart3852049.LoqjZHiEBr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 27, 2016 22:25:46 Jonathan Haws wrote:
> I've given IP addresses to the bridge adapters on the 192.168.1.0/24 
> subnet.  The clients I've given IP addresses on that same subnet 
> (192.168.1.121 and 192.168.1.142).  When I tried pinging, I don't get 
> anything back.  Sniffing packets in tcpdump shows that it is never 
> getting anything back, though I did get an ARP back once with the 
> correct MAC address, but still couldn't ping.  Never got an ARP back 
> again...
> 
> I can ping from each client to the IP address of the bridge they are 
> connecting to, but cannot ping anything else on the network.

Can you ping from the nodes running batman-adv to other nodes running batman-
adv ? In other words: Is your mesh working ?

Can you provide specifics about what you saw when running tcpdump ? What does 
'never getting anything back' mean ? The ping goes one way without any pong 
showing up ? Have you checked on the ping destination (via tcpdump) that the 
ping ever made it there ?


Cheers,
Marek

--nextPart3852049.LoqjZHiEBr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXT4BFAAoJEFNVTo/uthzAtzsH/j3pre8KmLSJhEVMPMTJGXy6
6YFbLKPzroFEZ0e6Ou53UlX5xmdukpk1kUrd1LZxMl71yQDbYVFUoV8xWvXtg5zc
fTAjp/tKF9PmV4GL6KxMWmqxSITyaibMvmmzBYqZCB4WikY9NHolLZ85pExoOJB2
MtZWsis2t/ATcyYw65RmsTgd/do8i95nlyVy1B625psM0E2NECThZK04rJxHtjQx
0MZCBt6JY50vFrvkq9DK9hMk8lOTNMAu1LE7eNrqkIEGYUYG1wULiho/dmKpKy39
XUAG2hxGiCBC8qIK3KsJzpC9J2afyElpdqNP9O33vgHHTJVO3L2uANEf0SKDG5c=
=vIPw
-----END PGP SIGNATURE-----

--nextPart3852049.LoqjZHiEBr--

