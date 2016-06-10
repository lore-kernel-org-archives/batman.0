Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jun 2016 13:51:45 +0200
Message-ID: <7048408.piSH5dZvnO@bentobox>
In-Reply-To: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1529073.4Jo8MOIOjH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 0/6] Optimizations for setups running
	dat and bla
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

--nextPart1529073.4Jo8MOIOjH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 10 June 2016 13:10:58 Andreas Pape wrote:
> This patchset introduces optimizations for batman-adv in setups having several
> gateways into a common (switched) Ethernet backbone network especially if dat
> is additionally enabled.
> 
> Using the current implementation with bla and dat enabled, several problems
> can be observed in a real setup:
> 1. Multiplication of ARP replies from dat enabled gateways and dat enabled
> mesh nodes leading to an "ARP reply storm" in the common backbone network.
> 2. In rare corner cases bla does not fully prevent looping of unicast frames
> in the direction Backbone --> mesh --> backbone and looping of multicast
> frames in the direction mesh --> backbone --> mesh.
> The latter can lead to temporary confusion in the switched backbone resulting
> in packet loss and communication timeouts.
> 
> The observed problems are solved by introduction of additional rules for the
> dat handling, bla packet forwarding and bla claiming/unclaiming of clients.
> 
> v5:
>  - changed function name to batadv_bla_check_claim
>  - put added include file in alphabetical order
>  - added check to exclude ip address 0.0.0.0 from snooping

Doesn't seem to apply:

    $ git describe 
    v2016.2-50-g3ce003c
    $ git am ~/bundle-11-datbla.mbox
    Applying: batman-adv: prevent multiple ARP replies sent by gateways if dat enbled
    error: patch failed: net/batman-adv/distributed-arp-table.c:43
    error: net/batman-adv/distributed-arp-table.c: patch does not apply
    Patch failed at 0001 batman-adv: prevent multiple ARP replies sent by gateways if dat enbled
    The copy of the patch that failed is found in: .git/rebase-apply/patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".

Btw. there seems to be an "a" missing in "enabled" of the Subject
of the first patch :)

Kind regards,
	Sven
--nextPart1529073.4Jo8MOIOjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXWqnSAAoJEF2HCgfBJntGLgsQANL0vuqm6FcAen0MSUu8LKCG
YpzEfPCzvwTRdsi3B87ERwC3dBleT1x0ms1Q3gSPDCyCCIBgDolul3A1lUZ0r8ZM
Dxfva1MYbECY6Oi35nzgYjCrGhbQVsVSdkDfN6CIHgX6FHNtvv+hBj1iiBHTdUdZ
3S5UCkAuCWoJXZxOR/xvRAqICYdxF95vqe9Y8TsmaopjDNq6/pMu28KGHloh6wNO
qBbveP3NiqPteYasDPEFc5aMec8APYnXsyFO0tsIvJaM+5cv9HuXv6WY7xdXNoht
tOqdMgeEsYgHOO9ZNl9ThODQlqDDZF7u/DzjcV2/co95Clo/B/zWNyqEPTvglHvp
lTJCR1720bYjmExDj91cKfNE3PNMhrmExhPPmf6IqdjfRgByXiujYDMy+nbhEpf2
Pa67W72rHglf22oSdfDm8TNyA/IP9Qk5ZjnnxAMQ9YEPwjDj0fR1SlUJw/EIPAb6
dXLaUyEVBnKUtVmkU5fHrx1JcaobZ9xFzFOaK+eB5W7D5Fh8dunLZlrqLxtuk4XH
cUai9gtJBDasWJGxSd7/I7lwPwjipoxXzvQKt6rTC9FyzBRExDMy17PKCDUZ+C1z
xqJruKflnAExdrJcHDJ8UVQJvQqwILbDsBrHiM94b9e62s/RmEnhzcXb6ZBCIan4
cyYHpKm3PnVEJw/EY84R
=bjhd
-----END PGP SIGNATURE-----

--nextPart1529073.4Jo8MOIOjH--

