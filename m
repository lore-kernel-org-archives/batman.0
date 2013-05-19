Return-Path: <ff@jluehr.de>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1085)
From: =?iso-8859-1?Q?Jan_L=FChr?= <ff@jluehr.de>
Date: Sun, 19 May 2013 10:52:01 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7180917-EB69-44B0-99A6-1F81BC911125@jluehr.de>
Subject: [B.A.T.M.A.N.] On compat version 15 in the Freifunk-KBU network
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
Cc: =?iso-8859-1?Q?Bonn_und_Umgebung_Allgemeine_Mailingliste_zum_Fre?= =?iso-8859-1?Q?ifunk_K=F6ln?= <freifunk-bonn@lists.bonn.freifunk.net>, =?iso-8859-1?Q?Freifunk_L=FCbeck?= <freifunk.luebeck@asta.uni-luebeck.de>

Hello folks,

I'd like to give some thought's for the upcoming batman-adv release, =
especially on compat version 15. This somewhat summarizes my discussion =
with T_X on the wireless community weekend (WCW -- 2013-05-10 - =
2013-05-12). As some of you may know already, we're running a small =
freifunk network in western Germany (K=F6ln-Bonn-area) - about ~100 =
nodes in total; ~40 are online at the moment.
It's not my intention to bash on batman-adv in general or to start =
flame-wars (like: batman-adv vs. olsr or something else) - I'd like to =
provide some statement on the impact of the upcoming protocol changes.

1. The upcoming protocol change appears to be painful - we have no =
suitable migration strategy.
Compat version 14 and 15 will be incompatible. Nodes will loose mesh =
connectivity (to older nodes). Since we cannot upgrade all nodes at =
once, we'll have to run different networks in parallel.
In fact, we're running two networks at the moment (compat 13 and 14). We =
aren't able to upgrade the existing compat 13 nodes in the next months - =
by that, we'll probably have some compat 13 ones for at least 1/2 year. =
There is no way of telling newer nodes to use compat version 13. Since =
some "supernodes" (dedicated servers) are part of the batman-adv cloud, =
we need twice the servers as well.
Upgrading to compat version 15 will require a huge amount of work: New =
infrastructure (servers) must be deployed and nodes meshing with each =
other must be upgraded in parallel.

2. Backwards-compatilibilty doesn't seem to be a design target.
Looking at other routing protocols (BGP-4 - for example) - they provide =
decent ways for protocol extension while still providing backwards =
compatibility for the version specified 7 years ago. Looking at =
batman-adv a lot of protocol changes have been introduced in the past =
years - but no backwards compatibility is there. Eg.
- There will be no flag for using compat 14 version in newer version of =
batman-adv - if 15 is out.
- Nodes using 14 and 15 cannot mesh.
Since batman-adv depends on the kernel (old batman-adv versions won't =
build with recent kernels) using 14 will not be an option in a few =
months: If some router hardware requires recent Kernel / OpenWRT =
releases version 14 might no longer be used.

3. Conclusion
-> Freifunk KBU will not use compat version 15 in the foreseeable future
-> We're aware, that we cannot use version 14 in some months
-> At the point, when 14 becomes unusable (introduced into OpenWRT =
Kernels / release we need -- or Debian), we will almost certainly =
discontinue batman-adv and go one with sth. else. (Due to kernel deps =
it's easier to run batman-adv / olsr in parallel than two different =
version of batman-adv)
-> We'd by very happy if someone forks batman-adv to provide modules for =
recent kernels still using version 14
-> Maybe, some future version of batman-adv addresses =
backwards-compatibility. Maybe, in 2018 we will have a look at =
batman-adv again - noticing, that batman-adv remained stable (or =
migratable) over the last years and start using it again. Maybe, =
batman-adv will fit our needs, then.

Thanks for your time,
greetz, yanosz=
