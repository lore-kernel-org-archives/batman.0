Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Feb 2017 07:55:06 +0100
Message-ID: <2028520.vrkpGIZa5q@bentobox>
In-Reply-To: <dm0efb.oli4aj.1hge137-qmf@riseup.net>
References: <dm0efb.oli4aj.1hge137-qmf@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3692812.Hd1avgpvS4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Unable to Change from BATMAN_IV to BATMAN_V
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

--nextPart3692812.Hd1avgpvS4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 17. Februar 2017 04:25:25 CET leftbydefault@riseup.net wrote:
> I came across a thread previously on this same issue with respect to openwrt.
> 
> I tried to change the routing algo following tweaking section of batman wiki as soon as loading the batman_adv module.
> 
> I am able to see BATMAN_V under availabile algorithms but available for next instance of batx. I understand it has to be done before this bat0 interface is created, but I am doing this before bringing up bat0 using ifconfig

Mo, it "ifconfig xxxx up" is way to late. It the module has to switched to
BATMAN_V before the batX interface is created (this is before the setup
function of the netdev is executed in the kernel).

Kind regards,
	Sven
--nextPart3692812.Hd1avgpvS4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlimnkoACgkQXYcKB8Em
e0Y0LBAApakoBShKb7IHQQ0kKv0tw36BJlAIyzhyO1P/8JnS1Y57nedmCUtGePGF
ljSy/X4GKcipiw6iRwPiv7yYv+Y1DIccpJ5xSdMiDkd9B9H6vEEoFmpr6W3KUIXm
GNJAPIBqFXzS6dDrklnkQEMRhql+VA/ylRmLeC/tiaf/cNQ51CVQ25vDWGC1cLOe
rDxlVbpiQOhMfgHLGVOJDdA7eESSjJY0mRne1greHb7t9hs2ggzL04JdvluU5gIL
2VQJMeZmEjJcNp/PmgtHTRNiy8nR/2qb2090cHOFVTkCCN2sfvPNShi7IjZBbwc8
CtgSXbpn25ViZX0AQna66KbGgUKSbvGFnmsCXCyU0UqV99TBOPp4bvHPFb5qz/NN
S/i2poTFVa7RRY7s0N+pkf+xYt94YecwHbPNWFlxeZ9VzLTIcSeV/AVnJGicaQ3f
dx17/7ElKbpB1/fjFZ5gLA0E6dcXKsmf9L22cH/3iyihScZDlv9xtyqB11SaeauA
UaoaUj2ukf46/zEVVb4yeVe3wb29qtvH1Fk02XCobcqY2PBJemcLRS6vtDoUFdF8
cTLtakBrEwMNyvGZzKCBaWEFZ+IVFOLqIV4p4j9VTd2syywK97+yvomdkdurzJEJ
dotD0yNmog8Jr6XpUd/sRpaV9ty3njUXSrMPETmK25Pfir3wURA=
=4nKN
-----END PGP SIGNATURE-----

--nextPart3692812.Hd1avgpvS4--

