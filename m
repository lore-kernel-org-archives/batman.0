Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 10 May 2013 00:09:11 +0800
References: <1368109687-3780-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1368109687-3780-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305100009.11734.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next 1/2] batman-adv: use VLAN_VID_MASK
	instead of BATADV_VID_MASK
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

On Thursday, May 09, 2013 22:28:06 Antonio Quartulli wrote:
> --- a/main.h
> +++ b/main.h
> @@ -172,8 +172,6 @@ enum batadv_vlan_flags {
>         BATADV_VLAN_HAS_TAG     = BIT(15),
>  };
>  
> -/* mask needed to extract the vlan ID (12bits) from a 16bits variable */
> -#define BATADV_VID_MASK        0x0FFF
>  #define BATADV_PRINT_VID(vid) (vid & BATADV_VLAN_HAS_TAG ? \
>                                (int)(vid & BATADV_VID_MASK) : -1)

The last user should remove the define otherwise the code won't compile.

Cheers,
Marek
