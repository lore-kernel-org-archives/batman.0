Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Feb 2017 18:26:37 +0100
Message-ID: <2345007.fdSCuFkgUi@bentobox>
In-Reply-To: <20170221090640.14686-1-sven@narfation.org>
References: <20170221090640.14686-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1581473.KkST2MkrqF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: set git diff driver for C
	source code files
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

--nextPart1581473.KkST2MkrqF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 21. Februar 2017 10:06:40 CET Sven Eckelmann wrote:
> From: Jean Delvare <jdelvare@suse.de>
> 
> Git can be told to apply language-specific rules when generating diffs.
> Enable this for C source code files (*.c and *.h) so that function names
> are printed right.  Specifically, doing so prevents "git diff" from
> mistakenly considering unindented goto labels as function names.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> [sven@narfation.org: Ported patch from linux.git]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

Applied in e3bab02816097f860545d9ce9ae0808c69d7c92f [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/e3bab02816097f860545d9ce9ae0808c69d7c92f
--nextPart1581473.KkST2MkrqF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliseE0ACgkQXYcKB8Em
e0amsxAAnOmf0ZEb/aaKoleODSmRX/kXoTex+HnC7wKWrUGpuUiJ95EFI5QjfMHM
f/Ha10uoOFq/wYrD9u07C3HpmjnaoOmRMefaElJRHGRVzXuCVnzIWacIK9W8NDtL
zd1phiMDkPUAKE6OLpjmL1Mw7q4Ac3mm8C4mpK2utxcost9dh9nfGNK8F6kmrvJC
dZQkKmqMdjZvafRORWO7o/7UmnSz4N4QSuD2k5SwDYIzYBmfHMkUxbkYmaa85MYU
h7uUICur5phDkAKZKxLZvgglJOSeptUEkRHMQWYTsi/V/Od9R1NdCAL5YoyIS6Hx
04apJErwIgsDJWm3vukk11eOBnX+5olQg815DfAwbd2PsA3OSPnNrdX8sIjyaTdK
bfQZgz5BMuIIUG/TEizuHrLR4zml20nVQTDoEwVkL3TBoRh3nZ8MG+ayQuSJAlW+
p86NGCO/gbnmYCgOMhteewBCRPntIHGGlhoKXMXSaZPRVdEF2ki/svfN7iLkdFKJ
j9hPYx6/s04lPX3wTlfrVXn9PJjhnMemH1+fmjA2abDdFaOieo6cJI4yUEqiY34R
O1OOhRS2vfu1E2rLjQEnkGhRU0Ljkju0p3FxurmfFGrve4JzXBPRIBd4/7fzoCrx
oxqqecwulEUManKza+vSTfF1DP9IzmkYGEzXHoKokFatcHJubEc=
=Purq
-----END PGP SIGNATURE-----

--nextPart1581473.KkST2MkrqF--

