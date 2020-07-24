Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Fri, 24 Jul 2020 22:23:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Batman_V Originator Loop Issue
Message-ID: <20200724202356.GB2357@otheros>
References: <20200724100249.GA2357@otheros>
 <20200724150033.30286.98915@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724150033.30286.98915@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: lavincent15@gmail.com, b.a.t.m.a.n@lists.open-mesh.org

On Fri, Jul 24, 2020 at 03:00:33PM -0000, lavincent15@gmail.com wrote:
> Linus,
> 
> I have a working network with aggregated_ogms enabled and DAT disabled.I just tried disabling aggregated_ogms and the network continued to function properly. I then enabled DAT and the network continued to function properly. So it seems I just cannot have aggregated_ogms and DAT enabled at the same time.
> 
> Thanks,
> Luke


Hi Luke,

Awesome, great news, that intensifies the suspicion that the issue
in the aggregation code is the main cause.

Would it be possible for you to try the patch from the ticket and
if this allows you to enable both DAT and aggregation?

https://www.open-mesh.org/issues/413
=> https://git.open-mesh.org/batman-adv.git/commit/0115502eab54a80f2c05884efce6ee164ed3cd9f

Cheers, Linus
