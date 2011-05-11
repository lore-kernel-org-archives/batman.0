Return-Path: <ordex@autistici.org>
Date: Wed, 11 May 2011 02:17:50 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110511001749.GA18190@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] bug - unregister_netdevice: usage_count = 1
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,

I found a bug playing with my interfaces while bat0 was active.
The bug is described here: http://www.open-mesh.org/issues/148
The steps to reproduce it are reported too.

In a few words, when trying to unregister a device by unloading its module,
the modprobe hangs and in the dmesg I can see this message:

unregister_netdevice: waiting for wlan0 to become free. Usage count = 1

I tried to do some tests and what I observed is that
hard_iface->refcount doesn't reach 0. This means that
hard_iface_free_rcu() is never invoked and dev_put() too.

I hope the information are enough..

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
