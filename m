Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 18 Jul 2012 22:06:00 +0200
References: <CAKLmikNDZQL2bDWYMMUHcHA5WTMj2Ou0yFiZ7wg134OHFQZWrw@mail.gmail.com>
 <201207171257.23627.lindner_marek@yahoo.de>
 <CAKLmikPKq3Ys8L=wtc08-GBeX04huu85OYJR17MByqOBGbi6sw@mail.gmail.com>
In-Reply-To: <CAKLmikPKq3Ys8L=wtc08-GBeX04huu85OYJR17MByqOBGbi6sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201207182206.00711.lindner_marek@yahoo.de>
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

On Tuesday, July 17, 2012 20:06:27 Mitar wrote:
> > I was more curious about the bandwidth routing than the latency stuff.
> > The current routing algorithm already takes latency into account. An
> > alternate path always need to be better than the current path. If both
> > paths are equal the faster packets win the race.
> 
> Hm. This happens only first time, it does not really change the route
> latter on, if chosen path latency increases and becomes worse than the
> second path, but packet loss stays the same (zero). Or it does?

No, it always works. The slower route needs to be better than the faster 
route. If there is a new "faster" route the same applies. Just give it a try 
and see for yourself.


Cheers,
Marek
