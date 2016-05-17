Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 17 May 2016 17:12:33 +0800
Message-ID: <16831453.6LvDVGI860@voltaire>
In-Reply-To: <1463071923-27298-1-git-send-email-sw@simonwunderlich.de>
References: <1463071923-27298-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2420884.2GYmW8tvxH";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv2] batman-adv: replace WARN with
	rate limited output on non-existing VLAN
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

--nextPart2420884.2GYmW8tvxH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 12, 2016 18:52:03 Simon Wunderlich wrote:
> If a VLAN tagged frame is received and the corresponding VLAN is not
> configured on the soft interface, it will splat a WARN on every packet
> received. This is a quite annoying behaviour for some scenarios, e.g. if
> bat0 is bridged with eth0, and there are arbitrary VLAN tagged frames
> from Ethernet coming in without having any VLAN configuration on bat0.
> 
> The code should probably create vlan objects on the fly and
> transparently transport these VLAN-tagged Ethernet frames, but until
> this is done, at least the WARN splat should be replaced by a rate
> limited output.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
> Changes to PATCH-maint:
>  * added newline to output
> ---
>  net/batman-adv/translation-table.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied in revision 0479211.

Thanks,
Marek

--nextPart2420884.2GYmW8tvxH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXOuCBAAoJEFNVTo/uthzAUd4H/RHDy0pAFP0t3x/4b1qTbfLm
wD8YgqhZY176aVlDuLyc2jmI3Z+v97UyEy2MtKtnsj2LoM8e86g23SweS2IzwW7l
mQVuSj8VjkRX2W3MPSCEnpQPzfWo+Y1ziSjY9mnnwIssNgnM47xotlX1nzb+uY+y
EgVRz1/WIWHXAIgxjX2AYbtC2kHucIYw5Z7CsqCbrzaTVmRGPnFIcslivQnWT6Hu
tFf9WhsxJ7tndwDTNtaM9l1UqjXrIy1MDpsDWdl4hUKsuXFN0tR/tLgWH8UP5UwT
yHCuVhq+MoLoojkjOobYQYz7OSqxyUbwifODIJSCeTAYus/gLnMgRjsGsDrO1ug=
=o2KI
-----END PGP SIGNATURE-----

--nextPart2420884.2GYmW8tvxH--

