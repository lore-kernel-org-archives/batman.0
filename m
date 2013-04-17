Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 18 Apr 2013 00:37:13 +0800
References: <1365412636-26039-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1365412636-26039-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304180037.13749.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: change VID semantic in the
	BLA code
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

On Monday, April 08, 2013 17:17:16 Antonio Quartulli wrote:
> @@ -307,7 +307,7 @@ static void batadv_bla_send_claim(struct batadv_priv
> *bat_priv, uint8_t *mac, */
>                 memcpy(ethhdr->h_source, mac, ETH_ALEN);
>                 batadv_dbg(BATADV_DBG_BLA, bat_priv,
> -                          "bla_send_claim(): CLAIM %pM on vid %d\n", mac,
> vid); +                          "bla_send_claim(): CLAIM %pM on vid
> %u\n", mac, vid); break;
>         case BATADV_CLAIM_TYPE_UNCLAIM:
>                 /* unclaim frame
> @@ -315,7 +315,7 @@ static void batadv_bla_send_claim(struct batadv_priv
> *bat_priv, uint8_t *mac, */
>                 memcpy(hw_src, mac, ETH_ALEN);
>                 batadv_dbg(BATADV_DBG_BLA, bat_priv,
> -                          "bla_send_claim(): UNCLAIM %pM on vid %d\n",
> mac, +                          "bla_send_claim(): UNCLAIM %pM on vid
> %u\n", mac, vid);
>                 break;
>         case BATADV_CLAIM_TYPE_ANNOUNCE:
> @@ -324,7 +324,7 @@ static void batadv_bla_send_claim(struct batadv_priv
> *bat_priv, uint8_t *mac, */
>                 memcpy(hw_src, mac, ETH_ALEN);
>                 batadv_dbg(BATADV_DBG_BLA, bat_priv,
> -                          "bla_send_claim(): ANNOUNCE of %pM on vid %d\n",
> +                          "bla_send_claim(): ANNOUNCE of %pM on vid %u\n",

It should be %hu instead of %u for unsigned short.

Please make sure the printed vid does not contain the BATADV_VLAN_HAS_TAG 
mixed with the real vid.

Cheers,
Marek
