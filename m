Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Apr 2019 09:12:35 +0200
Message-ID: <5848806.7i0FG0An4q@bentobox>
In-Reply-To: <CANDy-jbnAvmYFaPjK2tfTRANFeijK-b7nTKrbMcSUHgkAPH34g@mail.gmail.com>
References: <CANDy-jbnAvmYFaPjK2tfTRANFeijK-b7nTKrbMcSUHgkAPH34g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3569377.nvGpltt3GT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Removing a node causing mesh to stop
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Lucas Pickstone <lucas.pickstone@minlog.com.au>
Cc: b.a.t.m.a.n@lists.open-mesh.org, James Matheson <james.matheson@minlog.com.au>, Andrew Corke <andrew.corke@minlog.com.au>

--nextPart3569377.nvGpltt3GT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 12 April 2019 08:00:11 CEST Lucas Pickstone wrote:
> We have problem where our mesh is failing after a node is removed from
> it. We have a test set up of 3 computers (A, B and C) that can all
> directly see each other in an ad hoc wireless network.
> 
> When we remove a node, the mesh between the remaining two nodes
> continues to work for a time (batman pings get through), but "batctl
> o" shows nothing recently last-seen. Once it times out after 200
> seconds, the mesh dies (no further pings via batman get through).

It is normal that the mesh closes down when there are no remaining paths to 
the originators (your originators table was completely empty when the mesh 
broke down). Since it looks like it is working in unicast while the last-seen 
goes up, I would guess that broadcast packets on the underlying layer are 
either not correctly send or not correctly received by the wifi driver/
firmware on the remaining nodes.

Unsure how this is triggered by removing a single node. But in case you are 
using meshpoint interfaces with mesh_fwding=1 (which is wrong) and a higher 
multicast rate, it could have been that the removed nodes was actually 
relaying the bcast/mcast packets (which might be send with a higher rate as 
suggested on open-mesh.org - or which maybe was automatically selected by the 
ath10k firmware) and the remaining nodes B+C cannot really communicate on the 
selected mcast/bcast rate directly with each other.

> If we bring the disconnected node back up, everything goes back to normal.

What interface mode are you using? meshpoint without mesh_fwding (yes, make 
sure that the mesh parameter mesh_fwding is really set to 0 [1] during your 
tests)? Or IBSS (which would usually mean an ancient firmware or Ben Greear's 
firmware)?

> We're a little bit stuck on how to diagnose/debug what is happening.
> We thought that maybe the underlying ad hoc network was causing
> issues, but it seems okay - we can assign IP addresses on the wlan
> interfaces and ping without interruption through the entire test.

Please check whether it can receive/send broadcast packets in both directions 
during the test (according to your TQ with at least 2/3 of success with a 
bcast ping-pong). This is how OGMs (to generate the content of the originators 
table) are sent. Also make sure that your receive+send the stuff as actual 
broadcast packets. There are ways to let the wifi layer convert these 
broadcast/mcast frames to unicast frames - and this is not allowed for batman-
adv because B.A.T.M.A.N. IV needs to measure the loss for broadcast packets - 
unicast packets are retransmitted automatically by the wifi components (which 
we don't want).

[...]
> Environment (identical on all computers):
> - WiFi Card : SparkLAN WPEQ-160ACN(BT)

It is a QCA9377-7 miniPCIe, right? Is it using the PCI pins or the USB 
pins [2]?

> - WiFi driver: nl80211

This cannot be the driver - this is the module which allows userspace to 
communicate with cfg80211 (and vice versa). Maybe it is ath10k, ath10k-ct or 
the proprietary QCA monster (which recently received semi working cfg80211 
support).

Kind regards,
	Sven

[1] iw dev wlan0 get mesh_param mesh_fwding
    iw dev wlan0 set mesh_param mesh_fwding 0
[2] https://www.qualcomm.com/media/documents/files/qca9377-product-brief.pdf

PS: Not the best idea to send from a DMARC (quarantine policy) domain to a 
mailing list.
--nextPart3569377.nvGpltt3GT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlywOmMACgkQXYcKB8Em
e0Y6xQ//dILc6gB9WeaiP7e56Iz2NqRcA5LhsDtUR9HxVkpz9nplBbO1ltNeRT7i
BeL7WE6lGaZVAboaF9wLPI39uLs5wZ3yQ/tD+1eEi6u5CfXSyOXO8HlLxWr14Wfq
7v3bmVSC3tkvuOY41d3BuqmWNe/F+zkDXST4NG+31VI00rnEwMsRuy6XJHArCH8k
RnRIVs6Ew3ywHUqpri54iFeXuN3rx4aYQ8v4XaqEQ5VRrC+IRqcO/cgEqe7ADP4L
zm+BQszfQavRBmsT2FM96tm60yT/x+kUfp4Uhdv6rFD1mS+0TbaECHt0z9ggCDc7
7tTvWmdI/kV/bxOuTuYdnBn/KYasXtheejnP5w+Ov0N5C8Nmx7KrduggTWFNwjnz
OJDIamugWf3kXVEvOEaCZdY460kats4aiCkkO0MZNXMecr7nlWXzGqtezTUQM5qr
3IYdj+oeoZcIc8QvbWFp3eNegF2aCD4uzbwubJr4VY603MTDzuhgMDlyyvelTZH8
/zPtTy29cGafGH2ysXEM69tGYmiA/HcFeq15CKKUTxYap5Q8TlfC2mTDgqQFdjgh
rJep/+P3cYsdUonhYhh++1Qj6uIRVyI12HCG9hl9PL8hQ98Y/d+b4nPdyso6BkG0
fxlCuK4DeEwRA8+C34hfGvxiNHyHFBMhS9KM9v9ACHxxRfAVD2w=
=D8Fj
-----END PGP SIGNATURE-----

--nextPart3569377.nvGpltt3GT--



