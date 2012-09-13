Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120730103117.GA28562@pandem0nium>
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
 <20120708100956.GA10210@pandem0nium>
 <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
 <20120725203425.GB11999@pandem0nium>
 <CAHD-aqK68-74CHsL4FUhAXdxJcbJjvdJcGEh6z9XQt5zXvvFGw@mail.gmail.com>
 <20120730103117.GA28562@pandem0nium>
From: Gui Iribarren <gui@altermundi.net>
Date: Thu, 13 Sep 2012 13:10:14 -0300
Message-ID: <CAHD-aqK5ap6xqfCi+x4RtUxBryRmG4qaQSeDTiSYUDUjASuUbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
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

On Mon, Jul 30, 2012 at 7:31 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> Hello Guido,
>
> Thanks for working that out. I've just tried out VLANs on Ethernet with
> BATMAN myself, and it worked well here - so I can't reproduce it by simply
> using VLANs.
>
> Another cause of the fault may be the VLAN stuff in OpenWRT, as this is not
> a "real" VLAN but just a way to address the ports on your box. I have not
> much experience with that, but I've heard funny things about it. ;) Have you
> tried changing the VLAN config? E.g. changing ports '0t 2t' for eth0.2 to
> '0t 2' (to remove tagging)?
>
> Do you have the same problem on other types of devices? (Maybe the internal
> switch is acting weird)

Sorry for necrotizing the thread, but i just wanted to leave a quick
note in case anyone else stumps on this.

you were right once again Simon,
TP-Link TL-MR3220 (and MR3420) has, in fact, "true" VLAN capability in
the hardware switch, but unfortunately that capability has
limitations.

notably, it can't send tagged and untagged frames through the same
port, and falling back to software tagging doesn't give meaningful
results either (switch is broken: packets aren't forwarded between
ports)

I just dumped the whole vlan thing altogether on this hardware.

Thanks as always!

Gui
