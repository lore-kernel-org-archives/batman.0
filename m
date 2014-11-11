Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 11 Nov 2014 15:15:20 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20141111141520.GJ799@odroid>
References: <5458F780.10707@solvare.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5458F780.10707@solvare.se>
Subject: Re: [B.A.T.M.A.N.] Completely out of context
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

On Tue, Nov 04, 2014 at 04:57:52PM +0100, Christian Huldt wrote:
> Error handling is said to be 90% of good code, maybe a separate error
> handling daemon that could be chosen as per the device?

Not sure you're asking on the right mailing list for that.
batman-adv is a kernel module. In networking. With the informel
policy of being transparent, staying out of a users sight as much
as possible, with an assessable amount of configuration options.
So I believe batman-adv is one of the worst pieces of
software pieces you could have chosen for such an argument ;).

> 
> You guys deliver so much changes (which is good) but I try to consider
> the consequences, as in
> for-profit-companies-find-it-cheeper-to-give-the-developers-better-computers-than-a-rise
> which usually equates to bloatware that needs and uses so much more
> resources than the actual task requires...

Ehm. batman-adv is written in C, capable of handling Gigabit links
on tiny embedded devices... not Java or such.
