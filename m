Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 23 Oct 2013 08:58:59 +0800
Message-ID: <7361726.X9Gu1TtIcC@diderot>
In-Reply-To: <1382486068-3145-1-git-send-email-sw@simonwunderlich.de>
References: <1382486068-3145-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10173424.oLqoMgLtdY";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: generalize batman-adv icmp
	packet handling
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart10173424.oLqoMgLtdY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 23 October 2013 01:54:28 Simon Wunderlich wrote:
> Instead of handling icmp packets only up to length of icmp_packet_rr,
> the code should handle any icmp length size. Therefore the length
> truncating is moved to when the packet is actually sent to userspace
> (this does not support lengths longer than icmp_packet_rr yet). Longer
> packets are forwarded without truncating.
> 
> This patch also cleans up some parts where the icmp header struct could
> be used instead of other icmp_packet(_rr) structs to make the code more
> readable.
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
> Changes to PATCHv3:
>  * remove unnecesary blank line (buildservers checkpatch complained,
>    mine didn't ...)

Since your patch has been applied already, we will need a patch only fixing 
this 'regression'. Antonio will merge them together.

Cheers,
Marek

--nextPart10173424.oLqoMgLtdY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSZx9XAAoJEFNVTo/uthzAMg8IAJzr/Qh9cPgaoqShfij6r5eh
jbjZ+0bDN05E989Lqs8RZ/huxLKcOLDbl7Jt54+5XTAaUNGFg65oi8CeGGU1X3/V
XK4qJbfXEYMbqXluQhKXfxSbWdGuuEyInV15EXq0ruCqJvAo21O14ZIoaNTvCm+O
QvEKG7o2iEvHoYn5klYm5ZjSAEk5apVEpTIaFeHPYo+GIMxGwc3VICpHtpgNf1fL
2dt0Lcj9ZB+mFFTEPzixjHtDTw1d4Rgaz6Z7ayAWK/upnSMcGahThbPQv2hczMhq
YTc6sLNVXeU4mkZozkbzahFKgHdK9wFni8Ls0apSCy2wMhqjNBugyjbsCasXIPs=
=ZoeL
-----END PGP SIGNATURE-----

--nextPart10173424.oLqoMgLtdY--

