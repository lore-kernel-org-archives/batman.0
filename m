Return-Path: <sergei.shtylyov@cogentembedded.com>
References: <1439310948-32426-1-git-send-email-antonio@meshcoding.com>
 <1439310948-32426-4-git-send-email-antonio@meshcoding.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55CA4ED2.9070207@cogentembedded.com>
Date: Tue, 11 Aug 2015 22:36:50 +0300
MIME-Version: 1.0
In-Reply-To: <1439310948-32426-4-git-send-email-antonio@meshcoding.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: Make DAT capability
	changes atomic
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

Hello.

On 08/11/2015 07:35 PM, Antonio Quartulli wrote:

> From: Linus Lüssing <linus.luessing@c0d3.blue>

> Bitwise OR/AND assignments in C aren't guaranteed to be atomic. One
> OGM handler might undo the set/clear of a specific bit from another
> handler run in between.

> Fix this by using the atomic set_bit()/clear_bit()/test_bit() functions.

> Fixes: 17cf0ea455f1 ("batman-adv: tvlv - add distributed arp table container")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>   net/batman-adv/distributed-arp-table.c | 7 ++++---
>   net/batman-adv/types.h                 | 4 ++--
>   2 files changed, 6 insertions(+), 5 deletions(-)

> diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
> index fb54e6a..244dcf6 100644
> --- a/net/batman-adv/distributed-arp-table.c
> +++ b/net/batman-adv/distributed-arp-table.c
[...]
> @@ -453,7 +454,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
>   	int j;
>
>   	/* check if orig node candidate is running DAT */
> -	if (!(candidate->capabilities & BATADV_ORIG_CAPA_HAS_DAT))
> +	if (!(test_bit(BATADV_ORIG_CAPA_HAS_DAT, &candidate->capabilities)))

    () around the tst_bit() call not needed.

[...]

MBR, Sergei

