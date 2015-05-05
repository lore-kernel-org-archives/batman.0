Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 05 May 2015 12:21 +0200
Message-ID: <2479424.tFhBkT1Z6y@prime>
In-Reply-To: <1427309467-31768-1-git-send-email-sven@narfation.org>
References: <1427309467-31768-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1972072.JD4iiX49l6";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Make sure only link-local EUI64
	is used as source
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


--nextPart1972072.JD4iiX49l6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 25 March 2015 19:51:07 Sven Eckelmann wrote:
> The linux kernel automatically chooses the source address. This can make
> problems when the metric prefers an address which is not the link-local
> EUI64 address. For example an user can add an additional address which also
> can be used for link-local communication but has a higher value in the
> metric. This can cause alfred to send UDP link-local packets with an
> address which cannot be decoded by the receiver to get the MAC address of
> the device. The communication with this device would then fail.
> 
> It is possible to define the source address when we directly bind to it.
> This has the problem that this address cannot receive packets with a
> multicast address as destination. The workaround is to create two sockets
> for one netsock structure. One is the socket which can send all data and
> receives unicast packets. The second one is receiving the multicast traffic
> like the announcements from master alfred server processes.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 986ca57, added Moritz Warnings "Tested-by" as per ticket 
#208 [1]. 

Thanks a lot!
    Simon


[1] http://www.open-mesh.org/issues/208
--nextPart1972072.JD4iiX49l6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlVImY8ACgkQrzg/fFk7axbRZQCg256ayHepC7HNwrD+bfZ2ZEFp
qc8AoLhXCJ4mw6/G3hVF5XiozpB7lBiV
=6D/+
-----END PGP SIGNATURE-----

--nextPart1972072.JD4iiX49l6--

