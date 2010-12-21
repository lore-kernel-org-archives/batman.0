Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 21 Dec 2010 18:39:37 +0100
References: <1292320696-11983-1-git-send-email-linus.luessing@ascom.ch>
	<1292320696-11983-2-git-send-email-linus.luessing@ascom.ch>
In-Reply-To: <1292320696-11983-2-git-send-email-linus.luessing@ascom.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201012211839.37926.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Creating new neighbor
	discovery packet
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?utf-8?q?L=C3=BCssing?= <linus.luessing@ascom.ch>

On Tuesday 14 December 2010 10:58:07 Linus L=C3=BCssing wrote:
> This patch creates the new neighbor discovery packet type (which is not
> actually being used with this patch). It will later be responsible to
> detect neighbors and calculate the link quality to them.

In fact, most of the patch renames batman_packet to batman_packet_ogm. Why =
not=20
making this a rename patch only ? The next patch still renames some more st=
uff=20
which could go into this patch as well (e.g. schedule_own_packet).

How about renaming batman_packet to batman_ogm and batman_packet_ndp to=20
batman_ndp ? Or ogm_packet / ndp_packet ? The 80 chars per line limitation=
=20
does not make these long names very handy ...


> -#define BAT_PACKET       0x01
> -#define BAT_ICMP         0x02
> -#define BAT_UNICAST      0x03
> -#define BAT_BCAST        0x04
> -#define BAT_VIS          0x05
> -#define BAT_UNICAST_FRAG 0x06
> +#define BAT_PACKET_NDP   0x01
> +#define BAT_PACKET_OGM   0x02
> +#define BAT_ICMP         0x03
> +#define BAT_UNICAST      0x04
> +#define BAT_BCAST        0x05
> +#define BAT_VIS          0x06
> +#define BAT_UNICAST_FRAG 0x07

Although I like this reordering (I would like to see BAT_UNICAST followed b=
y=20
BAT_UNICAST_FRAG) I think we can't easily touch this without annoying the=20
wireshark folks. Maybe we don't care because they hate us already ?


> -struct batman_packet {
> +/* Neighbor discovery packet */
> +struct batman_packet_ndp {
> +	uint8_t  packet_type;
> +	uint8_t  version;  /* batman version field */
> +	uint8_t  orig[6];
> +	uint32_t seqno;
> +	uint8_t  num_neighbors;
> +	uint8_t  align[3];
> +} __attribute__((packed));

This should go into one of the later patches where it is used.

Cheers,
Marek

