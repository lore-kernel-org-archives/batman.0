Return-Path: <abolletta@netter.io>
MIME-Version: 1.0
References: <CADJ1cURtCsWdy6rovfgb_XPhbsTc5epCv3yLgRCLcOVjfNSFdw@mail.gmail.com>
 <2850909.jKhAPPOaAE@ripper>
In-Reply-To: <2850909.jKhAPPOaAE@ripper>
From: Alessandro Bolletta <abolletta@netter.io>
Date: Fri, 11 Sep 2020 14:19:59 +0200
Message-ID: <CADJ1cUSum9bHHBZB3gKdXukoqqDxk_f2nO38YKEDjvyHs0=qXA@mail.gmail.com>
Subject: Re: Passing VID-aware ethernet frames on plain batX interfaces
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

So you mean that it is not feasible to create a (single) linux network
interface that let me send traffic on the batman-adv network in an
untagged or tagged way, though the same interface I mean?

Il giorno ven 11 set 2020 alle ore 14:01 Sven Eckelmann
<sven@narfation.org> ha scritto:
>
> On Friday, 11 September 2020 12:48:52 CEST Alessandro Bolletta wrote:
> > if I pass tagged ethernet traffic inside a bat0 interface (without
> > creating an alias that uses the linux vlan stack for transparent
> > tagging), is this being allowed by batman-adv?
>
> Not since batman-adv was made VLAN aware.
>
> Kind regards,
>         Sven
