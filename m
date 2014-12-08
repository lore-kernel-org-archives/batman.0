Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 08 Dec 2014 11:39:12 +0800
Message-ID: <2140309.TXRIvSsL9G@diderot>
In-Reply-To: <1417426330-9178-1-git-send-email-sven@narfation.org>
References: <1417426330-9178-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15584057.UdFph5Zzc9";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: Calculate extra tail
	size based on queued fragments
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart15584057.UdFph5Zzc9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 01 December 2014 10:32:10 Sven Eckelmann wrote:
> The fragmentation code was replaced in
> 9b3eab61754d74a93c9840c296013fe3b4a1b606 ("batman-adv: Receive fragmented
> packets and merge"). The new code provided a mostly unused parameter skb
> for the merging function. It is used inside the function to calculate the
> additionally needed skb tailroom. But instead of increasing its own
> tailroom, it is only increasing the tailroom of the first queued skb. This
> is not correct in some situations because the first queued entry can be a
> different one than the parameter.
> 
> An observed problem was:
> 
> 1. packet with size 104, total_size 1464, fragno 1 was received
>    - packet is queued
> 2. packet with size 1400, total_size 1464, fragno 0 was received
>    - packet is queued at the end of the list
> 3. enough data was received and can be given to the merge function
>    (1464 == (1400 - 20) + (104 - 20))
>    - merge functions gets 1400 byte large packet as skb argument
> 4. merge function gets first entry in queue (104 byte)
>    - stored as skb_out
> 5. merge function calculates the required extra tail as total_size -
> skb->len - pskb_expand_head tail of skb_out with 64 bytes
> 6. merge function tries to squeeze the extra 1380 bytes from the second
> queued skb (1400 byte aka skb parameter) in the 64 extra tail bytes of
> skb_out
> 
> Instead calculate the extra required tail bytes for skb_out also using
> skb_out instead of using the parameter skb. The skb parameter is only used
> to get the total_size from the last received packet. This is also the
> total_size used to decide that all fragments were received.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Reported-by: Philipp Psurek <philipp.psurek@gmail.com>
> ---
> This is a minimized version which doesn't require the patch
> "[PATCH-maint] batman-adv: Check total_size when reassembling fragments".
> ---
>  fragmentation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 210a3cb.

Thanks,
Marek

--nextPart15584057.UdFph5Zzc9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUhR1kAAoJEFNVTo/uthzAzHkH/1SXAqLuV3v0VsZJzdpFgRMD
UJaDmMx7AQDWlXsxCnAGtx32swvoeyIVHprB2igTnYC9SgtAfcQZqiiOBQ6871SD
a2ucsx3CL0GHa8CwEXvq2W+XNhb9aawLEJ5r438Fk/uVoUSfSnlYVtipZyH/aR/R
GQFxQTPU7dT5rP7hcrA6ek9eWqY4J9RzhtiDrxbqOCehqCQeRO2WUnyF6Lw9959b
BvmGc8+4Yhpx7Re/vEE4acQvvKNJ2V+J+NCI6yglDDcHOP//HNVLmZMv5z9VMQEe
I5nBM+EgBMAaz0WkJuYy9sCZcpJPXTKT9Y5Sv0Z/6/IJNTj8EfJG823UEb2daqY=
=Z86r
-----END PGP SIGNATURE-----

--nextPart15584057.UdFph5Zzc9--

