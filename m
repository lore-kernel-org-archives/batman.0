Return-Path: <nwharton@gmail.com>
MIME-Version: 1.0
Date: Mon, 28 Jun 2010 11:29:53 -0500
Message-ID: <AANLkTimCSkFrm9F7DF6HWBBgo4PCb5qmy6xEmeHGonLl@mail.gmail.com>
From: Nathan Wharton <nwharton@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Multicast video over 2 node mesh
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I am having problems getting multicast video over my 2 node mesh.  I
am building under openwrt and the version is 0.3.0-alpha rv1715.

I have a lan bridge on each side.  If I directly add ath0 to the lan
bridge the video works fine.  But since I want to mesh, I put ath0
into bat0 instead, and then I put bat0 into the bridge.  This works
for all my traffic that put across it so far except the multicast
video.  A tcpdump comparison of both sides shows that after about 32
packets data starts getting dropped.  The video is about 1Mbs.

Given this thousand foot view of the problem, is there something
obvious I might be missing?  I've set the mtu on ath0 to 1524.
Everything else seems to work fine, including copying a file over the
mesh setup that is 20MB at a speed of 578.9KB/s and the md5sum was
right.
