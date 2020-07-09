Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Thu, 9 Jul 2020 22:33:44 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Batman_V Originator Loop Issue
Message-ID: <20200709203344.GB2269@otheros>
References: <5716273.fDpRzsxG9E@prime>
 <20200708152649.1176.81859@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708152649.1176.81859@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Luke,

On Wed, Jul 08, 2020 at 03:26:49PM -0000, lavincent15@gmail.com wrote:
> Simon,
> 
> When I enable DAT on all of my nodes, the network breaks down. With DAT disabled on all the nodes, the network works fine.
> 
> As I develop my project, I would like to take advantage of the mesh wide ARP caching feature DAT. Is there any way I can fix things to where DAT will work on my network?
> 
> Thanks,
> Luke

Would it be possible for you to try an older version of
batman-adv, like v2019.0? There were a few new feature additions
for DAT after that one.

Btw. did you also try disabling aggregation with your batman-adv
2020.1 version? That didn't make a difference, right?

(disabling aggregation for BATMAN_V in v2019.0 won't make a difference
as it wasn't implemented there yet, so if you could try that with
2020.1 would be great)

Regards, Linus
