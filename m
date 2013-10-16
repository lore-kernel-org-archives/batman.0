Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 16 Oct 2013 13:59:18 +0800
Message-ID: <1779622.xWDEdjCAYf@diderot>
In-Reply-To: <20131015192023.GN3873@neomailbox.net>
References: <1379088490-2693-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <3449342.7k6WirsOky@diderot> <20131015192023.GN3873@neomailbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1545699.c6FcK5136r";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalize batman-adv icmp
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


--nextPart1545699.c6FcK5136r
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 15 October 2013 21:20:23 Antonio Quartulli wrote:
> > Besides, if we make everything generic batadv_socket_packet->icmp_packet
> > should not be hard-coded to batadv_icmp_packet_rr but the largest
> > available
> > ICMP packet type ?
> 
> or we dynamically allocate a buffer of size 'len'? In this way we don't need
> to change icmp_packet each time (hopefully not so many but still..)  the
> "largest available ICMP packet type" changes.

Allocating a dynamic buffer does not solve the underlying issue. At some point 
we would want to check the packet size - either through sizeof(socket_packet-
>icmp_packet) or a macro or whatever. 
Take a look at batadv_max_header_len() for an idea how to address the matter.


> > Wouldn't it be better to dump unkown icmp types for us instead of copying
> > everything to user space ?
> 
> dump == drop ? in that case I agree. Delivering unknown packets to batctl
> may also be dangerous.

Yes, that is what I was talking about.


> > Same is true for batadv_socket_write(). We should use the icmp header and
> > not assume icmp echo.
> 
> do you mean using the ICMP header to understand what packet it is and then
> behave accordingly? Also in this case I agree with you :)

Yap.


> Moving to a packet type based "check" was also part of the original idea of
> this generalisation (if I remember correctly), but not really needed when
> looking at avoiding further compatibility breakage (this should be the
> reason why this "feature" is not part of this patch).

I agree - it is not strictly needed but would fit since the rest of the patch 
works into the same direction.

Cheers,
Marek
 
--nextPart1545699.c6FcK5136r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSXis6AAoJEFNVTo/uthzAPVUIAIgrE+t/DWzoLsEGfk6QgzQi
iZMLKJRufHR3hh4jg2/BXh5Gl5c2/srvRA3XtoLp24W2TlatFM6OJ/p8o5BrDlV0
zHb8qEVP+IrIuOujzowxndzrUjTXggV+ejnUL5rvK7y+n2WDs/TydcXAZHH+TpJ6
Whx8hmzcXCPqvZ8kdN/qkjB3P8CPOXrsvMIoBM6gsoxPOYbFVpGVJILTCfEt02E5
Ezz4wPd2LMccSTXHhOd+7QtxMupViW8BswYkeY4Yp4N06vRqSPTwitI8rnab8zDK
n4bFjS42o/em0JuW3n3m1KUa4kMLP07VPaqNtUapvRvN4FlD7n//snxncMpBliQ=
=rGB/
-----END PGP SIGNATURE-----

--nextPart1545699.c6FcK5136r--

