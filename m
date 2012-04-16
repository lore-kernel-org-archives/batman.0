Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201204161258.04262.lindner_marek@yahoo.de>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<201204161237.37008.lindner_marek@yahoo.de>
	<CAKLmikMRRkrvB3Kgga51hJ=GygEto_KqLCp9TwTPseyK4gJsOw@mail.gmail.com>
	<201204161258.04262.lindner_marek@yahoo.de>
Date: Mon, 16 Apr 2012 14:32:09 +0200
Message-ID: <CAKLmikPWjXYVqQkJLK=j9DB_1+cNjLsrZ3j9kHGf6SiBbusOvw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

Hi!

On Mon, Apr 16, 2012 at 12:58 PM, Marek Lindner <lindner_marek@yahoo.de> wrote:
> If you already have a shell script uevent definitely is the way to go. It is
> far easier to script than netlink.

Yes, but are there uevent events for node reachable/unreachable?

> How does your logic handle network splits / join ? Do you have the source
> somewhere ?

Our current logic is very simple: if route to 0.0.0.0 disappears,
display to the user error message through splash screen ("sorry, node
is separated from the rest of the mesh" message) when user tries to
access external IPs. When it comes back, return to normal behavior.

I am not sure what you mean by splits / joins. Yes, source is
available. But I am not sure if this is what you had in mind?

I was just saying that route flapping (on/off) can be dealt with some
aggregation of events on a consumer side. (But I am now unsure, maybe
we are doing this already on the plugin side.)

For olsrd plugin:

http://dev.wlan-si.net/browser/firmware/packages/opkg/net/olsrd/plugins/actions

> You could even connect your routing daemon to the uevents mentioned
> above.

Are those uevents already available? Do we know of any existing
routing protocol being capable of using them?


Mitar
