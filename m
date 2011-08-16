Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 16 Aug 2011 17:30:02 +0200
References: <mailman.52.1312816695.1125.b.a.t.m.a.n@lists.open-mesh.org>
	<CAFevQmMWGcJhzKiZzDKOh_pMAq1CyMJrPh=FMpYAQh-wXZwH=g@mail.gmail.com>
	<CAFevQmMrBa20As8dAEoMCiWqUUm+xxS0=GGex5orx6=seKfmbQ@mail.gmail.com>
In-Reply-To: <CAFevQmMrBa20As8dAEoMCiWqUUm+xxS0=GGex5orx6=seKfmbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201108161730.03159.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] openwrt lib/batman-adv/config.sh
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


Hi,

> In this mail you can find batman-adv initscript updated to work in
> this way and the batman-adv library file that must be located in
> /lib/batman-adv/.

I liked the idea of having hotplug hooks to restart the batman-adv 
configuration automatically. 
Generally, the scripts look good to me. You also changed its "coding style", 
e.g. $var -> ${var}. This does not look very OpenWRT-ish, therefore I would 
prefer keeping the current style. Any objections ?

Regards,
Marek
