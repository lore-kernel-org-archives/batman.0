Return-Path: <andrew@lunn.ch>
Date: Wed, 16 Feb 2011 07:08:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110216060811.GB11570@lunn.ch>
References: <1297789948-16948-1-git-send-email-linus.luessing@ascom.ch>
	<1297789948-16948-3-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1297789948-16948-3-git-send-email-linus.luessing@ascom.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/13] batman-adv: Add explicit batman
 header structure
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Linus L??ssing <linus.luessing@ascom.ch>

On Tue, Feb 15, 2011 at 06:12:17PM +0100, Linus L??ssing wrote:
> Just a minor style adjustment, to give people a hint which fields should
> not be reordered and need to be at the beginning of each packet with
> batman-adv's frame type.

Hi Linus
  
> +struct batman_header {
> +	uint8_t  packet_type;
> +	uint8_t  version;  /* batman version field */
> +	uint8_t  ttl;
> +	uint8_t  align;
> +} __packed;
> +
>  struct batman_packet {
> -	uint8_t  packet_type;
> -	uint8_t  version;  /* batman version field */
> +	struct   batman_header header;
> +	uint32_t seqno;
>  	uint8_t  flags;    /* 0x40: DIRECTLINK flag, 0x20 VIS_SERVER flag... */
>  	uint8_t  tq;
> -	uint32_t seqno;
>  	uint8_t  orig[6];
>  	uint8_t  prev_sender[6];
> -	uint8_t  ttl;
>  	uint8_t  num_hna;
>  	uint8_t  gw_flags;  /* flags related to gateway class */
> -	uint8_t  align;
>  } __packed;

Two different ideas, both triggered by the align byte in header. This
byte is a waste of space, it is not used, and it is probably not easy
to find something which all packet types are going to need in the
future. 

1) Did you try not having it. So long header is __packed, and all the
structures it is used in are __packed, i think the compiler will do
the right thing. The downside is that alignment is not obvious. Most
people will assume header is 4 bytes, not 3, and think the alignment
of the packets is wrong. 

2) Did you consider using a union? It is a more invasive patch, but
the alignment is then clear. The downside is sizeof() no longer gives
you the per packet type size, rather it gives you the size of the
biggest member of the union. So this makes the change even more
invasive and bug prone.

I think i prefer 1), with appropriate comments to explain the
alignment issue.

	  Andrew
