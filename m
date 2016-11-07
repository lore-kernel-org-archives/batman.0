Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 07 Nov 2016 09:02:56 +0100
Message-ID: <2186536.4Xmab2I7K4@bentobox>
In-Reply-To: <f9e04473-741d-b0ae-778f-2e920b427147@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge>
 <f9e04473-741d-b0ae-778f-2e920b427147@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1932792.K4U7oif4vd";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jean-Jacques Sarton <jj.sarton@t-online.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1932792.K4U7oif4vd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 7. November 2016 07:45:49 CET Jean-Jacques Sarton wrote:
[...]
> A major difference with my tests is that batman 2016.4 choose, according
> to the output from batctl, the gateway with the TQ 240 instead of the GW
> with TQ 255.
> 
> Translated Interface/Location from batctl gwl
>    ftun-q0/Q1       (255) mesh-vpn/Q1
> *  ftun-q1/Q0       (240) mesh-vpn/Q1
> 
> The normal router choose the GW with the higher TQ, which what the
> GW attached to the fastd tunnel.
> 
> Translated Interface/Location
>    ftun-q1/Q0        (238) mesh-vpn/Q1
> => ftun-q0/Q1        (255) mesh-vpn/Q1
> 
> As stated on a previous mail all system what all node had a direct
> connection to the same GW.

This seems to be a completely different topic now.

Just as hint: read the manpage for `batctl`. Especially the section for
gw_mode.

Kind regards,
	Sven
--nextPart1932792.K4U7oif4vd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYIDUwAAoJEF2HCgfBJntGwBcP/3m4qq2VN7IeuhUpPxPzXARy
dydkSrg2unJRKaapWqjNXh7sAxB2S0KwSzVljfx4L5MF6csejVnXbfERYLTn5YzB
4iYADnplFKrEyKK4d8gXJjma0qw+01eEINHnUT+aL9BXG9yyQJZthVFy2NEaKEne
luEHc/9Es5B8MaeE7s4pp1M0nydYDeYRCW6ktVWJuqQWEsuDcC7IuGNT2Nfik/hk
mdb26XtSDMHPuQkYh54lXADlJmP1FR3xya5rplgLRbj/zJe226bN6qTzzSIoKoaP
1PEu4xG2xgfPg+9UBAk/pDGXLZdQO8jsYr5exNjShACStcHMXz/UUq0/Dru5vHJs
6d2lRxRnDcps1BL/TnLY298rwRciuxQdW6A6cc4SihReh+hgthi+2XqaPEKPIipe
vD6m8UKFY4+ENaTJH2+ef/iVyfodUGiI+X3fTQ64/oJfoeUDxPVkwZGMLEx7O6fu
jZ3tSpUt3UT/JCCjiJK/1VE1A4faazJaLRy4fLNHCu5/P/ECAXurK8uy3IjG4vHM
IKFX6z5Pneo2DSJu99B8eVpNQppjQNDttGLHMemRdTAVyDeebUoEgEUCfVALRCUV
GxsJkxP7lK4DqiDZGOmsGPnYO8nxtf1U3cQ2uM2mdy778v3g1A3JG+ufzrR5Im7Y
1tuRKKecD76jJR27jQpB
=/LbM
-----END PGP SIGNATURE-----

--nextPart1932792.K4U7oif4vd--

