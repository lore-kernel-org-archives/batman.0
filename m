Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Nov 2016 10:24:32 +0100
Message-ID: <4404358.R7R4S15M79@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2001314.jVibHR9x2V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH 0/7] alfred: Allow out-of-order TXEND
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

--nextPart2001314.jVibHR9x2V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

alfred allows to have out-of-order push data packet delivery. But these push
data packets are only accepted when they finish with an TXEND that has as its
seqno the amount of packets alfred received for this transaction. A TXEND
packet which is received before the last push data frame was received would
therefore cause the complete transaction to be canceled on the receiver side.

It was observed on a TP-Link TL-WR841N/ND v8 [1] that after the upgrade to
Gluon 2016.2 many (if not the most) transaction were out of order. The TXEND
was received before the actual push data was submitted. The master server
reacted to this by:

1. TXEND packet received to unknown transaction with seqno != 0
   -> TXEND packet was dropped
2. PUSH_DATA packet received with seqno 0 received
   -> new transaction was created
3. transaction timeout happened
   -> transaction was dropped

This patchset now changes the behavior to automatically create transactions
when TXEND packets are received. The routines to decode TXEND and PUSH_DATA
packets will check if all frames of a transaction were received and commit the
data when the check was successful.

This stabilized the statistics [2] for the previously mentioned node.

Kind regards,
	Sven

[1] https://stats.freifunk-vogtland.net/dashboard/db/node?var-node=10feedb73eb2&from=1478782587039&to=1478902771655
[2] https://stats.freifunk-vogtland.net/dashboard/db/node?var-node=10feedb73eb2&from=1478902641027&to=1478938850519

Sven Eckelmann (7):
  alfred: Avoid hash search for transaction cleanup
  alfred: Move tx finish functionality in extra function
  alfred: Remove checks for committed/dropped transaction
  alfred: Don't force cleanup of transaction on TXEND
  alfred: Use expected packet count to finished transactions
  alfred: Allow PUSH_DATA to finish transactions
  alfred: Allow TXEND to start new transaction

 alfred.h    | 11 +++++---
 recv.c      | 84 +++++++++++++++++++++++++++++++------------------------------
 unix_sock.c |  2 +-
 3 files changed, 51 insertions(+), 46 deletions(-)

--nextPart2001314.jVibHR9x2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYJt/QAAoJEF2HCgfBJntG9BUQAIDG5C84lHB7OlA1U8R21AOR
JQ7uW5WbH+4NnXvzXz2MjhfgpMTs+8dwSRzRKJXZ3G7GEfz9UzkTom9+qllqtEqk
qy6UQU2YjAHxnZHIzramKrjofLyrFCJzZJEeg4v298evT2rmkYipheZ7LtP8xT+T
SwkQZD1UhYxUuNwyagsVbr19vOwiZCqTg6qXg+VImAfojWDuhksnRMAKYE5dn0a/
YHFz6O8onZA+dZnerWzWBvLk6FV8yeFZK43r3JZ20HMj7x5IwTOwuVWChgLv/IQc
C9KvHNog+eFKWhSKSk4z9SZWAGxF6/tasHNWDtxzLnXaNS+QEi6amvmtSETSpQz4
J1SbrSm+1zaDK70qGNgu/DZJ6aK1ErjOA52pOKBPKp9IS49uYL/5aNHXZP9c8nO6
fcmBk3ON/fETtXIU52Fi1AzhUpTYG7sE//uUV/li1xLx1kBb8gA6CA+ZOnodvz4y
PUAlQRaqqbrWZCXR4dvNs+gWnvCUwSCMJ72hAOj8/4HhUYb60MTWGhIo9GOjNvMJ
Vy8alsTQwTKpNb4UKbuMJ1B0hL2VCwF5IEsR9l44kuGgsxtDPX2OR5IJwRXmt3lS
CqzEOTLOIW70x1bymlScZo89LpnsaWpr5vxbWjX2ofEF+aHdbaODWBV9zDIE90xn
5EyKjMR6lr2yYG9j/8VH
=MorE
-----END PGP SIGNATURE-----

--nextPart2001314.jVibHR9x2V--

