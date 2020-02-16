Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] net: batman-adv: Use built-in RCU list checking
Date: Sun, 16 Feb 2020 17:17:36 +0100
Message-ID: <14125758.fD4hS3u3Vl@sven-edge>
In-Reply-To: <20200216155243.GB4542@madhuparna-HP-Notebook>
References: <20200216144718.2841-1-madhuparnabhowmik10@gmail.com>
 <1634394.jP7ydfi60B@sven-edge> <20200216155243.GB4542@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2027361.KDeqtIc2Nz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org

--nextPart2027361.KDeqtIc2Nz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 16 February 2020 16:52:44 CET Madhuparna Bhowmik wrote:
[...]
> > I understand this part. I was asking how you've identified them. Did you use 
> > any tool for that? coccinelle, sparse, ...
> 
> Not really, I did it manually by inspecting each occurence.

In that case, I don't understand why you didn't convert the occurrences from 
hlist_for_each_entry_rcu to hlist_for_each_entry [1]. Because a manual
inspection should have noticed that there will always be the lock around
these ones.

KInd regards,
	Sven

[1] https://www.kernel.org/doc/html/v5.6-rc1/RCU/whatisRCU.html#analogy-with-reader-writer-locking
--nextPart2027361.KDeqtIc2Nz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl5JayAACgkQXYcKB8Em
e0arqxAAs2BMDdBX1BL6F26UneTAZ8w5R8MOruf6/NJycj1OzwF9X96BeX0cyj4q
Gnryzgqb3/LXfZPWhF2HSLjuPeVjgiJOoF5S+3n9R00k0Oitqo53gFHirNzLqFYu
bJThufWSFbq3agNcYgrjYe15pyOe46r9Vt/aGyjVsvX+f8J/7PRFCTkznhluzo9C
tmLWbM4tbVJu8JDUD3PY/vR9SxPShYqDOlFz45bqmzHb7Dcr2fLYZC/jlbzd5af+
xTNCsjsk2U9pwR+te1MaIqJ6BDrIljis4HXLCdAMuL5ny1QKrNL1Hj/iS9ycxCnh
1lUNi0HGdRtGcpXbRBIiLkykMJMiIZoep+PkP5CND2WELURBBRVrys8xvwDD3mxJ
xdvhXKAkMv2qaJpbGIQWEf/p+UDbXQXr9Xa1UeUOOHjpC8eNm1FYtKKzTL0W74lE
9KSt086kB2Y9pUMAGQWoIDyb1QKTxQV+jzx9YJEL2AzGO0NEwd+d0UJrxXX+qNbF
BKd+EqdAIR/PfAp2pA4PIxAvieu9Z3jCnXkEURkhS19Rgu1G/0iBq6p8abj+CW8a
7OBNe+13SISLc0rMoX/nbH/Pwxq9MlqRJifFr05S77mKEvdNS8tz0KwN/ZVMSfA+
2dDdXfKzPo3BGnfSOtj7G1wgUMBWOFXVLnFytQEyYXMdlWC47Ks=
=70Ud
-----END PGP SIGNATURE-----

--nextPart2027361.KDeqtIc2Nz--



