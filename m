Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 25 Apr 2013 20:44:03 +0800
References: <1366883862-24768-1-git-send-email-1366879046-24507-2-git-send-email-siwu@hrz.tu-chemnitz.de>
In-Reply-To: <1366883862-24768-1-git-send-email-1366879046-24507-2-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304252044.03741.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/6] batman-adv: remove vis
	functionality
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

On Thursday, April 25, 2013 17:57:42 1366879046-24507-2-git-send-email-
siwu@hrz.tu-chemnitz.de wrote:
> diff --git a/packet.h b/packet.h
> index aee6b96..0ce4867 100644
> --- a/packet.h
> +++ b/packet.h
> @@ -69,12 +69,6 @@ enum batadv_icmp_packettype {
>         BATADV_PARAMETER_PROBLEM       = 12,
>  };
>  
> -/* vis defines */
> -enum batadv_vis_packettype {
> -       BATADV_VIS_TYPE_SERVER_SYNC   = 0,
> -       BATADV_VIS_TYPE_CLIENT_UPDATE = 1,
> -};
> -
>  /* fragmentation defines */
>  enum batadv_unicast_frag_flags {
>         BATADV_UNI_FRAG_HEAD      = BIT(0),
> @@ -257,17 +251,6 @@ struct batadv_bcast_packet {
>  
>  #pragma pack()
>  
> -struct batadv_vis_packet {
> -       struct batadv_header header;
> -       uint8_t  vis_type;       /* which type of vis-participant sent
> this? */ -       __be32   seqno;          /* sequence number */
> -       uint8_t  entries;        /* number of entries behind this struct */
> -       uint8_t  reserved;
> -       uint8_t  vis_orig[ETH_ALEN];    /* originator reporting its
> neighbors */ -       uint8_t  target_orig[ETH_ALEN]; /* who should receive
> this packet */ -       uint8_t  sender_orig[ETH_ALEN]; /* who sent or
> forwarded this packet */ -};
> -
>  /**
>   * struct batadv_coded_packet - network coded packet
>   * @header: common batman packet header and ttl of first included packet

The corresponding batadv_iv flag (BATADV_VIS_SERVER) should be removed as 
well. The same is true for the packet type (BATADV_VIS).

What about the batctl patch ?

Cheers,
Marek
