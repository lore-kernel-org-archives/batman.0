Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 28 Apr 2013 00:46:11 +0800
References: <1367078393-5646-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1367078393-5646-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304280046.11511.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: properly handle Network
	Ordered variables
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

On Saturday, April 27, 2013 23:59:53 Antonio Quartulli wrote:
> --- a/gateway_common.c
> +++ b/gateway_common.c
> @@ -202,8 +202,8 @@ static void batadv_gw_tvlv_ogm_handler_v1(struct
> batadv_priv *bat_priv, gateway.bandwidth_up = 0;
>         } else {
>                 gateway_ptr = tvlv_value;
> -               gateway.bandwidth_down =
> ntohl(gateway_ptr->bandwidth_down); -               gateway.bandwidth_up =
> ntohl(gateway_ptr->bandwidth_up); +               gateway.bandwidth_down =
> gateway_ptr->bandwidth_down; +               gateway.bandwidth_up =
> gateway_ptr->bandwidth_up;
>                 if ((gateway.bandwidth_down == 0) ||
>                     (gateway.bandwidth_up == 0)) {
>                         gateway.bandwidth_down = 0;

There is no bug. The original code converted the incoming big endian value to 
host endian (whatever that is) and works with that value internally. Now that 
you reversed the logic you have to adjust *all* occurences. Especially, when 
the tvlv bandwidth value is copied into a gw_node struct. You can use sparse 
to help you find the sections in the code by changing gw_node to be32 as well.

However, I am not convinced that converting the values every single time we 
access the variable is the optimal approach.

Cheers,
Marek

