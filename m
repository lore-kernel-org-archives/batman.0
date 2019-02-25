Return-Path: <umut.deniz@gmail.com>
MIME-Version: 1.0
References: <CAHh66V8N6KCqGdxnMQpHTaqjLbfMwWyGrRvjZY+P20W3-UF4Hw@mail.gmail.com>
 <CAHh66V-79d--F=d-Rx+af6Vffm09bs=-EOTiK4dtB3+r-E91Ag@mail.gmail.com>
 <1711580.CLzo8a4Rc7@sven-edge>
In-Reply-To: <1711580.CLzo8a4Rc7@sven-edge>
From: umut deniz <umut.deniz@gmail.com>
Date: Mon, 25 Feb 2019 17:06:21 +0300
Message-ID: <CAHh66V8VNnbZCHWOi9ppnKbqfo1PbqVV3vSP1wbyROidBpTRCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hello Sven,

Thank your for your swift reply and advice. As you said TI supports limited
number of peers with its driver and hardware in mesh mode. According to TI
documentation it is 32 nodes. The question bogging my mind is how could the
< :#iw dev adhoc0 station dump > command return 6 active and plink established
nodes (with inactive times around 80ms) while batman-adv's last-seen is
increasing till timeout occurs on all neighbors and after timeout iw station
dump still reports the same active stations (with inactive times around 80ms).
Am I missing something to debug or a log to look in to or a configuration
tied with batman-adv needed to be made.

Thank you and best regards

On Mon, Feb 25, 2019 at 12:22 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Sunday, 24 February 2019 21:48:18 CET umut deniz wrote:
> > my current platform is ti's beagleboneblack wireless board running openwrt
> > distribution (the required bbbw dtb and wl1835 driver firmware applied) with
> > batman enabled and configured. with this high level description of the
> > components i am able to build a mesh network 6 nodes (i.e. bbbw cards) but as
> > soon as i introduce a 7th card into the network batman mesh becomes unresponsive
> > as the last seen times start to increase and finally, after 200 seconds all the
> > nodes drops from the originator and neighbor tables which could be inspected
> > with < :#batctl o> and < :#batctl n> commands respectively. all the cards are on
> > the same table and well powered.
> [...]
> > i researched for a while for the cause with no avail. i would appreciate any
> > kind of help to point me to the right direction to solve this.
>
> Please don't use things like wl1835 when building larger meshes. It is known
> that these kind of  devices only support a very limited amount of peers and
> are most of the time only (more or less) stable in management mode (client).
> And afaik, the wlcore driver (like other TI wirelss drivers) is also orphaned.
>
> If you're wifi link/driver doesn't work, batman-adv can also do nothing to fix
> it.
>
> Rule of thumb: If it is a USB/SDIO wifi device, start waving your hands in the
> air, scream and run away. This strategy is also helpful in other wifi related
> situations.
>
> Kind regards,
>         Sven
