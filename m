Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 01 Dec 2014 10:23:02 +0100
Message-ID: <5581995.nEvZ9cQiNU@sven-edge>
In-Reply-To: <1417388720-5019-1-git-send-email-sven@narfation.org>
References: <1417388720-5019-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8147704.YHMfpuORLg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Calculate extra tail size
	based on queued fragments
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
Cc: martin@hundeboll.net


--nextPart8147704.YHMfpuORLg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 01 December 2014 00:05:20 Sven Eckelmann wrote:
> The fragmentation code was replaced in
> 9b3eab61754d74a93c9840c296013fe3b4a1b606 ("batman-adv: Receive fragmented
> packets and merge"). The new code provided a mostly unused parameter skb
> for the merging function. It is used inside the function to calculate the
> additionally needed skb tailroom. But instead of increasing its own
> tailroom, it is only increasing the tailroom of the first queued skb. This
> is not correct in most situations because the first queued entry can be a
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
> Instead take only skbs from the queue to merge a packet and remove the
> problematic parameter.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Reported-by: Philipp Psurek <philipp.psurek@gmail.com>
> ---

I thought a little bit about it and this RFC is too big for inclusion into the 
stable kernels. I would therefore propose to use the RFC-mini instead for 
maint and send the remaining changes as extra patches for master. Any 
comments?

Kind regards,
	Sven
--nextPart8147704.YHMfpuORLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUfDN5AAoJEF2HCgfBJntG8v4P/0fJvg3rlbfVEkBNFPxaxcS7
M9HO5VmSX68+IXIUIdRtQBOnWOB3XqjAkdxdcp8iDzfPAHJV2enITzR0ImTBvrv4
J84O5W/OgOAV0UxNvmdhzRFCdWt/79VVrhUZSGRI6oQhhXtXXN/SQHVMa4rpfs8I
HYK+J1USbDPck18FA/LBNJK83PVoheVuHTkfD0xJzyeagx0YdDxdIl+g2HUdMJkC
tq9vd1s7wC+haMWJVJtkCSrHfKOfsgVE8aPA5XG+vSWPwLRiMv/VL/zyyBoI6vw9
CkuSjkNXms2FiTcyKiaeJ+sWTKDIwGvmxF7d8XlaK7O/gSQafTd9KAWl5l2lGH22
HnK4WJou1W7WoB6NUf6Cy9TgBieFesszggdDMQBJgwe+M+W+aZb/eYDmcTygLs8T
8tNSgx+kfPe5WiUQJDO/MQ+mlWlQ/MwihHjiNQs8Bxa2a46F/YuT4qLagmqsT/vf
R2naI8gytSv2YbURyg/hwuDkFMgjdxjlVi5uaNnjy8wEDz/tfRCjEPO9kDnxg7Hy
i6QBoPOTYBdsAMQRj539EG+c+nAsYCKqcm7/o/S0pCd6vkTm34/DxAic4PYmrejZ
XiY+UiTVdH3B4S7yeyOAbPyZRu8KIst0zQr44ltP1vxa1LifTxoWk5F/BLvcmfBt
jnpmT76HKUGLEWTWYHGN
=TJjS
-----END PGP SIGNATURE-----

--nextPart8147704.YHMfpuORLg--

