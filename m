Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Date: Fri, 11 Sep 2020 14:48:19 +0200
Message-ID: <38142483.hY40ij8To5@ripper>
In-Reply-To: <CADJ1cUSum9bHHBZB3gKdXukoqqDxk_f2nO38YKEDjvyHs0=qXA@mail.gmail.com>
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com> <2850909.jKhAPPOaAE@ripper> <CADJ1cUSum9bHHBZB3gKdXukoqqDxk_f2nO38YKEDjvyHs0=qXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4070998.WN2MUrjTul"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Alessandro Bolletta <abolletta@netter.io>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart4070998.WN2MUrjTul
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 11 September 2020 14:19:59 CEST Alessandro Bolletta wrote:
> So you mean that it is not feasible to create a (single) linux network
> interface that let me send traffic on the batman-adv network in an
> untagged or tagged way, though the same interface I mean?

batman-adv is depending on the Linux code telling it what VLAN it should 
handle (through ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid). So something 
like the 8021q driver or the bridge code for vlans. Only when this was done, 
it will also handle the addresses in TT. So no, bat0 is not enough to 
transport something like an ethernet frame tagged as vlan1. You also need 
bat0.1 (assuming this is the vlan interface for VID 1). But it is then not 
really relevant for it whether the data was send through bat0.1 or was somehow 
else tagged and then put into bat0.

Kind regards,
	Sven
--nextPart4070998.WN2MUrjTul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9bchMACgkQXYcKB8Em
e0aV9hAA0NJ2tGfgkJHpplUvb9lOowjty1csFMdxTWc3Et4nnXSLFd7VShS+xUFN
dsBufc5su/IELiPSbDDyk6I2GLUOvjA26zt+kCDMvov3MitllIV/it0YsR15ajID
7KvSrHf4fCqLMYvwXm507LDiUfaBk3mQk3SqMLs6DvNbzsZon++hjGSEonU1wxkj
rMcpkqT6BVRVysKp7pb2bT0MEcOMeRPgJ+uGsIJw21yqutTXuSOeAKSoa58vynjJ
HUfnFWEOJPC8yISb8pQGiNGCygYdb9o8gyS71VmFee8XqQlnM5RP0I5NG9gzuiuh
Cv5IDM2SdyeFT3H8eLN1jXrnHc5i64Qu0G1Ar79DbBWun6t9WAGChAiYZrAcPs1h
POdhhPHzwwXf5kMENm0uAJWY7bk3RQsR17C/aWZIF/CnaI45rIH4JEQhGry3rYu7
RwLVlTIcETL0x0TK2N2kT+GGqJvg2rULab4+m/f8PgP2AXQgIH+xita+N/uGHoOy
nECbceuXdV/bNfTQPsEeau7wdbZqUzY46fS4Xt382LUpvXgzuExIbLTBFFMGWF3y
zRCngr9sF1MWf7Ie6+hcmFBRMzKg1cdhR+1rVrdPKP/8hPC45b3nuoScX/jmdH1v
ey8Kouks+wHSFm9vVP4bMj0RGBDJ+rAuftkDjz5m02gXtN+opyo=
=JJc+
-----END PGP SIGNATURE-----

--nextPart4070998.WN2MUrjTul--


