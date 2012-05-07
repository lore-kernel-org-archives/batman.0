Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <4457592.cWIfhQBfiK@sven-desktop.home.narfation.org>
References: <20120501200645.Horde.4u5hTaeWCxtPoDRF8GF27AA@beta.mail.sapo.pt>
	<4457592.cWIfhQBfiK@sven-desktop.home.narfation.org>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Mon, 7 May 2012 15:17:22 -0300
Message-ID: <CAHD-aqJn6YPVTam9LoLFVJjUZO3XXmsq+WkmeonRxAx8xwZ0iw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Batman-adv simple configuration example
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

On Tue, May 1, 2012 at 4:34 PM, Sven Eckelmann <sven@narfation.org> wrote:
> Some questions here can be answered by reading the documentation section under
> http://www.open-mesh.org/wiki/batman-adv/ - I will not mention it in this
> text. Please just check it out and read about things like "gateway support"
> and so on.
>
In case you're still fighting with this, I've just added to the
documentation some "simple configuration examples" that actually work.
http://www.open-mesh.org/wiki/batman-adv/Openwrt-config-examples

While the examples are a bit more complex since it handles up to 3
radios per node, you can understand the logic in there (how is the
bridge setup, and which interfaces are added to bat0) and scale it
down.

Hope that helps,

On Tue, May 1, 2012 at 4:06 PM, Pedro Nuno Costa Rodrigues
<pedroncr@sapo.pt> wrote:
> #### WLAN configuration
> config interface        wifi
>        option proto    static
>        option ifname   "wlan0"
>        option ipaddr   10.1.1.1              ########for router 2 is
> 10.1.1.2
>        option netmask  255.255.255.0
>        option mtu      1528

You should never assign an IP to an interface which forms part of a
bridge, or is managed by batman-adv (i.e. it was added to bat0)

that config snippet should only have ifname, mtu and proto(=none)

Cheers!
