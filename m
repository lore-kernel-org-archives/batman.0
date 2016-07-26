Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 26 Jul 2016 13:55:19 +0200
Message-ID: <1545183.hcblZqnVsz@prime>
In-Reply-To: <1465152428-17299-1-git-send-email-sven@narfation.org>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1645329.osc2YVaxNs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] alfred: vis: Fix parsing of
	iface_status
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

--nextPart1645329.osc2YVaxNs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 05 June 2016 20:46:59 Sven Eckelmann wrote:
> The content of batman_adv/iface_status ends with a newline. Thus
> register_interfaces has to make sure that it only compares the first line
> without the \n when comparing with the status string.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

I've applied the whole series (78e1d64..5b67293). We can beautify the header 
stuff later.

Cheers,
     Simon
--nextPart1645329.osc2YVaxNs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAABCgAGBQJXl0+nAAoJEKEr45hCkp6hAoIP924FiWzFpPX6O7zwSfDRT39Y
atreYeeAT5zl2bzdKNPNqM7Y6FTtACfZjRuWH0+eEShwNMei09KQDduoeEpPrPB+
GRdRtFxH/JzipAV99PKjuTCRZ2XyyEeXI7bhs7gYXcjG9lhhmbBTn4GYyeibB6ve
A24zGl0ySldh6d1si/c0tCxIWEq6GfTbgIt/8hXgYKXfyaQetGHsr2n5T/Gj2e1e
Nwedgm01Z4oL7eWqfqNnmZ/XGMxBFNdiCfulkgat3HPxahnqyT69XEwF2YgosAjA
NaBPzG23PkIf+05pGw64kHY3ffwqe6DBL6TkNQImA6x7s92YrP9Px19bnRXlAm0P
NRCs9AxGjVkX9Rm/gP2r7ES0SvcaPa1cMJcNvuYTcgkM4ihXAKPuWrppQefD3zRy
7lKcxGLfw8Ykly2dyuvBfhBaMjTn/MzIvKrSa93mS7s6ssY79O/j4kVeAOogfFjw
/g+RWCmdDPeRW1M8nph7rQKc0Ig+VjciR5nKufflOg31imEKX7hX4psarEcPSedc
syeSuNb/JBKFC6oCyRPkBghRekp3Wg1wGaBFw8duR24sttzrH9VlYgZI/I3L9ZO3
Ot2sduNF2AsaVCCslRQkNxCrJ+RErR293dx8n6hk4Gvo9AttI8zoivH/BfXaWEPy
9tf7SnRNlpnzXour2RE=
=x6N0
-----END PGP SIGNATURE-----

--nextPart1645329.osc2YVaxNs--

