Return-Path: <sergei.shtylyov@cogentembedded.com>
Message-ID: <536E8E96.7090401@cogentembedded.com>
Date: Sun, 11 May 2014 00:39:50 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
References: <1399736110-22333-1-git-send-email-antonio@meshcoding.com>
 <1399736110-22333-5-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1399736110-22333-5-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix removing neigh_ifinfo
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
To: Antonio Quartulli <antonio@meshcoding.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, Simon Wunderlich <simon@open-mesh.com>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

Hello.

On 05/10/2014 07:35 PM, Antonio Quartulli wrote:

> From: Simon Wunderlich <simon@open-mesh.com>

> When an interface is removed separately, all neighbors need to be
> checked if they have a neigh_ifinfo structure for that particular
> interface. If that is the case, remove that ifinfo so any references to
> a hard interface can be freed.

> This is a regression introduced by
> 89652331c00f43574515059ecbf262d26d885717
> ("batman-adv: split tq information in neigh_node struct")

> Reported-by: Antonio Quartulli <antonio@open-mesh.com>
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>   net/batman-adv/originator.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)

> diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
> index 8104c3c..427c07d 100644
> --- a/net/batman-adv/originator.c
> +++ b/net/batman-adv/originator.c
> @@ -707,6 +707,47 @@ free_orig_node:
>   }
>
>   /**
> + * batadv_purge_neigh_ifinfo - purge obsolete ifinfo entries from neighbor
> + * @bat_priv: the bat priv with all the soft interface information
> + * @neigh_node: orig node which is to be checked

    The corresponding parameter is called just 'neigh'.

> + */
> +static void
> +batadv_purge_neigh_ifinfo(struct batadv_priv *bat_priv,
> +			  struct batadv_neigh_node *neigh)
[...]

WBR, Sergei

