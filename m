Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 30 Oct 2011 22:36:07 +0100
References: <mailman.52.1312816695.1125.b.a.t.m.a.n@lists.open-mesh.org>
	<CAFevQmMJiKnWwa9miU+eFe4WsGRCTj_H6Y+L91jqhM41G0wW4g@mail.gmail.com>
	<CAFevQmP7Qu5iMi6nHG3WJdbXFAEQej9Ro7W9aEkLxg4YhSX-wQ@mail.gmail.com>
In-Reply-To: <CAFevQmP7Qu5iMi6nHG3WJdbXFAEQej9Ro7W9aEkLxg4YhSX-wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201110302236.07940.lindner_marek@yahoo.de>
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


Filippo,

> I've writed a hotplug.d script that readd interfaces that are present
> in every bat definition of batman-adv uci file when network restart or
>  an interface come up.
> This script must be placed in /etc/hotplug.d/net/
> 
> P.S. for Marek you don't need to split /etc/init.d/batman-adv function
> in a separate file such the previous emails.

I am little bit late with your script but finally got around looking at it. 
Why don't we use the functions from /lib/batman-adv/config.sh as we previously 
discussed ? Any unexpected side effects ?

Regards,
Marek
