Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Jul 2012 12:57:23 +0200
References: <CAKLmikNDZQL2bDWYMMUHcHA5WTMj2Ou0yFiZ7wg134OHFQZWrw@mail.gmail.com>
 <201207161202.45306.lindner_marek@yahoo.de>
 <CAKLmikOuvdvdzV+UD-qr=FSKA0s+1yMHcdYr4GU6S4VzvqcMcw@mail.gmail.com>
In-Reply-To: <CAKLmikOuvdvdzV+UD-qr=FSKA0s+1yMHcdYr4GU6S4VzvqcMcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201207171257.23627.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Route selection over VPN links
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

On Tuesday, July 17, 2012 08:36:30 Mitar wrote:
> > the later versions of batman support a routing protocol plugin structure
> > (check bat_iv_ogm.c to get an idea). Using bandwidth information for the
> > routing decision is a nice idea but how does your concept look like ? How
> > should the routing logic look like ?
> 
> I thought I explained it enough. So for now, I would just go with only
> measuring latency (I don't know what would be the best way to measure
> this, though). If I have the latency (and this could be only one hop),
> I would do:
> 
> * if packet loss is different, choose the one with lower packet loss
> * if packet loss is the same, choose the one with lower latency in the next
> hop

I was more curious about the bandwidth routing than the latency stuff. The 
current routing algorithm already takes latency into account. An alternate 
path always need to be better than the current path. If both paths are equal 
the faster packets win the race.

Regards,
Marek
