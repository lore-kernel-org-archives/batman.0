Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 12 Jun 2017 14:14:15 +0800
Message-ID: <7478702.aBJcA2Bq31@lafayette>
In-Reply-To: <20170609150651.27627-2-sven@narfation.org>
References: <20170609150651.27627-1-sven@narfation.org>
 <20170609150651.27627-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1937029.zInu6NcmiO";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 2/2] batman-adv: Accept only filled
 wifi station info
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

--nextPart1937029.zInu6NcmiO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 9, 2017 5:06:51 PM HKT Sven Eckelmann wrote:
> The wifi driver can decide to not provide parts of the station info. For
> example, the expected throughput of the station can be omitted when the
> used rate control doesn't provide this kind of information.
> 
> The B.A.T.M.A.N. V implementation must therefore check the filled bitfield
> before it tries to access the expected_throughput of the returned
> station_info.

We tested the patchset on the battlemesh testbed and can confirm that it 
reduces the packet loss rate over lossy links to 1-2% which previously had 
been at 20-30%.

Reviewed-by: Marek Lindner <mareklindner@neomailbox.ch>


Cheers,
Marek


--nextPart1937029.zInu6NcmiO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlk+MTcACgkQU1VOj+62
HMB7vwf+KQYVrYdRZMytinDRepjJh6nBjI5Bel6R0gRqdKkS0LqBkiF/3aa+axVW
PAECgp6D7rVGQoyRRPPV+cD4Hd+gJz00Hvx/h0G4ahhDfcri0Bbz5gOicBeGKc/5
GLC0rtHSMOPpJb6E8AsRWu9yHixLu0kWjCnodVvsj7rFhKMo9b4FqAtHZbFOcr1t
pt028mtkKlvS0N04G7Vj/itlL8yKXsIHen97wRG7z46KxmM78p2/SJI0jkjSIuxZ
IeFWDZZRHuRbuhV4j+5Kbbay6tCWfPmm9Rbh8DuZ7QntArMuPL5N62ouNWOalTvr
4ABuWBXhdbXChhhPIYP+pkiCcJ3JgQ==
=N+7O
-----END PGP SIGNATURE-----

--nextPart1937029.zInu6NcmiO--

