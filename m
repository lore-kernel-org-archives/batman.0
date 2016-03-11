Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Mar 2016 16:27:11 +0100
Message-ID: <1940763.5sKtNKt5OI@prime>
In-Reply-To: <56C44D11.3000706@heidler.eu>
References: <1455666670-32409-1-git-send-email-dominik@heidler.eu>
 <11933942.EqGnTx1S2H@bentobox> <56C44D11.3000706@heidler.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart40494264.GvJIMH3cLj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Allow setting the source mac via
	unix sock
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

--nextPart40494264.GvJIMH3cLj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="windows-1252"

On Wednesday 17 February 2016 11:36:01 Dominik Heidler wrote:
> Am 17.02.2016 um 09:39 schrieb Sven Eckelmann:
> > Your patch also doesn't explain why this feature may be required.
> 
> I'm running an alfred master server with this patch, so that I can run a
> script that will inject data of legacy clients (that don't have an alfred
> slave, but need to be crawled).

Sorry for the late reply. In generally I think this change is acceptable, 
however I'd like to request the following changes and to resend your patch: 

 * Please write a proper commit message in the patch, explaining your scenario 
and why you need it
 * Write a comment above the change you made to explain that clients should 
set the mac to 00:00:00:00:00:00 by default, unless they want alfred to use 
its mac for them.

Thank you!
     Simon
--nextPart40494264.GvJIMH3cLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4uPPAAoJEKEr45hCkp6hS7wP/18JeT9az/Aqw1zz+at34GZD
NeuEtibXfzhZsz95EFhcNa2oUmYlJundzNruXB+0miTOBteWZXEHqm+ktZ7/9ULo
edYF6LBvhjvgOjAN99Ea/SA6kxFafm99bqvhbPUafJw1JLFKf/rF2JmZSZWlbj9z
KuigwohMarVE5Y5OCuizAZK/pNOffs7zsIsac6iZtMIWKh4+T4UIt3CB3d/t1j0y
rCByoOfBx91/rh9d6qK/GCyuytLM0IU+T5xBiTRaq8WggFyu1PmGgy93xvMH6NXi
7PuOAVVaTV5CmyMjNDHHuSqaDmOwjSi/mN3DmiGGLOnyJBNt9Xm7aonlssUWAeKg
8IwBznX3BbbG+Omkd3KDYwRYyt77lK0gfjjsSteX4V2DGY6aFUeSsaF62MPUUJhs
Ej3/92dgUX1MEqX2yljwqTZz5Pqf+qRebBCCU92r/Py7s+QDD+55EdhaJm/tXXsy
0eBV8cK+dcCzu4P7g9fqUDgBORASuPCzeVyRinHT4TIHpPwQoJiy/qJc6J01CMlx
+sfek2ZRjoSU9ZaMBaGJrEXiU50QTujQavauFUWLtiKdMw813k/2Wz0CnXvJEYmq
oqfZfHGUfvUj2j4hd1PPnstGvAtCy+ZR5YmVXJA7EoEMU2kXTY9zAO6TSpJ0ag5i
jPUx2XZu/faqpxSpzo1F
=pB/g
-----END PGP SIGNATURE-----

--nextPart40494264.GvJIMH3cLj--

