Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 23 Oct 2013 05:01:04 +0800
Message-ID: <1819951.9mYekNXCEW@diderot>
In-Reply-To: <1382475009-20517-1-git-send-email-sw@simonwunderlich.de>
References: <1382475009-20517-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8927254.O61vABPiYz";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: generalize batman-adv icmp
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart8927254.O61vABPiYz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 22 October 2013 22:50:09 Simon Wunderlich wrote:
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
> Changes to PATCHv2 (as per IRC discussion with Marek and Antonio):
>  * use length for icmp_len after truncating in batadv_socket_add_packet
>  * remove the MAX macro and define packet size to icmp_packet_rr for now
> 
> Changes to PATCHv1 (suggested by Marek):
>  * use maximum packet size for batadv_socket_client icmp_packet instead
>    of hardcoded icmp_packet_rr
>  * drop unknown packet types in batadv_recv_my_icmp_packet()
>  * remove usage for icmp_packet_rr in batadv_socket_write where not
>    needed, and check for message type
>  * use right length parameter in batadv_socket_add_packet
> ---
>  icmp_socket.c |  128
> ++++++++++++++++++++++++++++++++++--------------------- icmp_socket.h
> |    2 +-
>  packet.h      |    2 +
>  routing.c     |  131
> ++++++++++++++++++++++++++++++++++-----------------------
> types.h       |    2 +-
>  5 files changed, 163 insertions(+), 102 deletions(-)

Applied in revision bb69cb6.

Thanks,
Marek

--nextPart8927254.O61vABPiYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSZueYAAoJEFNVTo/uthzAqfgH/32Qg5UlkxDaouzICl5uMvuI
+qRmhej0wann8F652Fpiogy9iMENAz/Pxcz84N9ITsh5sVRuR6oEoNWg362Jtkpn
/oaxSIv89ikF93H6mwZSncnpCKz4Acb939j10H6NSdc0PMa7B1O4MLAe+ogZULAF
Z66jDrsZKVbw16W2KaVNWtnj+DrXMMkZuhEKGz1phCaUj2g9GF5dNw8LWm0UWzKe
xW99opsxsSnAkMfVuKQTUNntkPHkkDR+4K9Ye6wnHQzmOHlRTAsby2KRIoBHikxZ
pHx6MYt6kAdpxMrTjfrfC9J4nVKnk0/eBuHtkVNMN5uWA5Jf4QBySoMvdugU5pc=
=AZSc
-----END PGP SIGNATURE-----

--nextPart8927254.O61vABPiYz--

