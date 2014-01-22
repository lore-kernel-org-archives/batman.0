Return-Path: <russell@personaltelco.net>
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com> <86lhy8pn5v.fsf@coulee.tdb.com>
 <52DF7556.9090200@makrotopia.org>
From: Russell Senior <russell@personaltelco.net>
Date: Wed, 22 Jan 2014 09:45:42 -0800
In-Reply-To: <52DF7556.9090200@makrotopia.org> (daniel@makrotopia.org's
 message of "Wed\, 22 Jan 2014 08\:37\:58 +0100")
Message-ID: <86y527oqpl.fsf_-_@coulee.tdb.com>
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

>>>>> "Daniel" == Daniel  <daniel@makrotopia.org> writes:

Daniel> On 01/22/2014 07:04 AM, Russell Senior wrote:
>> Has anybody else seen this memory leak?  Leads on where it's coming
>> from?  Not a runaway process, at least not that top shows up.  Just
>> a gradual disappearance from MemFree that /proc/sys/vm/drop_caches
>> doesn't fix.  It isn't adhoc mode, and I can associate the two
>> devices over adhoc and move a bunch of data with no memory lost,
>> but turning on batman-adv seems to sink it.

Daniel> Yes, and I tested (compile-time selected) with and without
Daniel> network coding, and (at run-time) with and without
Daniel> fragmentation (as I also bumped into the MTU calculation
Daniel> problem later fixed by the patch on this list) -- any 32MB RAM
Daniel> devices reboots after roughly 30 minutes due to OOM without
Daniel> substantial traffic, if there is traffic then apparently even
Daniel> faster...

The memory leak I see seems to commence as soon as a batman-adv
neighbor (same version, in this case 15) appears and stops when the
neighbor goes away.

I am going to try enabling kmemleak and see of that tells me anything.


-- 
Russell Senior, President
russell@personaltelco.net
