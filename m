Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 24 Jan 2018 14:40:03 +0100
Message-ID: <2157409.R7zQT89qM7@bentobox>
In-Reply-To: <0272f809d25b41fcab4ec5c4b66014f5e341d424.1516792897.git.mschiffer@universe-factory.net>
References: <0272f809d25b41fcab4ec5c4b66014f5e341d424.1516792897.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4311956.Gbpf7PobsW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: always assume 2-byte packet
 alignment
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
Cc: Matthias Schiffer <mschiffer@universe-factory.net>, David Miller <davem@davemloft.net>, netdev@vger.kernel.org

--nextPart4311956.Gbpf7PobsW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 24. Januar 2018 12:21:37 CET Matthias Schiffer wrote:
> NIC drivers generally try to ensure that the "network header" is aligned
> to a 4-byte boundary. This is not always possible: When Ethernet frames are
> encapsulated in other packets with 4-byte aligned headers, the inner
> Ethernet header will have 4-byte alignment, and in consequence, the inner
> network header is aligned to 2, but not to 4 bytes.
> 
> Most parts of batman-adv only care about 2-byte alignment; in particular,
> no unaligned accesses occur in performance-critical paths that handle
> actual payload data. This is not true for OGM handling: the seqno and crc
> fields are accessed as 32-bit values. To avoid these unaligned accesses,
> this patch reduces the expected packet alignment to 2 bytes for all of
> batadv's packet types.
> 
> As no unaligned accesses existed on the performance-critical paths anyways,
> this chance does have any (positive or negative) effect on performance, but
> it still makes sense to avoid these accesses to prevent log noise when
> examining other unaligned accesses in the kernel while batman-adv is
> active.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  include/uapi/linux/batadv_packet.h | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

I know your intentions and I understand the problem. But there is the chance 
that David Miller will reject this patch - like he did it some years ago 
with a similar (not the same) patch:

    "I'm not applying this, please try work to implement this more
    acceptably first." [1]

But maybe he has now some other opinion because the unaligned problem is 
caused by the encapsulation in VXLAN or maybe he has a better idea. At 
least VXLAN encap stuff should affect a lot more net code than batman-adv.

Kind regards,
	Sven

[1] https://patchwork.ozlabs.org/patch/295596/

> 
> diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> index daefd728..894d8d2f 100644
> --- a/include/uapi/linux/batadv_packet.h
> +++ b/include/uapi/linux/batadv_packet.h
> @@ -196,8 +196,6 @@ struct batadv_bla_claim_dst {
>  	__be16 group;		/* group id */
>  };
>  
> -#pragma pack()
> -
>  /**
>   * struct batadv_ogm_packet - ogm (routing protocol) packet
>   * @packet_type: batman-adv packet type, part of the general header
> @@ -222,9 +220,6 @@ struct batadv_ogm_packet {
>  	__u8   reserved;
>  	__u8   tq;
>  	__be16 tvlv_len;
> -	/* __packed is not needed as the struct size is divisible by 4,
> -	 * and the largest data type in this struct has a size of 4.
> -	 */
>  };
>  
>  #define BATADV_OGM_HLEN sizeof(struct batadv_ogm_packet)
> @@ -249,9 +244,6 @@ struct batadv_ogm2_packet {
>  	__u8   orig[ETH_ALEN];
>  	__be16 tvlv_len;
>  	__be32 throughput;
> -	/* __packed is not needed as the struct size is divisible by 4,
> -	 * and the largest data type in this struct has a size of 4.
> -	 */
>  };
>  
>  #define BATADV_OGM2_HLEN sizeof(struct batadv_ogm2_packet)
> @@ -405,7 +397,6 @@ struct batadv_icmp_packet_rr {
>   * misalignment of the payload after the ethernet header. It may also lead to
>   * leakage of information when the padding it not initialized before sending.
>   */
> -#pragma pack(2)
>  
>  /**
>   * struct batadv_unicast_packet - unicast packet for network payload
> @@ -533,8 +524,6 @@ struct batadv_coded_packet {
>  	__be16 coded_len;
>  };
>  
> -#pragma pack()
> -
>  /**
>   * struct batadv_unicast_tvlv_packet - generic unicast packet with tvlv payload
>   * @packet_type: batman-adv packet type, part of the general header
> @@ -641,4 +630,6 @@ struct batadv_tvlv_mcast_data {
>  	__u8 reserved[3];
>  };
>  
> +#pragma pack()
> +
>  #endif /* _UAPI_LINUX_BATADV_PACKET_H_ */
> 


--nextPart4311956.Gbpf7PobsW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlpojLMACgkQXYcKB8Em
e0Y+5g//cUEw3f3pP7fD76m6F0XkXbbFs8eRey4/y8zCN0nj75Ovv22lXyJSdkn9
zoSFL4AYSO5bSiRNiQmtgwH7G7oYaVvLYs8gE26YCCoXNMj9NElYAittpLYAyHiG
sj1WfqEaKM8HKJaAQT7IxkaOu+oHs5fj5WZ9saOju1ZonUXRcMcR7Ib8/BDrxJXX
xXPwkR0DTjj6qxdA5nOLOOYvQAh/KCWH8auDPoyUz3g60+nDC1WzkAAKGCs7kvB7
zbGoxDig9AKlT6z4UcpYBeWxv0F7Gt8QKQNz1gtzRyMAs2YJHnyaSvW4h/PiJ+Sf
jTyvPTT0FmKN6LCpKpL36HwsfeIqoG5F+BgxjmPwW0qT74OXjhBLc31kx6BAR8lo
OXJfzNnMPUJMOhA7XNynmSajQ16o9PMjUc7tBA9FS9hcT8NPxA+dtYWPya5lZTnG
PC8hWb172ervOvsz2BKeia099ZPT/eItx/OusqSCS4ESA7WeDbNOz1bNlNowKdnn
3j8ClfdggMqExA5HGYSsRJSRpKScoUQTrCfGYicFHn+xumRCQGKGVxGb2Na1TGJ0
QoZCIWiC7huRSYhFeBIRPMSBW9WRv61K4gaNROpH5LwWiSC53hUZja+AqwnFjcOG
EmUFyGgmhJG3iPe2aShdZ1TqUOAUTrCmCyBQHMOSqg0x1SkNOng=
=hppo
-----END PGP SIGNATURE-----

--nextPart4311956.Gbpf7PobsW--

