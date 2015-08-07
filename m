Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 7 Aug 2015 18:16:22 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150807161622.GB2893@odroid>
References: <2ce4491cf3eb01922d0fec97147a1533cca30c41.1435170868.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ce4491cf3eb01922d0fec97147a1533cca30c41.1435170868.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: add generic netlink query API
 to replace debugfs files
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

Hi Matthias,

here at the Wireless BattleMesh we finally had the chance to get
some initial discussions on your patch going. For the start a few
comprehension questions came up:


On Wed, Jun 24, 2015 at 08:34:28PM +0200, Matthias Schiffer wrote:
> * As batman-adv uses single_open, the whole content of the originators/
>   transglobal files must fit into a single buffer; in large batman-adv
>   networks this often fails (as an order-5 allocation or even more would be
>   necessary)
> * When originators or transglobal aren't just used for debugging, they are
>   first converted to text, and then parsed again in userspace by tools like
>   alfred/batadv-vis. Sending MAC address lists from the kernel to userspace
>   as text makes the buffer size issue even worse.

These two points can be addressed through debugfs too, for
instance using sequential debugfs writes, right? (In fact IIRC you
had started with that approach until you got the feedback from
Gregk, right?)

Can you elaborate a little more on the "order-5 allocation"?
What amount of free RAM did the machines have where we observed
Out-of-Memory kernel panics upon debugfs access? Can you give some
numbers / calculations why we ended up with several Megabytes
memory allocations on debugfs access?


The debugfs race conditions Gregk and you talked about are on
adding/removing debugfs files, right? Are there any known race
conditions on simple reads/writes in the abscene of removing
debugfs files?


Since you've had a look at both the netlink and sequential debugfs
approach already, can you give some estimation about the
complexity or rough number of lines of code to change for the
sequential debugfs approach?

One thought that popped up here was, whether it'd make sense to
first "fix" the debugfs approach to the extent possible with a
couple of lines instead of 800+ lines to get rid of the issues
we frequently observe. And then merge a complete fix but bigger
patchset implementing netlink support with a more thorough review
and discussions on what we'd need for its API now and upcoming
features.

Cheers, Linus
