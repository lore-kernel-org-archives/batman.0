Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Tue,  1 Oct 2013 14:02:08 +0200
Message-Id: <1380628934-22220-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] alfred: Allow listening interface to appear/disappear
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

Hi,

a device running alfred maybe has to remove the underlying device (e.g. wlan
device has to be reconfigured). This currently makes it necessary to restart
alfred to get the device sending data again. An unwanted side effect of this
procedure is the removal of all data currently stored in alfred.

Instead alfred should detect such problems and try to recover by reopening the
device after sleeping a while. The sleeping is automatically done by select.

I've tested the changes only using macvtap:

Terminal 1:

$ ip link del dev macvlan0
$ ip link add link eth0 name macvlan0 type macvlan
$ ip link set macvlan0 address 1a:46:0b:ca:bc:7b up
$ ./alfred -b none -i macvlan0

Terminal 2 (after letting alfred run for a while)

$ ip link del dev macvlan0
$ ip link add link eth0 name macvlan0 type macvlan
$ ip link set macvlan0 address 1a:46:0b:ca:bc:7b up

Kind regards,
	Sven

 alfred.h  |  4 ++--
 netsock.c | 16 ++++++++--------
 recv.c    |  3 +++
 send.c    | 27 +++++++++++++++++++++------
 server.c  | 36 +++++++++++++++++++++++++++---------
 5 files changed, 61 insertions(+), 25 deletions(-)
