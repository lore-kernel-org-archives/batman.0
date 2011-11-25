Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 25 Nov 2011 09:08:47 +0800
References: <1322044544-15153-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1322044544-15153-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111250908.48180.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add biggest_unsigned_int(x)
	macro
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

On Wednesday, November 23, 2011 18:35:44 Antonio Quartulli wrote:
> in case of dynamic type variable, it could be needed to compute at compile
> time its maximal value. This macro helps in doing that for unsigned
> integer types
> 
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  main.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/main.h b/main.h
> index 464439f..3c58235 100644
> --- a/main.h
> +++ b/main.h
> @@ -210,6 +210,9 @@ static inline int compare_eth(const void *data1, const
> void *data2) /* Returns the smallest signed integer in two's complement
> with the sizeof x */ #define smallest_signed_int(x) (1u << (7u + 8u *
> (sizeof(x) - 1u))) 
> +/* Returns the biggest unsigned integer with the sizeof x */
> +#define biggest_unsigned_int(x) (~(x)0)
> +

The final conclusion of the IRC discussion might have escaped me but wasn't 
there supposed to be a cast somewhere ?

Regards,
Marek
