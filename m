Return-Path: <andrew@lunn.ch>
Date: Tue, 7 Feb 2012 13:12:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120207121200.GA15165@lunn.ch>
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-1-git-send-email-lindner_marek@yahoo.de>
	<1328606451-3418-2-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1328606451-3418-2-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: randomize initial seqno
 to avoid collision
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Tue, Feb 07, 2012 at 05:20:46PM +0800, Marek Lindner wrote:
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> ---
>  bat_iv_ogm.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 3eff7f0..4ac2d1d 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -33,6 +33,11 @@
>  static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
>  {
>  	struct batman_ogm_packet *batman_ogm_packet;
> +	unsigned long random_seqno;
> +
> +	/* randomize initial seqno to avoid collision */
> +	get_random_bytes(&random_seqno, sizeof(unsigned long));
> +	atomic_set(&hard_iface->seqno, (uint32_t)random_seqno);

Hi Marek

Does this sequence number have any security relevance? Does it make
sense to use the TCP sequence number generation code?

      Andrew
