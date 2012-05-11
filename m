Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120510231649.Horde.mtJYKOanEAJPrD5R7pqW_NA@beta.mail.sapo.pt>
References: <20120510231649.Horde.mtJYKOanEAJPrD5R7pqW_NA@beta.mail.sapo.pt>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Fri, 11 May 2012 10:07:07 -0300
Message-ID: <CAHD-aqKH+SFfTzyEsfN3YJwrELATVtNT_odNYxm-Bdpr21KsxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Fwd: Batman-adv simple configuration example
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

On Thu, May 10, 2012 at 7:16 PM, Pedro Nuno Costa Rodrigues
<pedroncr@sapo.pt> wrote:
>
> (the problem is probably the definition who is the master -IP distribution
> and so on...)(i used the "option force 1 in the dhcp configuration file, but
> didn't worked...) if we start the client first it will not be possible to
> access the internet, supposed the ISP is connected with the "server"
> router... the ad-hoc mode and the mesh network works the same way (works
> fine)...

You probably want to use

config dhcp lan
  option "ignore" "1"

in client router,

instead of using "option force 1" in server router

http://wiki.openwrt.org/doc/uci/dhcp#dhcp.pools

>
> is a issue to study (yes i know that is a openwrt problem, and there are a
> bunch of openwrt problems here).My gold is to contribute with something
> here, and to get my job done as well.

Of all the problems I bumped into, just a couple turned out to be
"openwrt problems", and because of using Attitude Adjustment.
Most of the issues were my fault, of not reading the documentation
thoroughly, or not understanding it :)

Regards,

Guido
