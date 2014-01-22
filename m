Return-Path: <russell@personaltelco.net>
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com> <86lhy8pn5v.fsf@coulee.tdb.com>
 <52DF7556.9090200@makrotopia.org> <86y527oqpl.fsf_-_@coulee.tdb.com>
 <52E003DD.6040302@meshcoding.com>
From: Russell Senior <russell@personaltelco.net>
Date: Wed, 22 Jan 2014 11:18:09 -0800
In-Reply-To: <52E003DD.6040302@meshcoding.com> (Antonio Quartulli's message of
 "Wed\, 22 Jan 2014 18\:46\:05 +0100")
Message-ID: <86txcvomfi.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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

>>>>> "Antonio" == Antonio Quartulli <antonio@meshcoding.com> writes:

Russell> Has anybody else seen this memory leak?  Leads on where it's
Russell> coming from?  Not a runaway process, at least not that top
Russell> shows up.  Just a gradual disappearance from MemFree that
Russell> /proc/sys/vm/drop_caches doesn't fix.  It isn't adhoc mode,
Russell> and I can associate the two devices over adhoc and move a
Russell> bunch of data with no memory lost, but turning on batman-adv
Russell> seems to sink it.

Russell> The memory leak I see seems to commence as soon as a
Russell> batman-adv neighbor (same version, in this case 15) appears
Russell> and stops when the neighbor goes away.

Antonio> Thank you very much for the hint Russel!  Today I tried with
Antonio> one node only, but kmemleak did not report anything...

Russell> I am going to try enabling kmemleak and see of that tells me
Russell> anything.

Antonio> Thanks! Keep us informed!

Here is a bootlog in which I spit out a bunch of kmemleak stuff into a
console (captured by /usr/bin/screen, sorry for the extraneous line
feed silliness).

  https://personaltelco.net/~russell/kmemleak-batman-from-boot.log

If I count instances, it looks like batadv_orig_node_vlan_new (and the
things that are calling it) may be implicated.

Hope that helps!


-- 
Russell Senior, President
russell@personaltelco.net
