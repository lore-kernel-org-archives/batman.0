Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Nov 2012 01:12:16 +0800
References: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
In-Reply-To: <CAHD-aqKfNck0Z4Zqw_MJYzTFN=dEVp=Xxu6SfgRSwtOeCpPXnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201211260112.16957.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv boot setup scheme on OpenWRT
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


Hi,

> AFAICU, currently there's a /etc/hotplug.d/net/99-batman-adv script
> which tries to configure both bat0 , and any interfaces coming up that
> might have to be included there. Problem is, hotplug.d/net scripts are
> called when interface is "added" but not necessarilly brought up yet.
> So there's a "sleep 3s" that works in most cases as a window for slow
> hardware bring up the interface.

I like the idea of using the iface "ifup" hook for adding hard-interfaces. On 
the other hand I opt for keeping the net "remove" hook for removing them 
because batman-adv handles these ifup/ifdown blips internally. If you adjust 
that part I'll will merge your patch.

Excellent catch!

Cheers,
Marek
