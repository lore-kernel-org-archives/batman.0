Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 12 Feb 2012 02:30:16 +0800
References: <1807712.xKAsDcUsSn@g10h4cklab> <1909726.3aAO7925oA@g10h4cklab>
	<1511503.TNKGsptLL7@g10h4cklab>
In-Reply-To: <1511503.TNKGsptLL7@g10h4cklab>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201202120230.16288.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman openwrt
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

On Sunday, February 12, 2012 02:15:45 Gioacchino Mazzurco wrote:
> I am working on a patch but i have some question
> 
> here:
> ./files/etc/hotplug.d/net/99-batman-adv:9:              [ -d
> /sys/class/net/$INTERFACE/mesh/ ] && config_bat "$INTERFACE"
> 
> shouldn't it be bat_config intead of config_bat?
> 
> i have tried to find config_bat definition but without success :|

You are right - this is a bug. Filippo already sent me a patch for it but I 
had a few questions regarding other changes in his patch. So, I did not apply 
it yet.

Cheers,
Marek
