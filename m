Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Feb 2012 22:27:09 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<1328830902-11574-9-git-send-email-ordex@autistici.org>
In-Reply-To: <1328830902-11574-9-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202122227.09751.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 8/9] batman-adv: add UNICAST_4ADDR
	packet type
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

On Friday, February 10, 2012 07:41:41 Antonio Quartulli wrote:
> +enum bat_subtype {
> +       BAT_P_DATA       = 0x01,
> +       BAT_P_DHT_GET    = 0x02,
> +       BAT_P_DHT_PUT    = 0x03
>  };

One more before I shut up and wait for the next patchset.  ;-)

BAT_P_DHT_GET / BAT_P_DHT_PUT isn't used anywhere.

Regards,
Marek
