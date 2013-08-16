Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 16 Aug 2013 12:05:49 +0800
References: <1376376232-2178-1-git-send-email-ordex@autistici.org>
 <1376376232-2178-4-git-send-email-ordex@autistici.org>
In-Reply-To: <1376376232-2178-4-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308161205.49424.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/9] batman-adv: add bat_orig_print
	function API
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

On Tuesday, August 13, 2013 14:43:46 Antonio Quartulli wrote:
> @@ -991,6 +991,7 @@ struct batadv_forw_packet {
>   * @bat_primary_iface_set: called when primary interface is selected /
> changed * @bat_ogm_schedule: prepare a new outgoing OGM for the send queue
> * @bat_ogm_emit: send scheduled OGM
> + * @bat_orig_print: print the originator table
>   */
>  struct batadv_algo_ops {
>         struct hlist_node list;
> @@ -1001,6 +1002,8 @@ struct batadv_algo_ops {
>         void (*bat_primary_iface_set)(struct batadv_hard_iface
> *hard_iface); void (*bat_ogm_schedule)(struct batadv_hard_iface
> *hard_iface); void (*bat_ogm_emit)(struct batadv_forw_packet
> *forw_packet); +       /* orig_node handling API */
> +       void (*bat_orig_print)(struct batadv_priv *priv, struct seq_file
> *seq); };

How about adding the info somewhere that this callback is optional ?

Cheers,
Marek
