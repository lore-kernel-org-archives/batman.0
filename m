Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 31 Aug 2018 20:16:31 +0800
Message-ID: <2087861.tpEfN19RDO@rousseau>
In-Reply-To: <3991773.ZLWj8GO7DM@bentobox>
References: <2791173.mX5NbDZpiX@sven-edge>
 <733b64f0.dcd9.1658f661fb2.Coremail.heishuihe2008@163.com>
 <3991773.ZLWj8GO7DM@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2737007.V2qbDAUteA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
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
Cc: Sven Eckelmann <sven@narfation.org>, Ligang LIU <heishuihe2008@163.com>, a@unstable.cc

--nextPart2737007.V2qbDAUteA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 31 August 2018 18:30:00 HKT Sven Eckelmann wrote:
> > I noticed 2 macro definitons.
> > #define BATADV_ELP_PROBES_PER_NODE 2
> > #define BATADV_ELP_MIN_PROBE_SIZE 200 /* bytes */
> > I wonder why it sends 2 prob ELP packets to each neighbour.
> > Can I change the value of BATADV_ELP_PROBES_PER_NODE from 2 to 1?
> > And can I decrease ELP prob packet size from 200 to 100, in order to
> > decrase the ELP airtime?
> @Antonio, @Marek: Maybe you can explain it better than me.
> 
> I would guess that Antonio wanted to make sure that the rate control
> algorithm of the driver probes enough and thus provides a more realistic
> expected throughput.

Feel free to change these values to test if this has any impact. As far as I 
am aware, these number are the result of an educated guess based on how 
minstrel works. Antonio can shed more light on this.


> And you can just use elp_interval [2] to reduce the number of times
> broadcast and unicast ELP frames are transmitted. 

I don't think unicast ELP were supposed to be affected by changing the 
elp_interval. Smells like a bug to me. Antonio ?

Cheers,
Marek



--nextPart2737007.V2qbDAUteA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluJMZ8ACgkQU1VOj+62
HMDYEggAs1t1QVQVeAG6S3JaSy9ns0OAyAFimEzIA7k6wdwx0vqkrpjN3MqSP5MF
RIxUYM5g+51wWE7KOJR3mvRFTSkrf33M+TRP0/27I6loNcmsdNbfphuZUTCuGEMx
WHfblhgJ7HY4fmsnsk7ZyfX6QV6VtybAAyp8I90Bflh6W1AYsriAJT6qEOrLHpLd
S2+oZ3Faxd3adEh4tOJ1z3DGH5tHHlqyfyB+cJWr5OopT0Qxp8Cvnhz21iPXYIDp
aRRTi6ugtvsijSKMYrCBvimbdIHZ1dBObod2ynFEZEhnkwGBv1MOwPbtQT/HKAt/
lbN4Twot54nlBFkF2NrWBK+XOmFQsg==
=8RG1
-----END PGP SIGNATURE-----

--nextPart2737007.V2qbDAUteA--



