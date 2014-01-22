Return-Path: <daniel@makrotopia.org>
Message-ID: <52DF7556.9090200@makrotopia.org>
Date: Wed, 22 Jan 2014 08:37:58 +0100
From: Daniel <daniel@makrotopia.org>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com> <86lhy8pn5v.fsf@coulee.tdb.com>
In-Reply-To: <86lhy8pn5v.fsf@coulee.tdb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix soft-interface MTU
 computation
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 01/22/2014 07:04 AM, Russell Senior wrote:
> Has anybody else seen this memory leak?  Leads on where it's coming
> from?  Not a runaway process, at least not that top shows up.  Just a
> gradual disappearance from MemFree that /proc/sys/vm/drop_caches
> doesn't fix.  It isn't adhoc mode, and I can associate the two devices
> over adhoc and move a bunch of data with no memory lost, but turning
> on batman-adv seems to sink it.
Yes, and I tested (compile-time selected) with and without network coding, and
(at run-time) with and without fragmentation (as I also bumped into the MTU
calculation problem later fixed by the patch on this list) -- any 32MB RAM
devices reboots after roughly 30 minutes due to OOM without substantial traffic,
if there is traffic then apparently even faster...
