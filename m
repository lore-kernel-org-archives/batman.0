Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 15 Oct 2018 17:30:53 +0200
Message-ID: <8325261.HzsDqFlXlC@bentobox>
In-Reply-To: <B99A1AB9A294834C8DF94185A5E9D1810163770B9A@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D1810163770B9A@NRTV96002.america.zf-world.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1791178.D82bIgL9Rs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Blacklisting specific nodes for traffic routing
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

--nextPart1791178.D82bIgL9Rs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 15. Oktober 2018 14:20:32 CEST Jake.Harris@zf.com wrote:
> I'm working with a group of about 50 nodes, 40 of which are physically stationary and 10 are mobile. The area is about three football fields with all the nodes evenly distributed while the 10 move around throughout the whole area (specifically there is one on each machine in the factory and one on each fork truck) with all of the fork truck nodes powered off the network is rock solid, but when they are powered up the network becomes flaky with different machine nodes loosing connection.
> 
> My assumption is the machines notice a fork truck nearby and route their traffic through it as would make sense from their algorithm, but when the hilo goes out of range they seem to not notice and packets sent to the out of range nodes are lost.
> 
> I looked all over the documentation and haven't found a way to specify which nodes to not allow routes to be built through.
[...]
> Is there an official way of doing either of these?

If you want to make it unlikely that routes are planned through some nodes 
then try to increase the hop_penalty on these devices [1].

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Tweaking#hop-penalty
--nextPart1791178.D82bIgL9Rs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvEsq0ACgkQXYcKB8Em
e0ZP9Q/5ATPl95+bMWrBk4FcTUAT3cPYuSdaqENeLJbY+vmag8GfCKJkIKdEIzWS
z9ZhO8MkCqlcr2KfBpZ9fBueIqUKacaXv7BrWOuKCotXDyb+LPcfIbuAWyF+mbEW
ZkFVATs7k5coMKMyN8hv9o4s0701ZcNLtoT+daPTR4Bbm9Ig8MtYZwYM+CPIiig9
AcCIhFLr/viIMyRwBb4ulK5x/OnesruWwE6REfRx86ijVDUD4U+bufcomSZFIVNZ
U3EdHx0EIneyXZZ7ynf7pa3r8aM7JkwFvNX66IAL4D3Zxi5rF9Du2aSWBGb1KnaR
J+c13dQnF7ustY2rnMz1wU82Qoy5et6wt1Hth9Ny9HsBzm6jzR5RCoSaIJ6blMqW
toNPjJUNvFCPytonwKSmt7hEUB2XY8LR+yz/5cuwDhQP7ffdy3Fn9zCSLdwncM3Z
s3DdjsK8AmMlO55iZsTcz/aoCMPuKPDX5IuYEpiu+5uBLlNUodoQH+XQZqI0VXsL
pnK0CSYl1wziTKL1MmATQDRSZ66EQJ2V8tL61RtB/yzFEMejVEMPiagXxCOZkFhN
10Q/VcZhZKucbZXpIJZ/ztxEttoWax2WqXwAIMAPdCE2UbeqvJuOgtlJLokuz7n4
UtI3GCuZq9uyGIPUKrbd+k47S5Q35VhwnXvXkD5I0eBiWkFi5nQ=
=WaC1
-----END PGP SIGNATURE-----

--nextPart1791178.D82bIgL9Rs--

