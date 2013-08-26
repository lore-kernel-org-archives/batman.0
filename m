Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Aug 2013 09:49:42 +0800
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-6-git-send-email-ordex@autistici.org>
In-Reply-To: <1376376232-2178-6-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308260949.42642.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 5/9] batman-adv: add
	bat_metric_is_equiv_or_better API function
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

On Tuesday, August 13, 2013 14:43:48 Antonio Quartulli wrote:
> +static bool batadv_iv_ogm_metric_is_eob(uint32_t metric, uint32_t
> new_metric) +{
> +	return (metric - new_metric < BATADV_TQ_SIMILARITY_THRESHOLD);
> +}
> +

Kernel doc ?


> diff --git a/types.h b/types.h
> index 2b5b1c1..7a12eef 100644
> --- a/types.h
> +++ b/types.h
> @@ -991,6 +991,8 @@ struct batadv_forw_packet {
>   * @bat_primary_iface_set: called when primary interface is selected /
> changed * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
> * @bat_ogm_emit: send scheduled OGM
> + * @bat_metric_is_equiv_or_better: check if new_metric is good enough to
> be + *  comparable with metric
>   * @bat_orig_print: print the originator table
>   */

How about this description: 
Returns true if new_metric is equally good or better than metric.

Actually, you could call the parameters metricA and metricB or something along 
these lines.

Cheers,
Marek

