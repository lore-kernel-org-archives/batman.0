Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 17 Nov 2016 17:06:31 +0100
Message-ID: <7777028.4BuxxMg4pt@prime>
In-Reply-To: <4404358.R7R4S15M79@sven-edge>
References: <4404358.R7R4S15M79@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9514810.QbCuEtcsbT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/7] alfred: Allow out-of-order TXEND
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

--nextPart9514810.QbCuEtcsbT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, November 12, 2016 10:24:32 AM CET Sven Eckelmann wrote:
> Hi,
> 
> alfred allows to have out-of-order push data packet delivery. But these push
> data packets are only accepted when they finish with an TXEND that has as
> its seqno the amount of packets alfred received for this transaction. A
> TXEND packet which is received before the last push data frame was received
> would therefore cause the complete transaction to be canceled on the
> receiver side.
> 
> It was observed on a TP-Link TL-WR841N/ND v8 [1] that after the upgrade to
> Gluon 2016.2 many (if not the most) transaction were out of order. The TXEND
> was received before the actual push data was submitted. The master server
> reacted to this by:
> 
> 1. TXEND packet received to unknown transaction with seqno != 0
>    -> TXEND packet was dropped
> 2. PUSH_DATA packet received with seqno 0 received
>    -> new transaction was created
> 3. transaction timeout happened
>    -> transaction was dropped
> 
> This patchset now changes the behavior to automatically create transactions
> when TXEND packets are received. The routines to decode TXEND and PUSH_DATA
> packets will check if all frames of a transaction were received and commit
> the data when the check was successful.
> 
> This stabilized the statistics [2] for the previously mentioned node.

Adopted this series in commits 323c1ed..12a478c.

Thanks,
     Simon
--nextPart9514810.QbCuEtcsbT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYLdWHAAoJEKEr45hCkp6hzd8P/3vx5dFqjFvVUr/BtmgdfgTA
WmUZC9VbwafFldD9dbtG6Lbg7T7DTdwtj0cImkz8p0o4KPcPsQi5Kjy7T0Yhd4V3
vdB7iEpYAaVmizd7iwwiwRux5w2hD0CJ/mKbRlyDkURX6gy5r/wORrizSmBqGE/Z
QIWVMJqwBIixZrNL4vKO6aqclQ/w3NXNFLIfgCbJTMzAdHCNMdLSfByR5CNW9rqY
m7pZfAWlxs3IQkkEi+73gveWgsjKKGiKkQ0tYNA3uvj2CeoywsLSfsXGSVjcxoPe
CZX7gmPXl8lRwKAx9LHCJwVGtEzm7qienzVvz3ByU0S71E9sWqgi8r0Yo9m8IZjd
Az6RHpdTTudByCWUR1M1U09qHIz1KtFy34mFp1j1yblz7/j0NUu1ggU48Ui2seaa
jZ63sF/DWVZPxU3D6dn0FeSfofhgxS/nmqvVbPBLm+SO+VnrulPhvTeNEOVYNoa5
ET3L2tYpwXLRfeDeyDP1iufffK4Ak92zBJOlkeIG6dZnMBG0/gT9II8wlTmCMJeU
iNDxASxkRu3VULPNKnhNCepyKTgiG/qr0ibZyBqFVCxYrdBSEogsHs6bXxf20tMt
9pHI0G/NLGPopqM3pNklSEFiWAXhsI7CLODDpxwnHhSqTccczMOR6btY0dlHCmRB
kQsCvgb1M9w+3GY4dxfm
=wWe/
-----END PGP SIGNATURE-----

--nextPart9514810.QbCuEtcsbT--

