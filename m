Return-Path: <gwirth79@gmail.com>
Message-ID: <4B60DB79.9020407@gmail.com>
Date: Wed, 27 Jan 2010 16:34:01 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] git changes break OpenWRT package
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

It seems that changes made to the git sources have broken OpenWRT
batman-adv package. The OpenWRT package points to:

http://git.open-mesh.org/snapshots

for kernel code. But that directory has been cleaned out. There also
doesn't appear to be any backup packages at:

http://downloads.openwrt.org/sources

Is there any way to put the old snapshots back?

Or since the kernel module can be built from source checked out from
subversion, I guess the batman-adv package can be redone to only use the
subversion code and not any maintenance code. Has anyone done this yet?
I can't tell who created the original package so I suspect it is someone
here.

Gus
