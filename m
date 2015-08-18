Return-Path: <bittorf@bluebottle.com>
Date: Tue, 18 Aug 2015 10:08:55 +0200
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20150818080855.GD19496@medion.lan>
References: <1439848023.1458.15.camel@nord-west.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1439848023.1458.15.camel@nord-west.org>
Subject: Re: [B.A.T.M.A.N.] Kernel crashes when using more than one
 interface in bat0
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

* Bjoern Franke <bjo@nord-west.org> [18.08.2015 09:47]:
> Unfornately we have no logs now, because after the crashes no ssh
> -access to the servers are possible.

try to set

/sbin/sysctl -w kernel.panic_on_oops=1
/sbin/sysctl -w kernel.panic=10
/sbin/sysctl -w vm.panic_on_oom=2

if the devices crashed (and reboots now) you have
the crash in the file:

/sys/kernel/debug/crashlog

bye, bastian - happy crashing!
