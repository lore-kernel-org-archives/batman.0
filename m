Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 14 Jun 2012 22:43:55 +0200
Message-ID: <2637165.TIHWgPI098@sven-desktop.home.narfation.org>
In-Reply-To: <1339692719-27313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1339692212-27221-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1339692719-27313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2034987.FldZYdlkdy";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Add the backbone gateway
	list to debugfs
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--nextPart2034987.FldZYdlkdy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 14 June 2012 18:51:59 Simon Wunderlich wrote:
> This is especially useful if there are no claims yet, but we still want
> to know which gateways are using bridge loop avoidance in the network.
> 
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> [EDIT: forgot to rename the function ...]
> ---
>  bridge_loop_avoidance.c |   68
> +++++++++++++++++++++++++++++++++++++++++++++++ bridge_loop_avoidance.h |  
>  8 ++++++
>  debugfs.c               |   12 +++++++++
>  3 files changed, 88 insertions(+)

You forgot the README and most likely the batctl part.

Kind regards,
	Sven
--nextPart2034987.FldZYdlkdy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJP2k0LAAoJEF2HCgfBJntGgiEP/199gweIOhjv7qyC+gwPhZ1i
YswBbl5aj1PPtWJ1lCAKR5RTHvZh/tWFxBbuv8R9NcxD0CbWEyaP7cj6D5Z8Sb+A
StXv4J9Py8excNu0hKzoMT1sRFVjc6yHj/092Y8Y8lYyACRw6W8SeF2uJyRZtcbH
g6U2hRNJclysFBq5bFOj66ikVE8yCKnk0KkRK8VY5xafd5ox0rtsk7H22xW/j15f
FK8b4E7/fyLVg46+UsNi0Fd/xHEgorP44UaQOK3viElc3h0WVjbw/5/48cfKYPRe
68xUgfu9jEKcoPlw/YCnYFMXY1iBhavZvJfWZuHg3V/VAP12ZbIj6hfcMDQciZmA
CeFroYZSa21ZP+iRcbdq2u7+ZRx+G3duq5sR2lgV2PntCTGOuEDgH9uXR5lrNQYS
OSSXppkhmqHsqcyMionlbMavp2u3q27JjhMCYT3wu3qxyTyJSpojh8+vPQlro4cW
DRobuSGHvDBeL93upq8xkt8NSoEzgCgIDyDuykShzVv99/5K5Wcg1o1s4I3tbA1h
gKYa/RpiVqGpMdJK2kf9EEfsdY8f1Yl60ezCo1wqi1V4qaUSzS6khplR06hs7WN0
S7M1/mLqQoSg3X52yRbA2Joy60nNSphk7aXM84N3epfbGBz1Iw00ybCtZcKmUcjz
x2BB/owGg70QAoX99AOb
=sTJ4
-----END PGP SIGNATURE-----

--nextPart2034987.FldZYdlkdy--

