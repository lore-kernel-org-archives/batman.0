Return-Path: <abolletta@netter.io>
MIME-Version: 1.0
References: <CADJ1cUTq=Bpj9SQdS5Y6aXKcPR9XqkxKn_Sj5sRMmN1R=qX_2g@mail.gmail.com>
 <17582207.Wjj8Q8S2kB@ripper>
In-Reply-To: <17582207.Wjj8Q8S2kB@ripper>
From: Alessandro Bolletta <abolletta@netter.io>
Date: Wed, 9 Sep 2020 10:20:20 +0200
Message-ID: <CADJ1cUSNtDrR-C-L7MHXF3JohbkmBbQBsFzBvBxE2WntUd9Yqw@mail.gmail.com>
Subject: Re: Running multiple batman-adv namespaces on the same broadcast domain
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

Thank you for your tip.

Just one more info: is there an hard limit for the number of "bat"
interfaces on the same host?
Moreover, is the multiple batX namespaces a scenario that it is
supposed to work fine, is it well tested or it still does need some
love?

Il giorno mar 8 set 2020 alle ore 13:28 Sven Eckelmann
<sven@narfation.org> ha scritto:
>
> On Tuesday, 8 September 2020 13:23:32 CEST Alessandro Bolletta wrote:
> > i'm trying to reproduce a PoC where i'm running multiple batman-adv
> > instances(eg. bat0, bat1, batX) on the same broadcast domain.
> [...]
> > Is this kind of scenario supported?
>
> No, you need something which implements separation of top of ethernet to avoid
> that bat0/bat1/.../batX see each other. E.g. VLAN, VXLAN, ...
>
> Kind regards,
>         Sven
