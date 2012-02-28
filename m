Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 28 Feb 2012 16:21:13 +0800
References: <CAFevQmN-RVQookzL-M9_G0xGKJJvAp5QXCqRfwf+X8dvWM9-Pw@mail.gmail.com>
	<201202281344.35368.lindner_marek@yahoo.de>
	<CAFevQmN-DuWC=zmfj3S8yLH9tE3cVZkZVJRvHtOvrzCTGqpdtA@mail.gmail.com>
In-Reply-To: <CAFevQmN-DuWC=zmfj3S8yLH9tE3cVZkZVJRvHtOvrzCTGqpdtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201202281621.13484.lindner_marek@yahoo.de>
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

On Tuesday, February 28, 2012 16:06:44 Filippo Sallemi wrote:
> Ok but i' dont wait for this. Hotplug was called when a new interface
> is added. msh0 is no a real interface so when wlan0 is added I sleep 4
> seconds and check if wlan0 is part o batman-adv interfaces.

Sorry, I don't understand. What do you mean with "msh0" is not a real 
interface ? The part about wlan0 I understand - the question was what happens 
if the interface is not named wlan0?

This could be your wireless config file:
config 'wifi-iface'
        option 'device' 'radio0'
        option 'ifname' 'msh0'
        option 'mode' 'adhoc'
        option 'ssid' 'mesh'

Cheers,
Marek
