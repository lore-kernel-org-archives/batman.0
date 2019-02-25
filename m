Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 25 Feb 2019 17:00:46 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190225160046.GD1761@otheros>
References: <CAHh66V8N6KCqGdxnMQpHTaqjLbfMwWyGrRvjZY+P20W3-UF4Hw@mail.gmail.com>
 <CAHh66V-79d--F=d-Rx+af6Vffm09bs=-EOTiK4dtB3+r-E91Ag@mail.gmail.com>
 <1711580.CLzo8a4Rc7@sven-edge>
 <CAHh66V8VNnbZCHWOi9ppnKbqfo1PbqVV3vSP1wbyROidBpTRCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHh66V8VNnbZCHWOi9ppnKbqfo1PbqVV3vSP1wbyROidBpTRCw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Fwd: nodes start disappearing after a certain
 node count
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

On Mon, Feb 25, 2019 at 05:06:21PM +0300, umut deniz wrote:
> Hello Sven,
> 
> Thank your for your swift reply and advice. As you said TI supports limited
> number of peers with its driver and hardware in mesh mode. According to TI
> documentation it is 32 nodes. The question bogging my mind is how could the
> < :#iw dev adhoc0 station dump > command return 6 active and plink established
> nodes (with inactive times around 80ms) while batman-adv's last-seen is
> increasing till timeout occurs on all neighbors and after timeout iw station
> dump still reports the same active stations (with inactive times around 80ms).
> Am I missing something to debug or a log to look in to or a configuration
> tied with batman-adv needed to be made.

Disable batman-adv and try a broadcast ping like "ping6 ff02::1%adhoc0" and
unicast ones. If that works with 6 nodes, but not with 7 ones then you
know it's not batman-adv's fault.

Regards, Linus
