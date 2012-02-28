Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Feb 2012 13:44:34 +0800
References: <CAFevQmN-RVQookzL-M9_G0xGKJJvAp5QXCqRfwf+X8dvWM9-Pw@mail.gmail.com>
	<201202271611.19158.lindner_marek@yahoo.de>
	<CAFevQmOO+kmXqyt769tdk5j4VY+6dJW9TGDV45rvN6HyT2Ps9g@mail.gmail.com>
In-Reply-To: <CAFevQmOO+kmXqyt769tdk5j4VY+6dJW9TGDV45rvN6HyT2Ps9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201202281344.35368.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Fwd: /lib/batman-adv/config.sh
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

On Monday, February 27, 2012 20:42:58 Filippo Sallemi wrote:
> Il 27 febbraio 2012 09:11, Marek Lindner <lindner_marek@yahoo.de> ha 
scritto:
> > On Monday, February 27, 2012 01:49:44 Filippo Sallemi wrote:
> >> Ok in this email my proposal patch.
> >> I've to sleep 4s if you have an ap + adhoc vifs.
> >> 
> >> [ "$(echo $interface | awk '$0 ~ /^wlan[0-9]*/')" ] && sleep 4s
> >> 
> >> For convenience I sleep only if an wlan was triggered. If you have
> >> only one interface in adhoc mode per radio 3 seconds are enought.
> > 
> > What if somebody calls his interfaces in a different way ? As you know
> > the name can freely be chosen.
> 
> You can chose another name instead of wlan0 wlan0-1 wlan1 wlan1-1 eth0 eth1
> ...? 

Yes, you can. I thought you were doing it to after I saw your config:

config 'mesh' 'mesh'
       option 'interfaces' 'msh0'

msh0 does not look like wlanX at all, wouldn't you say so ?

Cheers,
Marek
